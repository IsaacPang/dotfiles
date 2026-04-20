-- reference: https://github.com/LazyVim/LazyVim/discussions/2268#discussioncomment-7970989
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
        python = { "ruff" },
      },
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--disable", "MD013", "--" },
        },
        ruff = {
          cmd = function()
            local cwd = vim.fn.getcwd()
            local ruff_path = cwd .. "/.venv/bin/ruff"
            if vim.fn.executable(ruff_path) == 1 then
              return ruff_path
            end
            return "ruff"
          end,
          args = { "check", "--output-format", "json" },
          stdin = false,
          stream = "stdout",
          ignore_exitcode = true,
        },
      },
    },
  },
}
