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
          -- Explicit, wired to the same tools you actually use in this config (Telescope,
          -- AutoSession) rather than snacks' own indirect picker layer.
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
            { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
            { icon = " ", key = "n", desc = "New File", action = ":enew" },
            { icon = " ", key = "s", desc = "Restore Session", action = ":AutoSession restore" },
            {
              icon = " ",
              key = "c",
              desc = "Edit Config",
              action = function()
                require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
              end,
            },
            { icon = "󰒲 ", key = "L", desc = "Plugins (Lazy)", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" }, -- shows plugin count + startup time, so it's not just static text
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
      -- Hand-built theme using rose-pine's own "main" variant palette (pulled straight from
      -- rose-pine/lua/rose-pine/palette.lua) — lualine has no bundled rose-pine theme, and its
      -- 'auto' mode derives colors less precisely than just using rose-pine's real values.
      local rp = {
        base = "#191724",
        surface = "#1f1d2e",
        overlay = "#26233a",
        muted = "#6e6a86",
        subtle = "#908caa",
        text = "#e0def4",
        love = "#eb6f92", -- replace mode
        gold = "#f6c177", -- visual mode
        rose = "#ebbcba", -- command mode
        pine = "#31748f",
        foam = "#9ccfd8", -- insert mode
        iris = "#c4a7e7", -- normal mode
        highlight_low = "#21202e",
      }
      local rose_pine_theme = {
        normal = {
          a = { fg = rp.base, bg = rp.iris, gui = "bold" },
          b = { fg = rp.text, bg = rp.surface },
          c = { fg = rp.subtle, bg = rp.overlay },
        },
        insert = { a = { fg = rp.base, bg = rp.foam, gui = "bold" } },
        visual = { a = { fg = rp.base, bg = rp.gold, gui = "bold" } },
        replace = { a = { fg = rp.base, bg = rp.love, gui = "bold" } },
        command = { a = { fg = rp.base, bg = rp.rose, gui = "bold" } },
        inactive = {
          a = { fg = rp.muted, bg = rp.highlight_low },
          b = { fg = rp.muted, bg = rp.highlight_low },
          c = { fg = rp.muted, bg = rp.highlight_low },
        },
      }
      return {
        options = {
          theme = rose_pine_theme,
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
