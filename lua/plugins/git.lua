-- gitsigns: hunk signs in the gutter + hunk-level git operations. LazyGit launched via
-- snacks.nvim's built-in terminal helper instead of a separate lazygit.nvim plugin.
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = require "gitsigns"
        local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc }) end

        -- next_hunk/prev_hunk are marked @deprecated in gitsigns' own source in
        -- favour of nav_hunk(direction).
        map("n", "]h", function() gs.nav_hunk "next" end, "Next git hunk")
        map("n", "[h", function() gs.nav_hunk "prev" end, "Previous git hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end, "Stage hunk")
        map("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end, "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        -- undo_stage_hunk is deprecated: stage_hunk now toggles. It looks for an
        -- unstaged hunk first, and if there isn't one it unstages the staged hunk
        -- under the cursor instead. So <leader>hs already does both — this is kept
        -- pointing at the same function purely so old muscle memory still works.
        map("n", "<leader>hu", gs.stage_hunk, "Unstage hunk (hs toggles too)")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line { full = true } end, "Blame line")
        map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")
        map("n", "<leader>hd", gs.diffthis, "Diff this")
        map("n", "<leader>hD", function() gs.diffthis "~" end, "Diff this against previous")
        map({ "o", "x" }, "ih", gs.select_hunk, "Select git hunk")
      end,
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>lg",
        function() Snacks.terminal("lazygit", { win = { style = "float" } }) end,
        desc = "Open LazyGit",
      },
    },
  },
}
