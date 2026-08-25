-- blink.cmp: completion engine (replaces nvim-cmp — this is the current community-standard
-- choice; it auto-wires LSP capabilities so lsp.lua doesn't need to pass any manually).
return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets", -- snippet collection, consumed by blink's built-in snippet source
  },
  opts = {
    keymap = {
      preset = "default",
      -- Josean's nvim-cmp muscle memory, remapped onto blink.cmp:
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = { border = "rounded" },
    },
    signature = { window = { border = "rounded" } },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
