-- smart-splits: move/resize between nvim splits AND tmux panes with the same keys
-- (used instead of Josean's vim-tmux-navigator — same idea, actively maintained, does resizing too).
return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  keys = {
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Go to left split" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Go to split below" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Go to split above" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Go to right split" },
    { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },
  },
}
