-- Applies the custom `duskrose` colorscheme (colors/duskrose.lua) and provides a
-- transparency toggle. Not a plugin — colorscheme files under colors/ are just
-- auto-discovered by Neovim, no lazy.nvim spec needed.
vim.g.duskrose_transparent = false
vim.cmd.colorscheme("duskrose")

vim.keymap.set("n", "<leader>tt", function()
  vim.g.duskrose_transparent = not vim.g.duskrose_transparent
  vim.cmd.colorscheme("duskrose")
end, { desc = "Toggle transparent background" })
