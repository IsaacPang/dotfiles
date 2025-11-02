-- reference: https://github.com/LazyVim/LazyVim/discussions/2268#discussioncomment-7970989
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        linters_by_ft = {
          markdown = { "markdownlint" },
        },
        ["markdownlint-cli2"] = {
          args = { "--disable", "MD013", "--" },
        },
      },
    },
  },
}
