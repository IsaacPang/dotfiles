-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig
-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua
--[[
Language servers setup:
For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

| Language              | Language Server            | Linter   | Formatter    |
| ----                  | ----                       | ----     | ----         |
| Bash                  | bash-language-server       |          | beautysh     |
| Python                | ruff-lsp                   |          | black, isort |
| C-C++                 | clangd                     |          | clang-format |
| HTML/CSS              | html-lsp                   |          | prettierd    |
| JSON                  | json-lsp                   |          | prettierd    |
| JavaScript/TypeScript | typescript-language-server |          | prettierd    |
| Lua                   | lua-language-server        | luacheck | luaformatter |
| Rust                  | rust-analyzer              |          | rustfmt      |

install LSPs with Mason (:MasonInstall <server/linter/formatter>)
]] --
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then return end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then return end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then return end

local cmpnvim_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmpnvim_status_ok then return end

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Highlighting references.
    -- See: https://sbulav.github.io/til/til-neovim-highlight-references/
    -- for the highlight trigger time see: `vim.opt.updatetime`
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {clear = true})
        vim.api.nvim_clear_autocmds {
            buffer = bufnr,
            group = "lsp_document_highlight"
        }
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight"
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References"
        })
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                   bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f',
                   function() vim.lsp.buf.format {async = true} end, bufopts)
end

-- Define `root_dir` when needed
-- See: https://github.com/neovim/nvim-lspconfig/issues/320
-- This is a workaround, maybe not work with some servers.
local root_dir = function() return vim.fn.getcwd() end

local _lsp = {}

function _lsp.setup()
    mason.setup({})
    mason_lspconfig.setup({})

    mason_lspconfig.setup_handlers {
        function(server_name)
            lspconfig[server_name].setup({
                on_attach = on_attach,
                root_dir = root_dir,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {version = 'LuaJIT'},
                        completion = {callSnippet = 'Replace'},
                        diagnostics = {enable = true, globals = {'vim'}}
                    }
                },
                flags = {
                    -- default in neovim 0.7+
                    debounce_text_changes = 150
                }
            })
        end
    }
end

return _lsp
