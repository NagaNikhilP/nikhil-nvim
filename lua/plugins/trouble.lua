-- trouble.nvim: a nicer list view over diagnostics/quickfix/todos than the default quickfix window.
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document diagnostics" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "TODOs" },
  },
  opts = {},
}
