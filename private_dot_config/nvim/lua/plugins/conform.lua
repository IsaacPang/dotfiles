return {
	"stevearc/conform.nvim",
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

		opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
			python = { "ruff_fix", "ruff_format" },
		})
		opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
			ruff_fix = {
				command = ruff_cmd,
				args = { "check", "--fix", "--exit-zero", "-" },
				stdin = true,
			},
			ruff_format = {
				command = ruff_cmd,
				args = { "format", "-" },
				stdin = true,
			},
		})
	end,
}
