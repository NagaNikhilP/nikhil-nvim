-- General editor options. See `:h option-list` for anything not explained here.
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation: 2 spaces, expanded, matched to filetype where plugins override it
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Wrapping
opt.wrap = false
opt.linebreak = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.colorcolumn = "80"
opt.pumheight = 10 -- max items in completion popup
opt.showmode = false -- statusline shows mode instead

-- Splits: open where you'd expect
opt.splitright = true
opt.splitbelow = true

-- Files/undo: persistent undo across restarts, no swap/backup clutter
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Performance / UX
opt.updatetime = 250 -- faster CursorHold events (diagnostics, gitsigns)
opt.timeoutlen = 300 -- faster which-key popup
opt.completeopt = "menuone,noselect"
opt.clipboard = "unnamedplus" -- share system clipboard
opt.mouse = "a"

-- Whitespace characters shown with `:set list`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.fillchars = { eob = " " } -- hide `~` on empty lines past end of buffer

-- Where mason/lazy/undo/session data lives (native nvim 0.11+ default is already this,
-- spelled out here so it's obvious rather than magic)
vim.g.loaded_netrwPlugin = 1 -- we use neo-tree instead of netrw
