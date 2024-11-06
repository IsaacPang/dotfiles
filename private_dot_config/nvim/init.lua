-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- check for vscode usage
if vim.g.vscode then
else
  require("config.oil")
end
