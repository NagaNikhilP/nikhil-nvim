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
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

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
              action = function() require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" } end,
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
      -- theme = "auto" derives lualine's colors from whatever colorscheme is currently
      -- applied (reads Normal/Visual/etc highlight groups) instead of a hardcoded hex
      -- table — required now that the colorscheme itself is dynamic (matugen/base16,
      -- live-synced from Noctalia, see lua/plugins/base16.lua). A hand-built palette
      -- would just go stale the first time you switch Noctalia themes.
      -- No separators at all — matches Noctalia's own bar (flat, no capsules, no
      -- powerline arrows; see radius=0 / capsule=false in bar.toml).
      return {
        options = {
          theme = "auto",
          globalstatus = true,
          section_separators = "",
          component_separators = "",
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
        --hide the blank "[No Name ]" tab neo-tree leaves behind after nvim .
        custom_filter = function(buf)
          if vim.api.nvim_buf_get_name(buf) ~= "" then return true end
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          return not (#lines == 1 and lines[1] == "")
        end,
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "neo-tree", text = "Explorer", highlight = "Directory", text_align = "left" } },
        -- No vertical-bar separators between tabs — matches the flat, no-capsule look
        -- everywhere else (lualine, Noctalia's own bar).
        separator_style = { "", "" },
      },
    },
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
}
