-- mini.files: Miller-column file explorer. Replaced neo-tree on 2026-09-09.
--
-- Different model from a sidebar: this opens as a floating stack of columns, you
-- move with h/j/k/l, and you manipulate the filesystem by EDITING THE BUFFER —
-- delete a line to delete a file, change the text to rename, yank/paste a line to
-- copy/move. Nothing happens until you press `=` and confirm. Create, delete and
-- rename are LSP-aware, so imports get updated.
--
-- `g?` inside the window lists every mapping. Worth pressing once.
--
-- Note the repo lives under `nvim-mini/`, not `echasnovski/` — the project moved
-- to its own org. Old tutorials all use the dead name; it redirects, but this is
-- the real one.
return {
  "nvim-mini/mini.files",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>ee",
      function()
        -- get_explorer_state() returns nil when nothing is open, which is the
        -- only toggle hook mini.files gives us.
        if MiniFiles.get_explorer_state() then
          MiniFiles.close()
        else
          MiniFiles.open()
        end
      end,
      desc = "Toggle file explorer",
    },
    {
      "<leader>ef",
      function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end,
      desc = "Open explorer at current file",
    },
  },
  opts = {
    options = {
      -- Deleted entries go to mini.files' own trash rather than vanishing.
      -- Worth keeping while the buffer-editing workflow is still unfamiliar.
      permanent_delete = false,
      use_as_default_explorer = true,
    },
    windows = {
      -- Preview turns this from a file list into something you can actually
      -- read your way around without opening anything.
      preview = true,
      width_focus = 40,
      width_nofocus = 20,
      width_preview = 60,
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)

    -- mini.files binds no <CR> at all — `l` goes in, `L` goes in and closes on a
    -- file. The mappings table takes only one key per action, so rather than give
    -- up `L`, add Enter as a buffer-local map on top.
    --
    -- go_in with close_on_file only closes for FILES (it checks fs_type), so
    -- Enter expands a directory and opens-then-dismisses a file. Which is what
    -- Enter should do in a floating explorer.
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        vim.keymap.set(
          "n",
          "<CR>",
          function() MiniFiles.go_in { close_on_file = true } end,
          { buffer = args.data.buf_id, desc = "Open entry (close if file)" }
        )
      end,
    })
  end,
}
