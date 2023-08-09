local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then return end

local sources = {
    -- Formatting
    null_ls.builtins.formatting.black.with({extra_args = {"--line-length=120"}}), -- python
    null_ls.builtins.formatting.isort, -- python
    null_ls.builtins.formatting.sql_formatter, -- sql
    null_ls.builtins.formatting.clang_format, -- c/c++
    null_ls.builtins.formatting.prettierd, -- js/ts/html/css/json/md
    null_ls.builtins.formatting.lua_format, -- lua
    null_ls.builtins.formatting.rustfmt, -- rust
    null_ls.builtins.formatting.google_java_format, -- java
    null_ls.builtins.formatting.gofumpt, -- golang
    null_ls.builtins.formatting.goimports, -- golang
    null_ls.builtins.formatting.goimports_reviser -- golang
    -- Diagnostics
    -- null_ls.builtins.diagnostics.ruff, -- python
    -- null_ls.builtins.diagnostics.eslint_d, -- js/ts/html/css/json
    -- null_ls.builtins.diagnostics.markdownlint, -- markdown
    -- null_ls.builtins.diagnostics.hadolint -- dockerfiles
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = sources,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(local_client)
                            return local_client.name == "null-ls"
                        end
                    })
                end
            })
        end
    end
})
