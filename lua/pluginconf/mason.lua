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
    bufmap(bufnr, 'v', '<space>F', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    bufmap(bufnr, 'n', '<space>le', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    bufmap(bufnr, 'n', 'gE', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    bufmap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    bufmap(bufnr, 'n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    bufmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    bufmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    bufmap(bufnr, 'n', '<leader>gd', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
    bufmap(bufnr, 'n', '<leader>gD', '<cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>', opts)

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References",
        })
    end
end

local omnisharp_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    bufmap(bufnr, 'n', 'gd', "<cmd>lua require('omnisharp_extended').lsp_definitions()<cr>", opts)
end

-- standalone lsp
require'lspconfig'.gdscript.setup{}

-- Mason lsp
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
            -- because I have no idea how else I am supposed to get root dir of projects without git
            root_dir = lspconfig.util.root_pattern(".git", ".projroot"),
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
})
