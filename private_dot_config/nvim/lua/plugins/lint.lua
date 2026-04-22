-- reference: https://github.com/LazyVim/LazyVim/discussions/2268#discussioncomment-7970989
return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local function get_ruff_command()
        local cwd = vim.fn.getcwd()
        local ruff_path = cwd .. "/.venv/bin/ruff"
        if vim.fn.executable(ruff_path) == 1 then
          return ruff_path
        end
        return "ruff"
      end

      local ruff_cmd = get_ruff_command()

      opts.linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft or {}, {
        markdown = { "markdownlint-cli2" },
        python = { "ruff" },
      })
      opts.linters = vim.tbl_extend("force", opts.linters or {}, {
        ["markdownlint-cli2"] = {
          args = { "--disable", "MD013", "--" },
        },
        ruff = {
          cmd = ruff_cmd,
          args = { "check", "--output-format", "json" },
          stdin = false,
          stream = "stdout",
          ignore_exitcode = true,
        },
      })
    end,
  },
}
