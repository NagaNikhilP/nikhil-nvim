-- rose-pine: the real thing, "main" variant (its default dark palette).
local transparent = false

return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  keys = {
    {
      "<leader>tt",
      function()
        transparent = not transparent
        require("rose-pine").setup({
          variant = "main",
          styles = { bold = true, italic = true, transparency = transparent },
        })
        vim.cmd.colorscheme("rose-pine")
      end,
      desc = "Toggle transparent background",
    },
  },
  config = function()
    require("rose-pine").setup({
      variant = "main",
      styles = { bold = true, italic = true, transparency = transparent },
    })
    vim.cmd.colorscheme("rose-pine")
  end,
}
