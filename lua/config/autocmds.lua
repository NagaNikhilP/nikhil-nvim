-- Small quality-of-life autocommands. Anything plugin-specific lives with that plugin's spec instead.
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Briefly flash yanked text so you can see what you copied
autocmd("TextYankPost", {
  group = augroup("highlight-yank", { clear = true }),
  -- vim.hl, not vim.highlight: runtime/lua/vim/highlight.lua no longer exists in
  -- 0.12.5. vim.highlight still resolves via a silent shim (no warning at all),
  -- which is exactly why it's worth moving off before it disappears quietly.
  callback = function() vim.hl.on_yank { higroup = "IncSearch", timeout = 200 } end,
})

-- Reopen files at the last cursor position you left them at
autocmd("BufReadPost", {
  group = augroup("restore-cursor", { clear = true }),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then vim.api.nvim_win_set_cursor(0, mark) end
  end,
})

-- Auto-resize splits when the terminal window is resized
autocmd("VimResized", {
  group = augroup("resize-splits", { clear = true }),
  callback = function() vim.cmd "tabdo wincmd =" end,
})

-- `nvim <dir>` (e.g. `nvim .`) opens that directory in neo-tree instead of an empty
-- buffer — auto-session's directory handling is off (see session.lua) so this is now
-- the only thing that reacts to a bare directory argument. Bare `nvim` (no args) is
-- untouched by this and falls through to the dashboard.
autocmd("VimEnter", {
  group = augroup("open-dir-in-explorer", { clear = true }),
  callback = function()
    if vim.fn.argc() ~= 1 then return end
    local arg = vim.fn.argv(0)
    if vim.fn.isdirectory(arg) ~= 1 then return end
    vim.cmd.cd(arg)
    vim.cmd("Neotree toggle dir=" .. vim.fn.fnameescape(vim.fn.getcwd()))
  end,
})

-- Close certain filetypes with just `q`
autocmd("FileType", {
  group = augroup("close-with-q", { clear = true }),
  pattern = { "help", "qf", "lspinfo", "checkhealth", "notify" },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true })
  end,
})
