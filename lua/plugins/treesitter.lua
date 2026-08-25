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
    require("nvim-treesitter.configs").setup({
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
    })
  end,
}
