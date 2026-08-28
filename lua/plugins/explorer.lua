-- neo-tree: file explorer sidebar (used instead of Josean's nvim-tree — same job, more features,
-- already installed on this machine).
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>ee", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
    { "<leader>ef", "<cmd>Neotree reveal<CR>", desc = "Reveal current file in explorer" },
    { "<leader>ec", "<cmd>Neotree close<CR>", desc = "Close file explorer" },
    {
      "<leader>er",
      function()
        require("neo-tree.sources.manager").refresh("filesystem")
      end,
      desc = "Refresh file explorer",
    },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true, -- show dotfiles/gitignored by default, common for CTF/network config repos
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    window = {
      width = 32,
      mappings = {
        -- neo-tree binds bare <space> to toggle_node by default, which eats your
        -- <leader> key the instant the explorer window is focused. Freeing it lets
        -- which-key/<leader> binds work normally in here too; use <cr> or o to expand.
        ["<space>"] = "none",
      },
    },
  },
}
