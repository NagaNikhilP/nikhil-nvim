-- conform.nvim: format-on-demand (manual, not on-save, to match Josean's original behaviour —
-- you stay in control of when a file's formatting changes).
return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format file or selection",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      python = { "ruff_format" },
    },
  },
}
