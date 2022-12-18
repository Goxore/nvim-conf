local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return require('packer').startup(function(use)
    -- packer
    use("wbthomason/packer.nvim")

    -- numbers are good
    use('lewis6991/impatient.nvim')


    -- main dependencies
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")


    -- luasnip
    use("l3mon4d3/luasnip")

    -- cmp
    use("hrsh7th/nvim-cmp")
    use("rafamadriz/friendly-snippets")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("folke/neodev.nvim")

    -- coq
    -- use("ms-jpq/coq_nvim")
    -- use("ms-jpq/coq.artifacts")
    -- use("ms-jpq/coq.thirdparty")

    -- null-ls
    use("jose-elias-alvarez/null-ls.nvim")

    -- autopairs
    use("windwp/nvim-autopairs")

    -- peek definition
    use {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {}
        end
    }

    -- CDs into root folder of the project
    use {
        "ahmedkhalf/lsp-rooter.nvim",
        config = function()
            require("lsp-rooter").setup {}
        end
    }

    -- Symbols
    use {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup {}
        end,
        cmd = "SymbolsOutline"
    }

    -- nice git signs
    use("lewis6991/gitsigns.nvim")

    -- notifications
    use("rcarriga/nvim-notify")

    -- lua line
    use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' }

    use('kyazdani42/nvim-web-devicons')

    -- bufferline
    use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons' }

    use { 'ojroques/nvim-bufdel' }

    -- better buffer delete
    -- use {
    --   'nyngwang/NeoNoName.lua',
    --   config = function ()
    --     -- vim.keymap.set('n', '<C-w>', function () vim.cmd('NeoNoName') end, {slient=true, noremap=true, nowait=true})
    --     -- If you are using bufferline.nvim
    --     -- vim.keymap.set('n', '<C-w>', function () vim.cmd('NeoNoNameBufferline') end, {slient=true, noremap=true, nowait=true})
    --   end
    -- }

    -- icons
    -- use("ryanoasis/vim-devicons")

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- LaTeX
    use {
        "lervag/vimtex",
        ft = "tex"
    }

    use {
        "xuhdev/vim-latex-live-preview",
        ft = "tex"
    }

    use {
        "ferrine/md-img-paste.vim",
    }

    -- Vim viki
    use("vimwiki/vimwiki")

    -- more git
    use("tpope/vim-fugitive")

    -- comments
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- menu
    use('goolord/alpha-nvim')

    -- file manager
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons',
    }

    -- Toggle terminal
    use("akinsho/toggleterm.nvim")

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter")
    use("nvim-treesitter/nvim-treesitter-textobjects")

    use {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle"
    }
    -- use("nvim-treesitter/nvim-treesitter-context")

    -- Lsp
    use("neovim/nvim-lspconfig")

    -- Lsp additional features
    use("glepnir/lspsaga.nvim")

    -- generate documentation
    use {
        "danymat/neogen",
        config = function()
            require("neogen").setup {
                enabled = true,
                languages = {
                    cs = {
                        template = {
                            annotation_convention = "xmldoc"
                        }
                    }
                }
            }
        end,
        cmd = "Neogen"
    }

    -- lsp installer
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }

    -- omnisharp
    use("Hoffs/omnisharp-extended-lsp.nvim")

    -- syntax for .yuck files
    use {
        "elkowar/yuck.vim",
        ft = "yuck"
    }

    -- lsp signatures
    use("ray-x/lsp_signature.nvim")

    -- lsp and debugging
    use {
        "mfussenegger/nvim-dap",
        -- cmd = "DapContinue"
    }

    use {
        "rcarriga/nvim-dap-ui",
        config = function()
            require("dapui").setup()
        end,
        cmd = [[lua require("dapui").open()]]
    }

    use {
        "theHamsta/nvim-dap-virtual-text",
        -- cmd = "DapContinue"
    }

    -- rust language server improvements
    use {
        "simrat39/rust-tools.nvim",
        -- ft = "rust"
    }

    -- inlay hints that somewhat work sometimes
    use("shurizzle/inlay-hints.nvim")

    -- lsp colors
    use('folke/lsp-colors.nvim')

    -- vim autoformatter
    use("vim-autoformat/vim-autoformat")

    -- luapad
    use {
        "rafcamlet/nvim-luapad",
        cmd = "Luapad"
    }

    -- transtaion plugin
    use {
        "uga-rosa/translate.nvim",
        cmd = "Translate"
    }

    -- git diff
    use {
        "sindrets/diffview.nvim",
        cmd = "DiffviewOpen"
    }

    -- color stuff
    use { "ziontee113/color-picker.nvim",
        config = function()
            require("color-picker").setup()
        end,
    }

    use { "norcalli/nvim-colorizer.lua",
        config = function()
            require 'colorizer'.setup {
                'css',
                'javascript',
                'lua',
                html = {
                    mode = 'foreground';
                }
            }
        end,
        ft = { "html", "css", "javascript", "typescript", "svelte", "lua", "yaml", "xml" }
    }

    use { "eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton"
    }

    use {
        'lukas-reineke/headlines.nvim',
        config = function()
            require('headlines').setup {
                markdown = {
                    fat_headline_upper_string = "▄", -- ▃
                    fat_headline_lower_string = "▀",
                },
            }
        end,
    }

    -- sessions
    -- use {
    --     'rmagatti/auto-session',
    --     config = function()
    --         require("auto-session").setup {
    --             log_level = "error",
    --             auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    --         }
    --     end
    -- }
    --
    -- use {
    --   'rmagatti/session-lens',
    --   requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    --   config = function()
    --     require('session-lens').setup({--[[your custom config--]]})
    --   end
    -- }

    -- lsp fidget
    -- use { "j-hui/fidget.nvim",
    --     config = function()
    --         require "fidget".setup {}
    --     end
    -- }

    use { "anuvyklack/windows.nvim",
        requires = "anuvyklack/middleclass"
    }

    use "toppair/reach.nvim"

    use "mbbill/undotree"

    -- use {
    --     "folke/which-key.nvim",
    --     config = function()
    --         require("which-key").setup {}
    --     end
    -- }

    -- noice
    -- use({
    --   "folke/noice.nvim",
    --   config = function()
    --     require("noice").setup()
    --   end,
    --   requires = {
    --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --     "MunifTanjim/nui.nvim",
    --     -- OPTIONAL:
    --     --   `nvim-notify` is only needed, if you want to use the notification view.
    --     --   If not available, we use `mini` as the fallback
    --     "rcarriga/nvim-notify",
    --     }
    -- })

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
