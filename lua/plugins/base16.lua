-- Written by Noctalia's own "neovim" community template (matugen render + apply.sh),
-- not by us — apply.sh only writes this file if it's missing, so it won't get clobbered
-- on re-render; safe to extend. On this machine (Noctalia installed), lua/matugen.lua
-- gets re-rendered by Noctalia and SIGUSR1'd into any running nvim whenever you switch
-- themes — that's the live path below and it's unchanged.
--
-- lua/matugen.lua is gitignored (it's a machine-generated snapshot, would just go stale
-- committed). So on any machine that clones this repo without Noctalia, that file simply
-- won't exist, and this falls back to a static gruvbox dark palette instead, so nvim
-- never opens with zero colorscheme applied.
local transparent = false

-- Static fallback for machines without Noctalia/matugen — base16-nvim's own bundled
-- gruvbox-dark palette (lua/colors/gruvbox-dark.lua in the plugin), inlined here so this
-- doesn't depend on the plugin's internal module layout staying the same across updates.
local fallback_palette = {
  base00 = "#282828", base01 = "#3c3836", base02 = "#504945", base03 = "#665c54",
  base04 = "#928374", base05 = "#ebdbb2", base06 = "#fbf1c7", base07 = "#f9f5d7",
  base08 = "#cc241d", base09 = "#d65d0e", base0A = "#d79921", base0B = "#98971a",
  base0C = "#689d6a", base0D = "#458588", base0E = "#b16286", base0F = "#9d0006",
}

return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  keys = {
    {
      "<leader>tt",
      function()
        transparent = not transparent
        local bg = transparent and "none" or nil
        vim.api.nvim_set_hl(0, "Normal", { bg = bg })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = bg })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = bg })
      end,
      desc = "Toggle transparent background",
    },
  },
  config = function()
    local ok, matugen = pcall(require, "matugen")
    if ok then
      matugen.setup()
    else
      require("base16-colorscheme").setup(fallback_palette)
    end
  end,
}
