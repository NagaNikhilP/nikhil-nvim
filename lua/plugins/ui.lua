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
    opts = function()
      -- Explicit theme matching colors/duskrose.lua — lualine's 'auto' mode can misjudge
      -- a hand-written colorscheme it doesn't recognize.
      local c = {
        bg = "#1a1826",
        bg_dim = "#141220",
        surface = "#211f30",
        fg = "#e6e1f5",
        fg_dim = "#b7b0d6",
        muted = "#5f5b7a",
        pink = "#ef95c9",
        cyan = "#8fe0d3",
        green = "#a3d977",
        orange = "#f2a765",
        red = "#f16c85",
      }
      local duskrose = {
        normal = {
          a = { fg = c.bg, bg = c.pink, gui = "bold" },
          b = { fg = c.fg_dim, bg = c.surface },
          c = { fg = c.fg_dim, bg = c.bg_dim },
        },
        insert = { a = { fg = c.bg, bg = c.cyan, gui = "bold" } },
        visual = { a = { fg = c.bg, bg = c.orange, gui = "bold" } },
        replace = { a = { fg = c.bg, bg = c.red, gui = "bold" } },
        command = { a = { fg = c.bg, bg = c.green, gui = "bold" } },
        inactive = {
          a = { fg = c.muted, bg = c.bg_dim },
          b = { fg = c.muted, bg = c.bg_dim },
          c = { fg = c.muted, bg = c.bg_dim },
        },
      }
      return {
        options = {
          theme = duskrose,
          globalstatus = true,
          section_separators = "",
          component_separators = "|",
        },
      }
    end,
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
