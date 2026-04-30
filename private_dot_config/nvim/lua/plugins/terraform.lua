return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      tofu_fmt = {
        command = "tofu",
        args = { "fmt", "-" },
        stdin = true,
      },
    },
    formatters_by_ft = {
      terraform = { "tofu_fmt" },
      ["terraform-vars"] = { "tofu_fmt" },
    },
  },
}
