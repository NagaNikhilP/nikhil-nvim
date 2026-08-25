-- nvim-lint: on-demand linting for filetypes an LSP doesn't already diagnose well.
return {
  "mfussenegger/nvim-lint",
  keys = {
    {
      "<leader>l",
      function()
        require("lint").try_lint()
      end,
      desc = "Trigger linting for current file",
    },
  },
  config = function()
    require("lint").linters_by_ft = {
      sh = { "shellcheck" },
      bash = { "shellcheck" },
    }
  end,
}
