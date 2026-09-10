-- auto-session: save/restore per-directory window+buffer layout.
return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    suppress_dirs = { "~/", "~/Downloads", "/" },
    -- Bare `nvim` (or `nvim .`) always lands on the dashboard now, not an auto-restored
    -- session — restore is opt-in only, via <leader>Sr or the dashboard's "s" key.
    auto_restore = false,
    args_allow_single_directory = false,
  },
  keys = {
    -- Moved off <leader>w so that <leader>w can be a plain, instant "save file"
    -- (see lua/config/keymaps.lua). Sessions are a rare action; saving is constant.
    { "<leader>Sr", "<cmd>AutoSession restore<CR>", desc = "Restore session for cwd" },
    { "<leader>Ss", "<cmd>AutoSession save<CR>", desc = "Save session for cwd" },
  },
}
