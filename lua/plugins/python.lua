-- Running Python without leaving nvim.
--
-- No new plugin needed: snacks.nvim is already loaded eagerly (lua/plugins/ui.lua) and
-- ships a terminal module, which lua/plugins/git.lua already uses for lazygit. This file
-- just adds keys to that same spec — lazy.nvim merges specs for the same repo.
--
-- Every command below runs the interpreter chosen by lua/util/python.lua, so if the project
-- has a .venv it is used automatically. You never have to "activate" anything.

local function py() return require "util.python" end

local function is_python()
  if vim.bo.filetype ~= "python" then
    Snacks.notify.warn(
      "Not a Python file (this buffer is `" .. (vim.bo.filetype ~= "" and vim.bo.filetype or "empty") .. "`)"
    )
    return false
  end
  return true
end

--- Run the current file. `extra` goes to the interpreter *before* the filename,
--- so `{"-i"}` becomes `python -i script.py`.
local function run(extra, opts)
  if not is_python() then return end
  vim.cmd "silent! write" -- run what's on screen, not what was last saved
  local cmd = { py().interpreter() }
  vim.list_extend(cmd, extra or {})
  table.insert(cmd, vim.fn.expand "%:p")

  Snacks.terminal.open(
    cmd,
    vim.tbl_deep_extend("force", {
      cwd = vim.fn.expand "%:p:h", -- relative paths in the script resolve next to the script
      win = { position = "float", border = "rounded", title = " " .. vim.fn.expand "%:t" .. " ", title_pos = "center" },
      interactive = false, -- window stays open after the script exits, so you can read errors
    }, opts or {})
  )
end

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>rr",
      function() run() end,
      desc = "Run this Python file",
    },
    {
      -- `python -i` drops you into a REPL *after* the script finishes, with all its
      -- variables still alive. This is the single best way to poke at what your code did.
      "<leader>ri",
      function() run({ "-i" }, { interactive = true }) end,
      desc = "Run file, then stay in the REPL",
    },
    {
      "<leader>rp",
      function()
        Snacks.terminal.toggle({ require("util.python").interpreter() }, {
          cwd = vim.fn.getcwd(),
          win = { position = "float", border = "rounded", title = " python ", title_pos = "center" },
        })
      end,
      desc = "Toggle a Python REPL",
    },
    {
      -- A plain shell in the project directory, with the venv on PATH — for `pip install`,
      -- `pytest`, `git`, whatever. Toggling hides it without killing it.
      "<leader>rt",
      function()
        local interp = require("util.python").interpreter()
        local env = {}
        if interp ~= "python3" then
          local bin = vim.fs.dirname(interp)
          env = { VIRTUAL_ENV = vim.fs.dirname(bin), PATH = bin .. ":" .. vim.env.PATH }
        end
        Snacks.terminal.toggle(nil, {
          cwd = vim.fn.getcwd(),
          env = env,
          win = { position = "float", border = "rounded", title = " shell ", title_pos = "center" },
        })
      end,
      desc = "Toggle a shell (venv on PATH)",
    },
    {
      "<leader>rv",
      function()
        Snacks.notify.info(
          "Python: " .. require("util.python").describe() .. "\n" .. require("util.python").interpreter()
        )
      end,
      desc = "Which Python am I using?",
    },
  },
}
