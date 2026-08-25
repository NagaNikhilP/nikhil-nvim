-- render-markdown.nvim: renders headings/lists/code blocks/checkboxes readably in-buffer —
-- built for exactly the kind of study notes/writeups this config is meant for.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle markdown rendering" },
  },
  opts = {},
}
