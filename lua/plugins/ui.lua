-- General UI: dashboard, indent guides, notifications, window zoom, statusline, buffer tabs, icons.
-- snacks.nvim bundles what Josean's guide does with alpha-nvim + indent-blankline.nvim +
-- vim-maximizer + nvim-notify separately — one maintained plugin, less to update.
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          header = [[
 _   _            _
| \ | | ___  ___ | |_   ___ _ __ ___
|  \| |/ _ \/ _ \\| \ \ / / | '_ ` _ \
| |\  |  __/ (_) |\ V /| | | | | | |
|_| \_|\___|\___/  \_/ |_|_| |_| |_|

  CCNA + hackpath.dev workspace]],
        },
      },
      indent = { enabled = true },
      notifier = { enabled = true },
      zoom = { enabled = true },
      bigfile = { enabled = true },
    },
    keys = {
      { "<leader>sm", function() Snacks.zoom() end, desc = "Maximize/minimize split" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { globalstatus = true, section_separators = "", component_separators = "|" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "neo-tree", text = "Explorer", highlight = "Directory", text_align = "left" } },
      },
    },
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
}
