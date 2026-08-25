-- Small, focused editing-quality plugins. (Comment.nvim is intentionally NOT here — Neovim 0.10+
-- has built-in `gc`/`gcc` commenting, so a whole plugin for that is no longer needed.)
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {}, -- defaults: ys{motion}{char} add, cs{old}{new} change, ds{char} delete surround
  },

  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    keys = {
      { "s", function() require("substitute").operator() end, desc = "Substitute with motion" },
      { "ss", function() require("substitute").line() end, desc = "Substitute line" },
      { "S", function() require("substitute").eol() end, desc = "Substitute to end of line" },
      { "s", function() require("substitute").visual() end, mode = "x", desc = "Substitute selection" },
    },
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTelescope", "TodoTrouble" },
    opts = {},
  },
}
