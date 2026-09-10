-- Treesitter: real syntax parsing (accurate highlighting, indentation, and structural text objects)
-- instead of regex-based highlighting.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "python",
        "yaml",
        "json",
        "toml",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "gitignore",
        "regex",
        "diff",
      },
      auto_install = true, -- install a parser automatically when opening an unrecognized filetype
      -- kulala.nvim ships and manages its own dedicated grammar for .http files
      -- (see lua/plugins/rest.lua) — don't let auto_install fight it for the same filetype.
      ignore_install = { "http" },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<BS>",
        },
      },
    }

    -- nvim-treesitter `master` is locked to Nvim 0.11; this box runs 0.12.5. Repair the
    -- three query directives that break under it. Must run after the setup() above,
    -- which is what pulls in nvim-treesitter's own (broken) registrations.
    require("util.ts_compat").apply()
  end,
}
