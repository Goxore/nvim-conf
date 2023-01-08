local status_ok, toggleterm = pcall(require, "toggleterm")

local core = require("core")

local keymap = vim.api.nvim_set_keymap

if not status_ok then
    return
end

toggleterm.setup {
    direction = "float",
    -- direction = "horizontal",
    shade_terminals = false,
    persist_size = false,
    float_opts = {
        border = 'curved'
    },
    highlights = {
        -- Normal = {
        --   guibg = core.darker(colors.bgcolor, 10)
        -- },
        NormalFloat = {
            link = 'Normal'
        },
        -- FloatBorder = {
        --   guifg = colors.darker(colors.bgcolor, 10),
        --   guibg = colors.darker(colors.bgcolor, 10)
        -- },
    },
}

function _G.set_terminal_keymaps()
    local opts = { noremap = true, silent = true }
    keymap('t', '<C-w>', '<cmd>lua _MYTERM_TOGGLE()<CR>', opts)
    -- keymap('t', '<C-c>', '<cmd>lua _MYTERM_TOGGLE()<CR>', opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local opts = { noremap = true, silent = true }

local close_terminal = function(term)
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
end

local myterm = Terminal:new({
    hidden = true,
    on_open = function(term)
        close_terminal(term)
    end,
})

local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "double",
    },
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    on_close = function(term)
        vim.cmd("startinsert!")
    end,
})

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

function _MYTERM_TOGGLE()
    myterm:toggle()
end
