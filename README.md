# 🐧 nikhil-nvim

![Neovim](https://img.shields.io/badge/Neovim-0.11%2B-57A143?style=flat&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white)
![Managed by lazy.nvim](https://img.shields.io/badge/plugins-lazy.nvim-blueviolet?style=flat)
![Made for CCNA / hackpath.dev](https://img.shields.io/badge/made%20for-CCNA%20%2B%20hackpath.dev-orange?style=flat)

A from-scratch, raw **lazy.nvim** config (no distro layer — no AstroNvim/LazyVim) built for
network/security study: CCNA labs, shell scripting, Python tooling, and API/HTTP work on
[hackpath.dev](https://hackpath.dev). Every keybind is explained in [`CHEATSHEET.md`](./CHEATSHEET.md)
in plain English, written for someone opening Neovim seriously for the first time.

---

## 🎨 Theming

Colors are **dynamic when your desktop supports it, static everywhere else** — no setup step
either way:

- On a machine running **[Noctalia](https://github.com/noctalia-dev/noctalia-shell)** with its
  "neovim" community template applied, `lua/matugen.lua` gets rendered from your *live* desktop
  theme and hot-reloaded into any running `nvim` the moment you switch themes (`SIGUSR1`-driven,
  see `lua/plugins/base16.lua`).
- Everywhere else, it falls back automatically to a static **gruvbox dark** palette. No Noctalia
  required, no error, no blank colorscheme.

`lua/matugen.lua` is machine-generated and gitignored on purpose — committing it would just make
it go stale the moment you change themes.

## 📋 Requirements

Confirmed by actually testing a fresh clone on a bare VM (no desktop environment at all):

| Requirement | Why |
|---|---|
| **Neovim 0.11+** | Native `vim.lsp.enable()` / `lsp/*.lua` config loading. Most distro package managers ship something older — grab a current build from [neovim/neovim releases](https://github.com/neovim/neovim/releases) if `nvim --version` is behind. |
| **git** | Plugin management (lazy.nvim clones everything on first launch). |
| **A C compiler** (`gcc`/`clang`) | Treesitter compiles its own parsers on install. |
| **`unzip`** | Mason needs it to unpack some LSP/tool release archives. |
| **`ripgrep`** | Telescope live grep (`<leader>fg`). |
| **`fd`** | Telescope file finding. On Debian/Ubuntu this installs as `fd-find`/`fdfind` — symlink it to `fd` on your `$PATH` if Telescope can't find it. |
| **Node.js** | A few LSPs are npm packages under the hood (`bashls`, `jsonls`, `yamlls`, `dockerls`, `basedpyright`). |

## 🚀 Quick start

```sh
git clone https://github.com/NagaNikhilP/nikhil-nvim.git ~/.config/nvim
nvim
```

First launch installs every plugin (`lazy.nvim`) and every LSP/formatter/linter (`mason.nvim`)
automatically — just wait for it to settle, then restart `nvim` once.

## 🗂️ Structure

```
~/.config/nvim/
├── init.lua                # bootstraps lazy.nvim
├── lua/
│   ├── config/              # options, keymaps, autocmds, lazy.nvim setup
│   └── plugins/              # one file per plugin/feature area
├── lsp/                     # native per-server LSP overrides (nvim 0.11+ convention)
├── CHEATSHEET.md             # full beginner-friendly keybind reference
└── lazy-lock.json            # pinned plugin versions, committed for reproducibility
```

## 🛠️ What's inside

- **Explorer**: neo-tree · **Finder**: Telescope + fzf-native · **Completion**: blink.cmp
- **LSP**: native `vim.lsp.enable()`, servers installed via mason.nvim — `lua_ls`, `bashls`,
  `basedpyright` + `ruff` (Python), `yamlls`, `jsonls`, `marksman`, `dockerls`, `taplo`
- **Formatting/linting**: conform.nvim (`stylua`, `shfmt`, `ruff format`) + nvim-lint
- **Dashboard/indent/notifications/zoom**: snacks.nvim
- **Splits + tmux-aware navigation**: smart-splits.nvim
- **Sessions**: auto-session — restore is opt-in (`<leader>wr`), bare `nvim` always opens the
  dashboard, `nvim <dir>` opens that directory in neo-tree
- **HTTP client**: kulala.nvim — API/web testing without leaving the editor
- **Markdown**: render-markdown.nvim, for readable study notes

## ⌨️ Keybinds

Every single bind, explained for a first-time user → **[`CHEATSHEET.md`](./CHEATSHEET.md)**.

The short version: press `<Space>` and wait — which-key shows you everything available from
wherever you are.
