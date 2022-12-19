local setcolors = require("colorscheme.colorscheme_colors").setup
local setstatic = require("colorscheme.colorscheme_static").setup
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
-- local bg = require("core").bg

local M = {}

local mini_layout = {
    layout_strategy = "vertical",
    layout_config = {
        height = 15,
        width = 0.3,
        prompt_position = "top"
    },

    sorting_strategy = "ascending"
}

local function enter(prompt_bufnr)
    local selected = action_state.get_selected_entry()
    colorscheme_global = selected[1]
    -- setcolors(require("colorscheme.colorscheme_colors." .. selected[1]))
    vim.cmd("colorscheme nicetheme")
    actions.close(prompt_bufnr)
end

local opts = {
    finder = finders.new_table { "gruvbox", "onedark", "tokyonight", "tokyonight_diff", "everforest", "dracula", "code", "catpuccin", "nord", "oxocarbon" },
    sorter = sorters.get_generic_fuzzy_sorter({}),

    attach_mappings = function(prompt_bufnr, map)
        map("i", "<CR>", enter)
        return true
    end,
}


local colors = pickers.new(mini_layout, opts)

M.select_colorscheme = function()
    colors:find()
end

return M
