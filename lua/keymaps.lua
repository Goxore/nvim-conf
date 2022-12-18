local opts = { noremap = true, silent = true }
local optsnowait = { noremap = true, silent = true, nowait = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- general
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- keymap("n", "<C-d>", "<C-d>zz", opts)
-- keymap("n", "<C-u>", "<C-u>zz", opts)

keymap("x", "<leader>p", "\"_dp", opts)

keymap("i", "<M-h>", "<Left>", opts)
keymap("i", "<M-l>", "<Right>", opts)

-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)
keymap("n", "<A-w>", "<C-w><C-w>", opts)
keymap('n', "<A-f>", "<cmd>WindowsMaximize<CR>", opts)

keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)

keymap("n", "<esc><esc>", "<cmd>:noh<return>", opts)

--folds
keymap("n", "z{", "zfi{", opts)
keymap("n", "z(", "zfi(", opts)

-- Tab navigation without bufferline
-- keymap("n", "<A-1>", "1gt", opts)
-- keymap("n", "<A-2>", "2gt", opts)
-- keymap("n", "<A-3>", "3gt", opts)
-- keymap("n", "<A-4>", "4gt", opts)
-- keymap("n", "<A-5>", "5gt", opts)
-- keymap("n", "<A-6>", "6gt", opts)
-- keymap("n", "<A-7>", "7gt", opts)
-- keymap("n", "<A-8>", "8gt", opts)
-- keymap("n", "<A-9>", "9gt", opts)

-- Buffers
keymap("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>", opts)

keymap("n", "<leader>h", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>H", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)

--close Buffer
keymap("n", "<C-w>", "<cmd>BufDel<CR>", opts)
-- keymap("n", "<C-w>", "<cmd>NeoNoNameBufferline<CR>", optsnowait)

-- Resize windows
keymap("n", "<C-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-l>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-k>", ":resize -2<CR>", opts)
keymap("n", "<C-j>", ":resize +2<CR>", opts)


-- Nvim Tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", opts)
keymap("n", "<leader>N", ":NvimTreeFindFile<CR>", opts)

-- UndoTree
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- Terminal
keymap("t", "<esc>", [[<C-\><C-n>]], opts)
keymap("n", "<leader>G", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
keymap("n", "<leader>t", "<cmd>lua _MYTERM_TOGGLE()<CR>", { noremap = true, silent = true })
keymap("t", "<A-h>", [[<C-\><C-n><C-W>h]], opts)
keymap("t", "<A-j>", [[<C-\><C-n><C-W>j]], opts)
keymap("t", "<A-k>", [[<C-\><C-n><C-W>k]], opts)
keymap("t", "<A-l>", [[<C-\><C-n><C-W>l]], opts)

-- snippet
keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/luasnipconf.lua<CR>", opts)

-- preview
keymap("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
keymap("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementationn()<CR>", opts)

-- git signs
keymap("n", "]c", "<cmd>Gitsigns next_hunk<CR>", opts)
keymap("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", opts)
keymap("n", "ghp", "<cmd>Gitsigns preview_hunk<CR>", opts)
keymap("n", "ghu", "<cmd>Gitsigns reset_hunk<CR>", opts)
keymap("n", "ghb", "<cmd>Gitsigns blame_line<CR>", opts)
keymap("n", "vih", "<cmd>Gitsigns select_hunk<CR>", opts)

keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>", opts)
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
keymap("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)

-- Special
keymap("n", "<leader>yp", "<cmd>:let @+ = expand('%:p')<CR>", opts)
