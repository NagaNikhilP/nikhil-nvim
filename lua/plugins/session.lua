-- auto-session: save/restore per-directory window+buffer layout.
return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    suppress_dirs = { "~/", "~/Downloads", "/" },
  },
  keys = {
    { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for cwd" },
    { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for cwd" },
  },
}
