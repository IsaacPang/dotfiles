-- Workaround / pin for mason breaking changes
-- Ref: https://github.com/LazyVim/LazyVim/issues/6039#issuecomment-2856227817
-- Revert to the original repos & let LazyVim manage versions (version=false) until upstream fully adapts.
return {
   { "mason-org/mason.nvim",            version = false },
   { "mason-org/mason-lspconfig.nvim",  version = false },
}

