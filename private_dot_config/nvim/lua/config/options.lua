-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local nvim_py = vim.fn.expand("~/.virtualenvs/neovim/bin/python")
if vim.fn.executable(nvim_py) == 1 then
	vim.g.python3_host_prog = nvim_py
end
