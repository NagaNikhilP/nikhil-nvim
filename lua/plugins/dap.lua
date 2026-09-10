-- The debugger: the one real PyCharm/VS Code feature this config was missing.
--
-- Instead of sprinkling print() everywhere, you set a breakpoint on a line, run the file,
-- and nvim freezes there and shows you every variable's value. You then step through the
-- code one line at a time.
--
-- The F-keys below are deliberately the same ones VS Code uses, so tutorials transfer.
--
--   <leader>b   put / remove a breakpoint on this line
--   <leader>rd  start debugging this file  (also F5 once a session is running: continue)
--   F10         step over  (run this line, don't go inside the function)
--   F11         step into  (go inside the function being called)
--   F12         step out   (finish this function, come back to the caller)
--   <leader>ru  show/hide the variables panel
--   <leader>rx  stop debugging
--
-- The adapter (debugpy) is installed by mason — see mason-tool-installer in lua/plugins/lsp.lua.

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
    "theHamsta/nvim-dap-virtual-text", -- shows each variable's current value inline, next to the code
    "mfussenegger/nvim-dap-python",
  },
  keys = {
    { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
    {
      "<leader>B",
      function()
        vim.ui.input({ prompt = "Break only when this is true: " }, function(cond)
          if cond and cond ~= "" then require("dap").set_breakpoint(cond) end
        end)
      end,
      desc = "Debug: conditional breakpoint",
    },
    { "<leader>rd", function() require("dap").continue() end, desc = "Debug: start / continue" },
    { "<F5>", function() require("dap").continue() end, desc = "Debug: start / continue" },
    { "<F10>", function() require("dap").step_over() end, desc = "Debug: step over" },
    { "<F11>", function() require("dap").step_into() end, desc = "Debug: step into" },
    { "<F12>", function() require("dap").step_out() end, desc = "Debug: step out" },
    { "<leader>ru", function() require("dapui").toggle() end, desc = "Debug: toggle variables panel" },
    {
      "<leader>rx",
      function()
        require("dap").terminate()
        require("dapui").close()
      end,
      desc = "Debug: stop",
    },
    -- Hover the value of whatever is under the cursor (or selected), mid-session.
    {
      "<leader>rk",
      function() require("dapui").eval() end,
      mode = { "n", "v" },
      desc = "Debug: evaluate under cursor",
    },
  },
  config = function()
    local dap, dapui = require "dap", require "dapui"

    dapui.setup()
    require("nvim-dap-virtual-text").setup {}

    -- debugpy runs inside mason's own venv; the *program* you debug still runs under the
    -- project interpreter, which dap-python finds itself (it checks $VIRTUAL_ENV,
    -- $CONDA_PREFIX and venv/.venv/env folders — same rule as lua/util/python.lua).
    local debugpy = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(vim.fn.executable(debugpy) == 1 and debugpy or "python3")

    -- Breakpoint markers in the sign column.
    --
    -- `text` must never be empty. nvim-dap stores breakpoints AS signs and reads them back
    -- with sign_getplaced(); verified on nvim 0.12.5 with `-u NONE` that a sign defined with
    -- text = "" is accepted by sign_place() (it returns a real id) but is then never returned
    -- by sign_getplaced(). The result is breakpoints that look set and silently do nothing.
    vim.fn.sign_define("DapBreakpoint", { text = "\u{25CF}", texthl = "DiagnosticError", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "\u{25C6}", texthl = "DiagnosticWarn", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "\u{25CB}", texthl = "DiagnosticHint", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "\u{25C6}", texthl = "DiagnosticInfo", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "\u{25B6}", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })

    -- Open the variables panel when a session starts, close it when the session ends,
    -- so the debugger UI is never sitting there when you're just editing.
    dap.listeners.after.event_initialized.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
  end,
}
