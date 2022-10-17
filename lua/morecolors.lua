local fg = require("core").fg
local bg = require("core").bg
local hi = require("core").hi
local getFg = require("core").getFg
local getBg = require("core").getBg
local darker = require("core").darker
local syscolors = require("systemcolors")
local style = require("core").style

local M = {}

local bgcolor = require("core").getBg("Normal")
local fgcolor = require("core").getFg("Normal")
local orange = require("core").getFg("Special")
local red = require("core").getFg("Keyword")
local green = require("core").getFg("Function")
local blue = require("core").getFg("Conceal")
local cyan = require("core").getFg("Identifier")
local yellow = require("core").getFg("Type")
local magenta = require("core").getFg("Boolean")

vim.cmd [[
set laststatus=3
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾
" set fillchars=fold:\ ,vert:\▎,eob:\ ,msgsep:‾
" set fillchars=fold:\ ,vert:\ ,eob:\ ,msgsep:\ 

]]

bg("SignColumn", "transparent")
bg("WinSeparator", "transparent")
fg("WinSeparator", darker(bgcolor, -10))

fg("CmpItemAbbrMatch", blue)
fg("CmpItemAbbrMatchFuzzy", magenta)

fg("CmpItemKindVariable", green)
fg("CmpItemKindInterface", yellow)
fg("CmpItemKindText", blue)

fg("CmpItemKindFunction", red)
fg("CmpItemKindMethod", yellow)

fg("CmpItemKindKeyword", orange)
fg("CmpItemKindProperty", magenta)
fg("CmpItemKindUnit", magenta)


bg("SignColumn", "transparent")
bg("WinSeparator", "transparent")

fg("WinSeparator", darker(bgcolor, -10))

-- nvimTree
bg("NvimTreeNormal", darker(bgcolor, -5))
bg("NvimTreeWinSeparator", darker(bgcolor, -5))
fg("NvimTreeWinSeparator", darker(bgcolor, -5))

fg("AlphaHeader", yellow)
fg("AlphaButtons", green)
fg("AlphaButtonsShortcut", bgcolor)
bg("AlphaButtonsShortcut", blue)

bg("BufferLineFill", darker(bgcolor, 20))

fg("Search", fgcolor)
bg("Search", darker(bgcolor, -20))

hi("DiagnosticWarn", darker(orange, 5), "transparent")
hi("DiagnosticHint", darker(fgcolor, -5), "transparent")
hi("DiagnosticError", darker(red, -5), "transparent")
hi("DiagnosticInfo", darker(blue, -5), "transparent")


hi('GitSignsAdd   ', green, "transparent")
hi('GitSignsChange', blue, "transparent")
hi('GitSignsDelete', red, "transparent")
hi('GitSignsDelete', red, "transparent")

-- fg('lualine_b_diff_added_normal', green)
-- fg('lualine_b_diff_modified_normal', blue)
-- fg('lualine_b_diff_removed_normal', red)

style("String", "italic")
style("Comment", "italic")
style("Function", "bold")

-- Treesitter
fg('@variable', getFg('@field'))

-- Treesitter legacy (needed for some plugins)
fg('TSBoolean', getFg('@boolean'))
fg('TSCharacter', getFg('@character'))
fg('TSComment', getFg('@comment'))
fg('TSConditional', getFg('@conditional'))
fg('TSConstant', getFg('@constant'))
fg('TSType', getFg('@type'))
fg('TSField', getFg('@field'))
fg('TSFunction', getFg('@function'))
fg('TSString', getFg('@string'))
fg('TSKeyword', getFg('@keyword'))
fg('TSInclude', getFg('@include'))

-- LspSaga
fg('LspSagaHoverBorder', yellow)
fg('LspSagaRenameBorder', magenta)
hi('LspSagaLightBulb', fgcolor, "transparent")
fg('LspSagaCodeActionBorder', magenta)
fg('LspSagaCodeActionContent', blue)
fg('LspSagaCodeActionContent', blue)

M.bgcolor = bgcolor
M.fgcolor = fgcolor
M.orange = orange
M.red = red
M.green = green
M.blue = blue
M.cyan = cyan
M.yellow = yellow
M.magenta = magenta

return M
