-- Core keymaps that don't belong to any one plugin (native Vim commands only).
-- Plugin-specific keymaps live inside that plugin's own file under lua/plugins/,
-- in its lazy.nvim `keys = {...}` table, so the plugin only loads when the key is pressed.
local keymap = vim.keymap.set

keymap("i", "jk", "<Esc>", { desc = "Exit insert mode" })
keymap("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlight" })

-- Increment/decrement numbers under the cursor
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window (split) management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab management
keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Current buffer in new tab" })

-- Better default behaviour for common motions
keymap("v", "<", "<gv", { desc = "Indent left, stay in visual mode" })
keymap("v", ">", ">gv", { desc = "Indent right, stay in visual mode" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down, keep cursor centered" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up, keep cursor centered" })
keymap("x", "<leader>p", [["_dP]], { desc = "Paste over selection without losing register" })
-- NOTE: <leader>d is reserved for "show line diagnostics" (see lua/plugins/lsp.lua) to match
-- Josean's original bind — don't repurpose it here.

-- Quit
keymap("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit Neovim" })
