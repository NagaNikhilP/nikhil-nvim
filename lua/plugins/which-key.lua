-- which-key: shows a popup of available keybinds as soon as you press <leader> and pause.
-- This is the single most useful plugin for learning this config — when in doubt, hit Space and wait.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>s", group = "Split windows" },
      { "<leader>t", group = "Tabs / Theme" },
      { "<leader>e", group = "Explorer" },
      { "<leader>w", group = "Session" },
      { "<leader>x", group = "Trouble (diagnostics)" },
      { "<leader>h", group = "Git hunks" },
      { "<leader>R", group = "REST client" },
      { "<leader>c", group = "Code" },
      { "<leader>l", group = "Lint / LazyGit" },
      { "<leader>q", group = "Quit" },
    },
  },
}
