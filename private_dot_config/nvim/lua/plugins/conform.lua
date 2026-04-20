return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format" },
    },
    formatters = {
      ruff_fix = {
        command = function()
          local cwd = vim.fn.getcwd()
          local ruff_path = cwd .. "/.venv/bin/ruff"
          if vim.fn.executable(ruff_path) == 1 then
            return ruff_path
          end
          return "ruff"
        end,
        args = { "check", "--fix", "--exit-zero", "-" },
        stdin = true,
      },
      ruff_format = {
        command = function()
          local cwd = vim.fn.getcwd()
          local ruff_path = cwd .. "/.venv/bin/ruff"
          if vim.fn.executable(ruff_path) == 1 then
            return ruff_path
          end
          return "ruff"
        end,
        args = { "format", "-" },
        stdin = true,
      },
    },
  },
}
