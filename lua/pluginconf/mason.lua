local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

local lspconfig = require("lspconfig")
local opts = { noremap = true, silent = true }
local bufmap = vim.api.nvim_buf_set_keymap

mason.setup()
require("mason-lspconfig").setup()


vim.cmd [[
autocmd! CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
sign define DiagnosticSignError text=▌ texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text=▌ texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text=▌ texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text=▌ texthl=DiagnosticSignHint linehl= numhl=
]]

local on_attach = function(client, bufnr)
    bufmap(bufnr, 'n', 'gu', '<cmd>Telescope lsp_references<CR>', opts)
    bufmap(bufnr, 'n', '<space>F', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
    bufmap(bufnr, 'n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    bufmap(bufnr, 'n', 'gE', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    bufmap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    bufmap(bufnr, 'n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    bufmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    bufmap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
end

local omnisharp_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    bufmap(bufnr, 'n', 'gd', "<cmd>lua require('omnisharp_extended').lsp_definitions()<cr>", opts)
end

require("mason-lspconfig").setup_handlers({

    function(server_name)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach
        }
    end,

    ["rust_analyzer"] = function()
        require("rust-tools").setup {
            server = {
                on_attach = on_attach
            }
        }
    end,

    ["omnisharp"] = function()
        lspconfig.omnisharp.setup {
            handlers = {
                ["textDocument/definition"] = require('omnisharp_extended').handler,
            },
            filetypes = { "cs", "vb" },
            root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln"),
            on_attach = omnisharp_on_attach,
            capabilities = capabilities,
        }
    end,

    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                        path = {
                            '?/init.lua',
                            '?.lua'
                        }
                    },
                    workspace = {
                        library = {
                            '/usr/share/nvim/runtime/lua',
                            '/usr/share/nvim/runtime/lua/lsp',
                            '/usr/share/awesome/lib'
                        }
                    },
                    completion = {
                        enable = true,
                        callSnippet = "Replace"
                    },
                    diagnostics = {
                        enable = true,
                        globals = { 'vim', 'awesome', 'client', 'root' }
                    },
                    telemetry = {
                        enable = false
                    }
                }
            },
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
})
