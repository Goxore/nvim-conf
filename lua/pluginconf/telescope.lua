local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require("telescope.actions")

telescope.setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        ["<C-h>"] = "which_key",

        ["<C-j>"] = {
          actions.move_selection_next, type = "action",
          opts = { nowait = true, silent = true }
        },

        ["<C-k>"] = {
          actions.move_selection_previous, type = "action",
          opts = { nowait = true, silent = true }
        },
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- telescope.load_extension('fzf')
