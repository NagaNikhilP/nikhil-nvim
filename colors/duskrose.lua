-- duskrose: a custom colorscheme blending rose-pine's calm, muted base with dracula's
-- punchier, more saturated accents. Every accent below is a deliberate blend of the two
-- (not a straight copy of either) so it reads as its own thing rather than a reskin.
--
-- Toggle transparency with <leader>tt (see lua/config/colorscheme.lua).

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "duskrose"

local transparent = vim.g.duskrose_transparent == true

local c = {
  bg = "#1a1826",
  bg_dim = "#141220",
  surface = "#211f30",
  overlay = "#2c2940",
  border = "#3a3650",
  muted = "#5f5b7a",
  comment = "#726d97",

  fg = "#e6e1f5",
  fg_dim = "#b7b0d6",
  fg_faint = "#8983ab",

  red = "#f16c85", -- rose-pine "love" + dracula red, blended
  orange = "#f2a765", -- dracula orange, softened
  yellow = "#f5c777", -- rose-pine "gold", kept close
  green = "#a3d977", -- dracula green, desaturated toward rose-pine
  cyan = "#8fe0d3", -- rose-pine "foam" + dracula cyan, blended
  blue = "#7dabd6", -- rose-pine "pine", lightened for contrast
  purple = "#bd9ae8", -- dracula purple + rose-pine "iris", averaged
  pink = "#ef95c9", -- dracula pink, warmed toward rose-pine
}

local none = "NONE"
local base_bg = transparent and none or c.bg
local surface_bg = transparent and none or c.surface

local hl = vim.api.nvim_set_hl

local groups = {
  -- Core UI
  Normal = { fg = c.fg, bg = base_bg },
  NormalFloat = { fg = c.fg, bg = surface_bg },
  NormalNC = { fg = c.fg, bg = base_bg },
  FloatBorder = { fg = c.border, bg = surface_bg },
  FloatTitle = { fg = c.pink, bg = surface_bg, bold = true },
  Cursor = { fg = c.bg, bg = c.fg },
  CursorLine = { bg = c.overlay },
  CursorLineNr = { fg = c.pink, bold = true },
  LineNr = { fg = c.muted },
  SignColumn = { bg = base_bg },
  ColorColumn = { bg = c.bg_dim },
  Visual = { bg = c.overlay },
  VisualNOS = { bg = c.overlay },
  Search = { fg = c.bg, bg = c.yellow },
  IncSearch = { fg = c.bg, bg = c.orange },
  CurSearch = { fg = c.bg, bg = c.orange },
  Pmenu = { fg = c.fg_dim, bg = c.surface },
  PmenuSel = { fg = c.bg, bg = c.pink, bold = true },
  PmenuSbar = { bg = c.overlay },
  PmenuThumb = { bg = c.muted },
  StatusLine = { fg = c.fg_dim, bg = c.bg_dim },
  StatusLineNC = { fg = c.muted, bg = c.bg_dim },
  WinSeparator = { fg = c.border, bg = base_bg },
  VertSplit = { fg = c.border, bg = base_bg },
  TabLine = { fg = c.muted, bg = c.bg_dim },
  TabLineFill = { bg = c.bg_dim },
  TabLineSel = { fg = c.pink, bg = c.overlay, bold = true },
  NonText = { fg = c.muted },
  Whitespace = { fg = c.muted },
  EndOfBuffer = { fg = base_bg },
  Directory = { fg = c.blue, bold = true },
  Title = { fg = c.pink, bold = true },
  ModeMsg = { fg = c.fg_dim },
  MoreMsg = { fg = c.cyan },
  Question = { fg = c.cyan },
  WarningMsg = { fg = c.orange },
  ErrorMsg = { fg = c.red, bold = true },
  MatchParen = { fg = c.yellow, bold = true, underline = true },
  WildMenu = { fg = c.bg, bg = c.pink },
  FoldColumn = { fg = c.muted, bg = base_bg },
  Folded = { fg = c.fg_faint, bg = c.bg_dim, italic = true },

  -- Syntax
  Comment = { fg = c.comment, italic = true },
  Constant = { fg = c.orange },
  String = { fg = c.green },
  Character = { fg = c.green },
  Number = { fg = c.orange },
  Boolean = { fg = c.orange, bold = true },
  Float = { fg = c.orange },
  Identifier = { fg = c.fg },
  Function = { fg = c.blue, bold = true },
  Statement = { fg = c.purple, bold = true },
  Conditional = { fg = c.purple },
  Repeat = { fg = c.purple },
  Label = { fg = c.purple },
  Operator = { fg = c.fg_dim },
  Keyword = { fg = c.purple, bold = true },
  Exception = { fg = c.red },
  PreProc = { fg = c.cyan },
  Include = { fg = c.cyan },
  Define = { fg = c.cyan },
  Macro = { fg = c.cyan },
  PreCondit = { fg = c.cyan },
  Type = { fg = c.yellow },
  StorageClass = { fg = c.yellow },
  Structure = { fg = c.yellow },
  Typedef = { fg = c.yellow },
  Special = { fg = c.pink },
  SpecialChar = { fg = c.pink },
  Tag = { fg = c.pink },
  Delimiter = { fg = c.fg_dim },
  SpecialComment = { fg = c.comment, italic = true, bold = true },
  Debug = { fg = c.red },
  Underlined = { fg = c.blue, underline = true },
  Ignore = { fg = c.muted },
  Error = { fg = c.red, bold = true },
  Todo = { fg = c.bg, bg = c.yellow, bold = true },

  -- A few treesitter captures the classic groups above don't map cleanly
  ["@variable"] = { fg = c.fg },
  ["@variable.parameter"] = { fg = c.fg_dim, italic = true },
  ["@variable.member"] = { fg = c.fg_dim },
  ["@property"] = { fg = c.fg_dim },
  ["@constructor"] = { fg = c.yellow },
  ["@punctuation.bracket"] = { fg = c.fg_faint },
  ["@punctuation.delimiter"] = { fg = c.fg_faint },
  ["@markup.heading"] = { fg = c.pink, bold = true },
  ["@markup.link"] = { fg = c.blue, underline = true },
  ["@markup.raw"] = { fg = c.green },

  -- Diagnostics
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.orange },
  DiagnosticInfo = { fg = c.blue },
  DiagnosticHint = { fg = c.cyan },
  DiagnosticOk = { fg = c.green },
  DiagnosticUnderlineError = { sp = c.red, underline = true },
  DiagnosticUnderlineWarn = { sp = c.orange, underline = true },
  DiagnosticUnderlineInfo = { sp = c.blue, underline = true },
  DiagnosticUnderlineHint = { sp = c.cyan, underline = true },
  DiagnosticVirtualTextError = { fg = c.red, bg = c.bg_dim },
  DiagnosticVirtualTextWarn = { fg = c.orange, bg = c.bg_dim },
  DiagnosticVirtualTextInfo = { fg = c.blue, bg = c.bg_dim },
  DiagnosticVirtualTextHint = { fg = c.cyan, bg = c.bg_dim },

  -- Diff
  DiffAdd = { fg = c.green, bg = c.bg_dim },
  DiffChange = { fg = c.blue, bg = c.bg_dim },
  DiffDelete = { fg = c.red, bg = c.bg_dim },
  DiffText = { fg = c.yellow, bg = c.overlay },

  -- gitsigns.nvim
  GitSignsAdd = { fg = c.green },
  GitSignsChange = { fg = c.blue },
  GitSignsDelete = { fg = c.red },
  GitSignsChangedelete = { fg = c.purple },
  GitSignsTopdelete = { fg = c.red },

  -- Telescope
  TelescopeNormal = { fg = c.fg, bg = surface_bg },
  TelescopeBorder = { fg = c.border, bg = surface_bg },
  TelescopePromptNormal = { fg = c.fg, bg = c.overlay },
  TelescopePromptBorder = { fg = c.border, bg = c.overlay },
  TelescopePromptTitle = { fg = c.bg, bg = c.pink, bold = true },
  TelescopeResultsTitle = { fg = c.bg, bg = c.cyan, bold = true },
  TelescopePreviewTitle = { fg = c.bg, bg = c.green, bold = true },
  TelescopeSelection = { fg = c.fg, bg = c.overlay, bold = true },
  TelescopeMatching = { fg = c.yellow, bold = true },

  -- which-key.nvim
  WhichKey = { fg = c.pink, bold = true },
  WhichKeyGroup = { fg = c.cyan },
  WhichKeyDesc = { fg = c.fg_dim },
  WhichKeySeparator = { fg = c.muted },
  WhichKeyFloat = { bg = surface_bg },

  -- neo-tree.nvim
  NeoTreeNormal = { fg = c.fg_dim, bg = surface_bg },
  NeoTreeNormalNC = { fg = c.fg_dim, bg = surface_bg },
  NeoTreeDirectoryIcon = { fg = c.blue },
  NeoTreeDirectoryName = { fg = c.blue },
  NeoTreeRootName = { fg = c.pink, bold = true },
  NeoTreeGitAdded = { fg = c.green },
  NeoTreeGitModified = { fg = c.orange },
  NeoTreeGitDeleted = { fg = c.red },
  NeoTreeGitUntracked = { fg = c.fg_faint },
  NeoTreeIndentMarker = { fg = c.border },

  -- bufferline.nvim
  BufferLineIndicatorSelected = { fg = c.pink },
  BufferLineFill = { bg = c.bg_dim },

  -- blink.cmp (falls back to Pmenu-based defaults for anything not set here)
  BlinkCmpMenu = { fg = c.fg_dim, bg = c.surface },
  BlinkCmpMenuBorder = { fg = c.border, bg = c.surface },
  BlinkCmpMenuSelection = { fg = c.bg, bg = c.pink, bold = true },
  BlinkCmpDoc = { fg = c.fg_dim, bg = c.surface },
  BlinkCmpDocBorder = { fg = c.border, bg = c.surface },
}

for group, spec in pairs(groups) do
  hl(0, group, spec)
end
