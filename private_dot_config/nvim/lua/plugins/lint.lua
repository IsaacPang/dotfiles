-- reference: https://github.com/LazyVim/LazyVim/discussions/2268#discussioncomment-7970989
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--disable", "MD013", "--" },
        },
      },
    },
  },
}
