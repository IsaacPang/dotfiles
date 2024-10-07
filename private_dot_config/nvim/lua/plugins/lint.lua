-- reference: https://github.com/LazyVim/LazyVim/discussions/2268#discussioncomment-7970989
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--disable", "MD013", "--" },
        },
      },
    },
  },
}
