return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          mason = false,
          autostart = true, -- enable automatic startup
          settings = {
            python = {
              pythonPath = function()
                local cwd = vim.fn.getcwd()
                local venv_path = cwd .. "/.venv/bin/python"
                if vim.fn.filereadable(venv_path) == 1 then
                  return venv_path
                end
                return "python3"
              end,
              analysis = {
                typeCheckingMode = "basic", -- or "strict" if you prefer
              },
            },
          },
        },
      },
    },
  },
}
