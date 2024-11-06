-- bootstrap lazy.nvim, LazyVim and your plugins
-- check for vscode usage
if vim.g.vscode then
	-- vscode vim
	require("vsocde.keymaps")
else
	require("config.lazy")
	require("config.oil")
end
