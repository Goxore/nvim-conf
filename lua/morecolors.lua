local fg = require("core").fg
local bg = require("core").bg
local hi = require("core").hi
local getFg = require("core").getFg
local getBg = require("core").getBg
local darker = require("core").darker
local syscolors = require("systemcolors")
local style = require("core").style

local M = {}

function M.update()

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
    --
    bg("NvimTreeNormal", darker(bgcolor, -5))
    hi("NvimTreeWinSeparator", darker(bgcolor, -5), darker(bgcolor, -5))

    fg("NvimTreeSpecialFile", red)
    fg("NvimTreeImageFile", yellow)

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
    fg('@tag', red)
    fg('@tag.delimiter', red)
    fg('@text', fgcolor)
    fg('@none', fgcolor)

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
    fg('LspSagaSignatureHelpBorder', yellow)

    -- Telescope
    fg("TelescopeBorder", red)
    fg("TelescopePromptBorder", cyan)
    fg("TelescopeResultsBorder", cyan)
    fg("TelescopePreviewBorder", cyan)
    fg("TelescopeMatching", orange)
    style("TelescopeMatching", "bold")
    fg("TelescopePromptPrefix", green)
    -- bg("TelescopeSelection",  })
    fg("TelescopeSelectionCaret", yellow)

    -- Vimwiki
    fg("VimwikiMarkers", blue)
    fg("VimwikiHeader1", yellow)
    fg("VimwikiHeader2", magenta)
    fg("VimwikiHeader3", red)
    fg("VimwikiLink", green)

    -- LuaLine
    hi("lualine_a_visual", bgcolor, orange)
    hi("lualine_a_normal", bgcolor, blue)
    hi("lualine_a_insert", bgcolor, green)
    hi("lualine_a_command", bgcolor, magenta)
    hi("lualine_a_replace", bgcolor, magenta)

    hi("lualine_b_visual", fgcolor, darker(bgcolor, -10))
    hi("lualine_b_normal", fgcolor, darker(bgcolor, -10))
    hi("lualine_b_insert", fgcolor, darker(bgcolor, -10))
    hi("lualine_b_command", fgcolor, darker(bgcolor, -10))
    hi("lualine_b_replace", fgcolor, darker(bgcolor, -10))

    hi("lualine_c_visual",   fgcolor, bgcolor)
    hi("lualine_c_normal",   fgcolor, bgcolor)
    hi("lualine_c_insert",   fgcolor, bgcolor)
    hi("lualine_c_command",  fgcolor, bgcolor)
    hi("lualine_c_replace",  fgcolor, bgcolor)

end

M.update()
-- M.bgcolor = require("core").getBg("Normal")
-- M.fgcolor = require("core").getFg("Normal")
-- M.orange = require("core").getFg("Special")
-- M.red = require("core").getFg("Keyword")
-- M.green = require("core").getFg("Function")
-- M.blue = require("core").getFg("Conceal")
-- M.cyan = require("core").getFg("Identifier")
-- M.yellow = require("core").getFg("Type")
-- M.magenta = require("core").getFg("Boolean")

return M
