-- bootstrap lazy.nvim, LazyVim and your plugins
-- check for vscode usage
if vim.g.vscode then
  -- vscode vim
  require("vscode.keymaps")
  require("vscode.plugins")
  require("leap").create_default_mappings()
else
  require("config.lazy")
  require("config.oil")
end
