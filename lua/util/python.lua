-- Which Python interpreter does this project use?
--
-- Everything Python-related has to agree on the answer, or you get the classic confusing
-- split where the editor underlines `import requests` in red while the script runs fine.
-- So the runner (lua/plugins/python.lua), the debugger (lua/plugins/dap.lua) and
-- basedpyright (lsp/basedpyright.lua) all ask this one function.
local M = {}

local function usable(path)
  if path and vim.fn.executable(path) == 1 then return path end
end

--- Resolve the interpreter for a given directory.
--- Order matters: a venv you activated in the shell beats one merely sitting on disk.
--- @param root? string directory to search upward from (default: current file's directory)
--- @return string path to a python executable, or "python3" when no venv was found
function M.interpreter(root)
  -- 1. A venv activated in the shell nvim was launched from.
  local active = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
  if active then
    local found = usable(active .. "/bin/python")
    if found then return found end
  end

  -- 2. A venv folder at or above the file. vim.fs.find with upward=true walks toward /
  --    and stops at the first hit, so a nested project wins over its parent.
  root = root or vim.fn.expand "%:p:h"
  if root == "" then root = vim.fn.getcwd() end
  local dir = vim.fs.find({ ".venv", "venv", "env" }, { path = root, upward = true, type = "directory" })[1]
  if dir then
    local found = usable(dir .. "/bin/python")
    if found then return found end
  end

  -- 3. Nothing project-local. Fall back to the system interpreter.
  return "python3"
end

--- Human-readable name for the interpreter in use, for statusline/notifications.
--- @return string
function M.describe(root)
  local py = M.interpreter(root)
  if py == "python3" then return "system python3" end
  -- ".../myproject/.venv/bin/python" -> "myproject/.venv"
  local venv = vim.fs.dirname(vim.fs.dirname(py))
  return vim.fs.basename(vim.fs.dirname(venv)) .. "/" .. vim.fs.basename(venv)
end

return M
