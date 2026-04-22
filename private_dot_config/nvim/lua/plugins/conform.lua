return {
	"stevearc/conform.nvim",
	opts = function()
		local function get_ruff_command()
			local cwd = vim.fn.getcwd()
			local ruff_path = cwd .. "/.venv/bin/ruff"
			if vim.fn.executable(ruff_path) == 1 then
				return ruff_path
			end
			return "ruff"
		end

		local ruff_cmd = get_ruff_command()

		return {
			formatters_by_ft = {
				python = { "ruff_fix", "ruff_format" },
			},
			formatters = {
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
			},
		}
	end,
}
