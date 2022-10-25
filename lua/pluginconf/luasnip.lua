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
    update_events = "TextChanged,TextChangedI",
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

vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-n>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- ls.snippets = {
--   all = {
--     s("trigger", { t("Wow! Text!") })
--   },
--   lua = {
--     ls.parser.parse_snippet("test", "--this is $1 a test"),
--   },
-- }


ls.add_snippets("all", {
    s("ternary", {
        -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
        i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    }, { type = "autosnippets" }),
})

ls.add_snippets("lua", {
    s("test", fmt("local {} = require('{}')", { i(1), rep(1) })),
})


ls.add_snippets("all", {
    s("autotrigger", { t("autosnippet"), }),
}, {
    type = "autosnippets",
    key = "all_auto",
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
ls.add_snippets("cs", {
    s("dlv", fmt("Debug.Log({}{}{}{}{});", { "$\"", rep(1), ": {", i(1), "}\"" }))
})

ls.add_snippets("cs", {
    s("dlvc", fmt("Debug.Log({}<color={}>{}{}{}{}</color>{});",
        {
            "$\"",
            c(1, { t("red"), t("green"), t("blue"), t("cyan"), t("magenta") }),
            rep(2),
            ": {",
            i(2),
            "}",
            "\""
        }))
})

ls.add_snippets("cs", {
    s("scls", {
        -- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
        c(1, {
            t("public "),
            t("private "),
        }),
        t("class "),
        i(2),
        t(" "),
        c(3, {
            t("{"),
            -- sn: Nested Snippet. Instead of a trigger, it has a position, just like insertNodes. !!! These don't expect a 0-node!!!!
            -- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
            sn(nil, {
                t("extends "),
                -- restoreNode: stores and restores nodes.
                -- pass position, store-key and nodes.
                r(1, "other_class", i(1)),
                t(" {"),
            }),
            sn(nil, {
                t("implements "),
                -- no need to define the nodes for a given key a second time.
                r(1, "other_class"),
                t(" {"),
            }),
        }),
        t({ "", "\t" }),
        i(0),
        t({ "", "}" }),
    })
})

ls.add_snippets("cs", {
    s("uc", {
        t("using System.Collections;"),
        -- t({"","\t"}),
        t({ "", "" }),
        t("using System.Collections.Generic;"),
        t({ "", "" }),
        t("using UnityEngine;"),
        t({ "", "" }),
        t({ "", "" }),
        t("public class "), i(1), t("", "\t"),
        t({ "", "" }),
        t("{"),
        t({ "", "\t" }),
        i(0),
        t({ "", "" }),
        t({ "}" })
    })
})

ls.add_snippets("cs", {
    s("//--", {
        t("// ------------------------------------------")
    })
}
    , {
    type = "autosnippets",
    key = "cs",
}
)


ls.add_snippets("cs", {
    s("//- ", {
        t("// --------------------- "), i(1), t(" ---------------------")
    })
}
    , {
    type = "autosnippets",
    key = "cs",
}
)

ls.add_snippets("cs", {
    s("dl", {
        t("Debug.Log("), i(1), t(");")
    })
})

ls.add_snippets("cs", {
    s("///", f(function (_, _)
        vim.cmd("Neogen")
    end, {}))
})

ls.add_snippets("cs", {
    s("List", {
        t("List<"), i(1), t(">"), i(2), t(" = new List<"), rep(1), t(">("), i(3), t(");")
    })
})
