-- auto-session: save/restore per-directory window+buffer layout.
return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    suppress_dirs = { "~/", "~/Downloads", "/" },
    -- Bare `nvim` (or `nvim .`) always lands on the dashboard now, not an auto-restored
    -- session — restore is opt-in only, via <leader>wr or the dashboard's "s" key.
    auto_restore = false,
    args_allow_single_directory = false,
  },
  keys = {
    { "<leader>wr", "<cmd>AutoSession restore<CR>", desc = "Restore session for cwd" },
    { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session for cwd" },
  },
}
