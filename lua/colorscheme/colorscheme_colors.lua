local M = {}
local hi = require("core").hi
local bg = require("core").bg
local darker = require("core").darker

M.setup = function(colors)
    vim.cmd("hi clear")
    -- if vim.fn.exists("syntax_on") then
    --     vim.cmd("syntax reset")
    -- end
    vim.o.termguicolors = true
    vim.g.colors_name = "nicetheme"

    local b00 = colors.base00
    local b01 = colors.base01
    local b02 = colors.base02
    local b03 = colors.base03
    local b04 = colors.base04
    local b05 = colors.base05
    local b06 = colors.base06
    local b07 = colors.base07
    local b08 = colors.base08 -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    local b09 = colors.base09 -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
    local b0A = colors.base0A -- Classes, Markup Bold, Search Text Background
    local b0B = colors.base0B -- Strings, Inherited Class, Markup Code, Diff Inserted
    local b0C = colors.base0C -- Support, Regular Expressions, Escape Characters, Markup Quotes
    local b0D = colors.base0D -- Functions, Methods, Attribute IDs, Headings
    local b0E = colors.base0E -- Keywords, Storage, Selector, Markup Italic, Diff Changed
    local b0F = colors.base0F -- Deprecated, Opening/Closing Embedded Language Tags
    local trs = "transparent"

    vim.g.terminal_color_0 = M.base00
    vim.g.terminal_color_1 = M.base08
    vim.g.terminal_color_2 = M.base0B
    vim.g.terminal_color_3 = M.base0A
    vim.g.terminal_color_4 = M.base0D
    vim.g.terminal_color_5 = M.base0E
    vim.g.terminal_color_6 = M.base0C
    vim.g.terminal_color_7 = M.base05
    vim.g.terminal_color_8 = M.base03
    vim.g.terminal_color_9 = M.base08
    vim.g.terminal_color_10 = M.base0B
    vim.g.terminal_color_11 = M.base0A
    vim.g.terminal_color_12 = M.base0D
    vim.g.terminal_color_13 = M.base0E
    vim.g.terminal_color_14 = M.base0C
    vim.g.terminal_color_15 = M.base07
    vim.g.terminal_color_background = vim.g.terminal_color_0
    vim.g.terminal_color_foreground = vim.g.terminal_color_5

    hi("Normal", b05, b00)
    hi("Bold", trs, trs)
    hi("Debug", b08, trs)
    hi("Directory", b0D, trs)
    hi("Error", b00, b08)
    hi("ErrorMsg", b08, b00)
    hi("Exception", b08, trs)
    hi("FoldColumn", b0C, b01)
    hi("Folded", b03, b01)
    hi("IncSearch", b01, b09)
    hi("Italic", trs, trs)
    hi("Macro", b08, trs)
    hi("MatchParen", trs, b03)
    hi("ModeMsg", b0B, trs)
    hi("MoreMsg", b0B, trs)
    hi("Question", b0D, trs)
    hi("Search", b01, b0A)
    hi("Substitute", b01, b0A)
    hi("SpecialKey", b03, trs)
    hi("TooLong", b08, trs)
    hi("Underlined", b08, trs)
    hi("Visual", trs, b02)
    hi("VisualNOS", b08, trs)
    hi("WarningMsg", b08, trs)
    hi("WildMenu", b08, b0A)
    hi("Title", b0D, trs)
    hi("Conceal", b0D, b00)
    hi("Cursor", b00, b05)
    hi("NonText", b03, trs)
    hi("LineNr", b03, b00)
    hi("SignColumn", b03, b00)
    hi("StatusLine", b04, b02)
    hi("StatusLineNC", b03, b01)
    hi("VertSplit", b02, b02)
    hi("ColorColumn", trs, b01)
    hi("CursorColumn", trs, b01)
    hi("CursorLine", trs, darker(b00, 5))
    hi("CursorLineNr", b04, darker(b00, 5))
    hi("QuickFixLine", trs, b01)
    hi("PMenu", b05, b01)
    hi("PMenuSel", b01, b05)
    hi("TabLine", b03, b01)
    hi("TabLineFill", b03, b01)
    hi("TabLineSel", b0B, b01)

    hi("Boolean", b0E, trs)
    hi("Character", b0E, trs)
    hi("Comment", b03, trs)
    hi("Conditional", b08, trs)
    hi("Constant", b0E, trs)
    hi("Define", b0C, trs)
    hi("Delimiter", b09, trs)
    hi("Float", b0E, trs)
    hi("Function", b0B, trs)
    hi("Identifier", b0D, trs)
    hi("Include", b0C, trs)
    hi("Keyword", b08, trs)
    hi("Label", b08, trs)
    hi("Number", b0E, trs)
    hi("Operator", b0C, trs)
    hi("PreProc", b0C, trs)
    hi("Repeat", b08, trs)
    hi("Special", b09, trs)
    hi("SpecialChar", b08, trs)
    hi("Statement", b08, trs)
    hi("StorageClass", b09, trs)
    hi("String", b0B, trs)
    hi("Structure", b0C, trs)
    hi("Tag", b09, trs)
    hi("Todo", b0A, b01)
    hi("Type", b0A, trs)
    hi("Typedef", b0A, trs)

    hi("DiffAdd", b0B, b01)
    hi("DiffChange", b03, b01)
    hi("DiffDelete", b08, b01)
    hi("DiffText", b0D, b01)
    hi("DiffAdded", b0B, b00)
    hi("DiffFile", b08, b00)
    hi("DiffNewFile", b0B, b00)
    hi("DiffLine", b0D, b00)
    hi("DiffRemoved", b08, b00)

    require("colorscheme.colorscheme_static").setup(colors)

    -- local function handleSpecial(hiGroup)
    --     if colors[hiGroup] ~= nil then
    --         hi(hiGroup, colors[hiGroup], trs)
    --     end
    -- end

    if colors.special ~= nil then
        for key, value in pairs(colors.special) do
            hi(key, value, trs)
        end
    end

    if colors.specialbg ~= nil then
        for key, value in pairs(colors.specialbg) do
            bg(key, value)
        end
    end

    -- handleSpecial("Function")

end

return M
