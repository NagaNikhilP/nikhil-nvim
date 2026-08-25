-- Telescope: fuzzy finder. Kept (instead of switching to snacks.picker) specifically so the
-- keybinds below match Josean's guide exactly.
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-tree/nvim-web-devicons" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files in cwd" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Find recently opened files" },
    { "<leader>fs", "<cmd>Telescope live_grep<CR>", desc = "Find string in cwd (live grep)" },
    { "<leader>fc", "<cmd>Telescope grep_string<CR>", desc = "Find string under cursor in cwd" },
    { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" },
    -- Extras beyond Josean's original list:
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find open buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find help tags" },
  },
  opts = {
    defaults = {
      path_display = { "truncate" },
      mappings = {
        i = {
          ["<C-k>"] = "move_selection_previous",
          ["<C-j>"] = "move_selection_next",
          ["<C-q>"] = "send_selected_to_qflist",
        },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}
