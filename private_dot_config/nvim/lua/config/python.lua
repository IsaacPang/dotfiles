-- lua/config/python.lua
local function find_uv_venv()
  -- Look for .venv in current directory and parents
  local cwd = vim.fn.getcwd()
  local venv_path = cwd .. "/.venv"

  if vim.fn.isdirectory(venv_path) == 1 then
    return venv_path
  end

  -- Fallback to system python
  return nil
end

-- Set Python executable when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function()
    local venv = find_uv_venv()
    if venv then
      vim.g.python3_host_prog = venv .. "/bin/python"
    end
  end,
})
