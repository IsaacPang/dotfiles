local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- check for vscode usage
if vim.g.vscode then
else
  require("config.oil")
end
