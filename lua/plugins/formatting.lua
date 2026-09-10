-- conform.nvim: format-on-demand (manual, not on-save, to match Josean's original behaviour —
-- you stay in control of when a file's formatting changes).
return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>mp",
      function() require("conform").format { async = true, lsp_format = "fallback" } end,
      mode = { "n", "v" },
      desc = "Format file or selection",
    },
  },
  opts = {
    formatters = {
      -- nixfmt warns on bare invocation; "-" tells it to read stdin explicitly.
      nixfmt = { prepend_args = { "-" } },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      python = { "ruff_format" },
      nix = { "nixfmt" },

      -- prettier (mason, npm). Markdown is deliberately left out: prettier
      -- rewraps paragraphs and rewrites list markers, which fights hand-written
      -- notes. Add `markdown = { "prettier" }` here if you ever want it.
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
    },
  },
}
