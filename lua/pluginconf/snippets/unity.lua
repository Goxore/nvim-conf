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

return {
    s("uc", {
        t("using System.Collections;"),
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
    }),

    s("ud", {
        t("using System.Collections;", ""),
        t({ "", "" }),
        t("using System.Collections.Generic;"),
        t({ "", "" }),
        t("using UnityEngine;"),
    }),

    s("dl", {
        t("Debug.Log("), i(1), t(");")
    }),

    s("dlo", fmt([[Debug.Log($"<color=green>{}</color>: {{{}}}", {});]], { rep(1), i(1), rep(1) })),
    s("dlv", fmt([[Debug.Log($"<color=cyan>{}</color>: {{{}}}");]], { rep(1), i(1) })),

    -- s("dlv", fmt("Debug.LogFormat(\"<color=cyan>{{1}}</color>: {{0}}\", {}, \"{}\");", { i(1), rep(1) })),

    s("dlvc", fmt("Debug.Log({}<color={}>{}{}{}{}</color>{});",
        {
            "$\"",
            c(1, { t("red"), t("green"), t("blue"), t("cyan"), t("magenta") }),
            rep(2),
            ": {",
            i(2),
            "}",
            "\""
        })),

    s("h1", {
        t("// ----"), f(text_present, { 1 }), i(1), f(cslinefn, { 1 }),
    }),

    s("dh1", {
        t("Debug.Log(\"----"), f(text_present, { 1 }), i(1), f(cslinefn, { 1 }), t("\");")
    }),

    s("///", f(function(_, _)
        vim.cmd("Neogen")
    end, {})),

    s("List", {
        t("List<"), i(1), t("> "), i(2, "list"), t(" = new List<"), rep(1), t(">("), i(3), t(");")
    }),
}
