local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then return end

local sources = {
    -- Formatting
    null_ls.builtins.formatting.beautysh, -- bash
    null_ls.builtins.formatting.black.with({
        extra_args = {" -- line-length=120"}
    }), -- python
    null_ls.builtins.formatting.isort, -- python
    null_ls.builtins.formatting.clang_format, -- c/c++
    null_ls.builtins.formatting.prettierd, -- js/ts/html/css/json/md
    null_ls.builtins.formatting.lua_format, -- lua
    null_ls.builtins.formatting.rustfmt -- rust
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
                    -- on 0.8, you should use vim.lsp.buf.format({bufnr = bufnr})
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
