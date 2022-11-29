local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
    history = true,
    update_events = "InsertEnter,InsertLeave",
    delete_check_events = "TextChanged",
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "choiceNode", "Comment" } },
            },
        },
    },
    ext_base_prio = 300,
    ext_prio_increase = 1,
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
    ft_func = function()
        return vim.split(vim.bo.filetype, ".", true)
    end,
})

vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-n>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- languages and frameworks --
ls.add_snippets("cs", require("pluginconf.snippets.unity"))


ls.add_snippets("all", {
    s("ternary", {
        -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
        i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    }, { type = "autosnippets" }),
})


ls.add_snippets("tex", {
    s("beg", {
        t("\\begin{"), i(1), t("}"),
        t({ "", "\t" }), i(0),
        t({ "", "\\end{" }), rep(1), t("}"),
    })
}
    , {
    type = "autosnippets",
    key = "tex",
}
)

ls.add_snippets("tex", {
    s("im", {
        t("\\("), i(1), t("\\)"), i(0)
    })
})

ls.add_snippets("tex", {
    s("dm", {
        t("\\["),
        t({ "", "\t" }), i(1),
        t({ "", "\\]" }), i(0),
    })
})

-- CSharp


local function text_present(args, _, _)

    local arg_length = string.len(args[1][1])

    if (arg_length > 0) then
        return (" ")
    else
        return ("-")
    end
end

local function cslinefn(args, _, _)

    local arg_length = string.len(args[1][1])
    local newstring = ""

    if (arg_length == 0) then
        for _ = 0, 40, 1 do
            newstring = newstring .. '-'
        end
        return newstring
    end

    for _ = 0, (39 - arg_length), 1 do
        newstring = newstring .. '-'
    end

    return (" " .. newstring)
end

-- vimWiki
local function fn(args, _, _)

    local arg_length = string.len(args[1][1])
    local newstring = ""

    for i = 0, (41 - arg_length), 1 do
        newstring = newstring .. '='
    end

    if (args[1][1]:sub(-1) == ":") then
        return ""
    end
    return (" " .. newstring .. " #")
end

ls.add_snippets("vimwiki", {
    s("h1", {
        t("# ===== "), i(1), f(fn, { 1 }),
    })
})

ls.add_snippets("vimwiki", {
    s("h2", {
        t("## ==== "), i(1), f(fn, { 1 }),
    })
})

ls.add_snippets("vimwiki", {
    s("h3", {
        t("### === "), i(1), f(fn, { 1 }),
    })
})


ls.add_snippets("vimwiki", {
    s("!f", {
        t("!["), i(1), t("](file:"), i(2), t(")")
    })
})

ls.add_snippets("vimwiki", {
    s("!", {
        t("!["), i(1), t("]("), i(2), t(")")
    })
})

-- NEW STUFF

local function smart_heading(args, _, user_args)

    local text_length = string.len(args[1][1])
    local newstring = ""

    if user_args.compensate == true then
        local is_even = text_length - math.floor(text_length / 2) * 2
        if is_even == 1 then
            newstring = newstring .. user_args.symbol
        end
    end

    for _ = 0, ((user_args.count - text_length) / 2 - 3), 1 do
        newstring = newstring .. user_args.symbol
    end

    if user_args.compensate then
        return (' ' .. newstring .. user_args.outer)
    else
        return (user_args.outer .. newstring .. ' ')
    end
end

local function smart_heading_line(args, _, user_args)

    local text_length = string.len(args[1][1])
    local newstring = ""

    if text_length < user_args.count then
        for _ = 0, (user_args.count - 1), 1 do
            newstring = newstring .. user_args.symbol
        end
    else
        for _ = 0, (text_length + 3), 1 do
            newstring = newstring .. user_args.symbol
        end
    end

    return (newstring)
end

ls.add_snippets("cs", {
    s("H1", {
        t("// "), f(smart_heading_line, { 1 }, { user_args = { { symbol = '=', count = 64 } }, }), t(" //"),
        t({ "", "" }),
        t("// "),
        f(smart_heading, { 1 }, { user_args = { { compensate = false, symbol = ' ', count = 64, outer = '=' } }, }),
        i(1),
        f(smart_heading, { 1 }, { user_args = { { compensate = true, symbol = ' ', count = 64, outer = '=' } } }),
        t(" //"),
        t({ "", "" }),
        t("// "), f(smart_heading_line, { 1 }, { user_args = { { symbol = '=', count = 64 } }, }), t(" //"),
    })
})

ls.add_snippets("cs", {
    s("H2", {
        t("// "),
        f(smart_heading, { 1 }, { user_args = { { compensate = false, symbol = '=', count = 64, outer = '=' } }, }),
        i(1),
        f(smart_heading, { 1 }, { user_args = { { compensate = true, symbol = '=', count = 64, outer = '=' } } }),
        t(" //"),
    })
})

ls.add_snippets("cs", {
    s("H3", {
        t("// "),
        f(smart_heading, { 1 }, { user_args = { { compensate = false, symbol = '-', count = 64, outer = '-' } }, }),
        i(1),
        f(smart_heading, { 1 }, { user_args = { { compensate = true, symbol = '-', count = 64, outer = '-' } } }),
        t(" //"),
    })
})
