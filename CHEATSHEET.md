# Neovim Cheatsheet — your config, explained for first-timers

This is **your** config: raw `lazy.nvim` (no AstroNvim/LazyVim distro on top), modeled on
Josean's 2024 guide, updated to what's current, and tailored for CCNA + hackpath.dev work.
Every bind below is either exactly what Josean uses, or marked **[NEW]** if it was added for you.

## The one concept you need first: the Leader key

`<leader>` = **Spacebar**. Almost every custom bind below starts by tapping Space, then a
short sequence of letters that spell out what it does (`<leader>ff` = "**f**ind **f**iles").

**Press Space and wait a beat** — a popup (which-key) shows you every option from there.
You genuinely do not need to memorize this document; use it as a reference, then let
which-key teach you by browsing.

`gX` binds (like `gd`, `gR`) are Neovim/LSP convention, not part of this leader system —
they jump ("**g**o") somewhere related to code intelligence.

---

## First 10 minutes — try these in order

1. Open Neovim with no file (`nvim`) — you'll see the dashboard.
2. `<leader>ff` — fuzzy-find and open a file in the current folder.
3. `<leader>ee` — toggle the file tree sidebar.
4. Move between the sidebar and your file with `Ctrl-h` / `Ctrl-l`.
5. `jk` (in insert mode) — leaves insert mode, same as `Esc`, but you never leave home row.
6. `<leader>sv` — split the window vertically; `Ctrl-h/l` to jump between the splits.
7. Open a `.py` or `.lua` file, put the cursor on a function name, press `K` — hover docs.
8. `<leader>tt` — toggle a transparent background for the `duskrose` colorscheme.
9. `<leader>lg` — opens `lazygit` in a floating terminal, if you have `lazygit` installed.
10. Press Space alone and just look at the popup for 10 seconds. That's the whole trick.

---

## Insert mode / general

| Key | Does | Notes |
|---|---|---|
| `jk` | Exit insert mode | Faster than reaching for `Esc` |
| `<leader>nh` | Clear search highlighting | After a `/search`, this turns off the highlight |
| `<leader>+` | Increment number under cursor | Works on `1`, `-1`, dates, etc. |
| `<leader>-` | Decrement number under cursor | |
| `<` / `>` (visual mode) | Indent left/right, stay selected | **[NEW]** normally Vim kicks you out of visual mode after one indent — this lets you tap repeatedly |
| `Ctrl-d` / `Ctrl-u` | Half-page down/up, cursor stays centered | **[NEW]** default Vim scrolls but doesn't recenter |

## Windows (splits)

A "split" is one pane inside the Neovim window — useful for viewing two files (e.g. a script
and its config) side by side.

| Key | Does |
|---|---|
| `<leader>sv` | Split window **v**ertically (side by side) |
| `<leader>sh` | Split window **h**orizontally (top/bottom) |
| `<leader>se` | **E**qualize all split sizes |
| `<leader>sx` | Close current split |
| `<leader>sm` | Maximize/zoom current split (toggle) — great for focusing on one file |
| `Ctrl-h/j/k/l` | Move to the split left/below/above/right | Also works across **tmux** panes if you use tmux |
| `Alt-h/j/k/l` | Resize the current split in that direction |

## Tabs

Tabs here mean full-window layouts (like browser tabs), not editor indentation.

| Key | Does |
|---|---|
| `<leader>to` | Open a new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>tf` | Open current buffer in a new tab |

## File explorer (neo-tree)

| Key | Does |
|---|---|
| `<leader>ee` | Toggle the file tree sidebar |
| `<leader>ef` | Reveal the **current file** in the tree (jumps + opens tree if closed) |
| `<leader>ec` | Close the file tree |
| `<leader>er` | Refresh the file tree (rarely needed, it auto-refreshes) |

Inside the tree: `Enter` opens a file, `a` creates a new file/folder, `d` deletes, `r` renames,
`H` toggles hidden files.

## Find things (Telescope)

Telescope is a fuzzy finder — type a few letters of what you want, it filters live.

| Key | Does |
|---|---|
| `<leader>ff` | **F**ind **f**iles in the current folder |
| `<leader>fr` | **F**ind **r**ecently opened files |
| `<leader>fs` | **F**ind **s**tring — live grep, searches file *contents* across the whole folder |
| `<leader>fc` | **F**ind the word under your **c**ursor across the whole folder |
| `<leader>ft` | **F**ind **T**ODO/FIXME/HACK comments in the project |
| `<leader>fb` | **[NEW]** **F**ind open **b**uffers |
| `<leader>fh` | **[NEW]** **F**ind **h**elp — search Neovim's built-in documentation |

Inside any Telescope window: `Ctrl-j`/`Ctrl-k` move the selection, `Enter` opens it,
`Ctrl-q` sends all results to the quickfix list (a batch-edit list), `Esc` cancels.

## Session

Remembers which files/splits you had open in a given folder, so you can pick up where you left off.

| Key | Does |
|---|---|
| `<leader>ws` | **W**rite/**s**ave a session for the current folder |
| `<leader>wr` | **W**rite/**r**estore — reopen the saved session for the current folder |

## LSP (code intelligence — go to definition, hover docs, errors, rename)

An LSP ("Language Server") is a background process (e.g. `basedpyright` for Python) that
understands your code well enough to tell you where things are defined, what a function's
signature is, and what's wrong with your syntax. These binds work in any file that has one
attached (check with `:LspInfo`).

| Key | Does |
|---|---|
| `K` | Hover docs for whatever's under the cursor |
| `gd` | **G**o to **d**efinition |
| `gD` | **G**o to **D**eclaration (rare — mostly a C/C++ distinction) |
| `gR` | Show all **R**eferences to this symbol, project-wide |
| `gi` | **G**o to **i**mplementation |
| `gt` | **G**o to **t**ype definition |
| `<leader>ca` | **C**ode **a**ction — quick fixes Neovim suggests (e.g. "add missing import") |
| `<leader>rn` | **R**e**n**ame this symbol everywhere it's used |
| `<leader>d` | Show the diagnostic (error/warning) on the current line |
| `<leader>D` | Show all **D**iagnostics for the whole buffer |
| `[d` / `]d` | Jump to previous/next diagnostic |
| `<leader>rs` | **R**e**s**tart the LSP server (fixes it if it gets stuck) |

## Trouble (a nicer list of problems)

A full-screen, organized list of diagnostics/todos — easier to scan than jumping one at a time.

| Key | Does |
|---|---|
| `<leader>xw` | All diagnostics, whole **w**orkspace |
| `<leader>xd` | Diagnostics for the current **d**ocument only |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xt` | TODO comments |

`q` closes any Trouble/help/quickfix window.

## Formatting & linting

Formatting = auto-fixing code *style* (indentation, quotes). Linting = flagging *problems*
(unused variable, shell script footgun) without changing your code.

| Key | Does | Uses |
|---|---|---|
| `<leader>mp` | Format the file (or selection in visual mode) | `stylua` (Lua), `shfmt` (Bash), `ruff format` (Python) |
| `<leader>l` | Run the linter on the current file | `shellcheck` (Bash) — Python linting comes from `ruff`'s LSP diagnostics automatically |

Neither runs automatically on save — you stay in control of when formatting happens.

## Git (gitsigns + lazygit)

A "hunk" is one contiguous block of changed lines — like one entry in a diff.

| Key | Does |
|---|---|
| `]h` / `[h` | Jump to next/previous changed hunk |
| `<leader>hs` | **S**tage hunk |
| `<leader>hr` | **R**eset (discard) hunk |
| `<leader>hS` | **S**tage whole buffer |
| `<leader>hR` | **R**eset whole buffer |
| `<leader>hu` | **U**ndo last stage |
| `<leader>hp` | **P**review hunk diff inline |
| `<leader>hb` | **B**lame current line (who/when changed it) |
| `<leader>hB` | Toggle inline **b**lame on every line |
| `<leader>hd` | **D**iff current file against the index |
| `<leader>hD` | **D**iff against the previous commit |
| `ih` (in visual/operator mode, e.g. `dih`) | Select a git hunk as a text object |
| `<leader>lg` | Open **l**azy**g**it — a full terminal UI for git — in a floating window. Requires `lazygit` installed on your system separately (`sudo dnf install lazygit` on Fedora). |

## Text manipulation

| Key | Does |
|---|---|
| `s{motion}` | Substitute: delete text covered by a motion, then paste your last yank in its place. E.g. `sw` replaces a word with your clipboard/register content. |
| `ss` | Substitute the whole line |
| `S` | Substitute from cursor to end of line |
| `s` (visual mode) | Substitute the selection |
| `ys{motion}{char}` | **Y**ank-**s**urround: wrap text in a character. E.g. `ysiw"` wraps the word under the cursor in quotes. (nvim-surround default bind, not remapped) |
| `cs{old}{new}` | **C**hange **s**urrounding character, e.g. `cs"'` turns `"text"` into `'text'` |
| `ds{char}` | **D**elete **s**urrounding character, e.g. `ds"` removes quotes |
| `gcc` | Comment/uncomment the current line | Built into Neovim itself now — no plugin needed |
| `gc{motion}` | Comment/uncomment over a motion, e.g. `gcap` comments a paragraph |

## Treesitter (structural selection)

| Key | Does |
|---|---|
| `Ctrl-Space` | Start/expand an intelligent selection (selects the syntax node under the cursor, then its parent, etc.) |
| `Backspace` | Shrink the selection back down |

## Autocomplete (blink.cmp)

Pops up automatically as you type in insert mode.

| Key | Does |
|---|---|
| `Ctrl-j` / `Ctrl-k` | Next/previous suggestion |
| `Enter` | Accept the highlighted suggestion |
| `Ctrl-Space` | Manually open the menu / toggle its documentation panel |
| `Ctrl-e` | Dismiss the menu without accepting |
| `Ctrl-b` / `Ctrl-f` | Scroll the documentation preview |

## Theme (duskrose) — **[NEW, not in Josean's guide]**

A custom colorscheme, hand-written for this config at `colors/duskrose.lua` — no external
theme plugin. It blends rose-pine's calm, muted dark-plum base with dracula's punchier,
more saturated accents: eight accent hues (red, orange, yellow, green, cyan, blue, purple,
pink), each a deliberate mix of the two rather than a straight copy of either.

| Key | Does |
|---|---|
| `<leader>tt` | Toggle a transparent background on/off |

Want a different look entirely? Just ask — swapping in another colorscheme or tweaking
`colors/duskrose.lua`'s palette table is a small change.

## Markdown notes — **[NEW]**

| Key | Does |
|---|---|
| `<leader>mr` | Toggle rendered view of a Markdown file (headings/lists/code blocks styled) vs. raw text — handy for CCNA notes/writeups |

## REST client (kulala.nvim) — **[NEW]**

Write an HTTP request in a `.http` file (e.g. `GET https://example.com/api`) and send it
without leaving Neovim — useful for API/web testing on hackpath.dev.

| Key | Does |
|---|---|
| `<leader>Rs` | Send the request under the cursor |
| `<leader>Ra` | Send every request in the file |
| `<leader>Rb` | Open a scratchpad to try a one-off request |

## Other useful commands (not keybinds, typed as `:Command`)

| Command | Does |
|---|---|
| `:Lazy` | Plugin manager UI — see/update/install plugins |
| `:Mason` | LSP/tool installer UI |
| `:LspInfo` | See which LSP servers are attached to the current buffer |
| `:checkhealth` | Diagnose your Neovim setup for missing dependencies |
| `:Telescope` | Browse every Telescope picker available (if you forget a `<leader>f_` bind) |

---

## What's installed and why (quick reference)

- **LSPs** (via Mason): `lua_ls`, `bashls` + `shellcheck`, `basedpyright` + `ruff` (Python),
  `yamlls`, `jsonls`, `marksman` (Markdown), `dockerls`, `taplo` (TOML) — picked for shell
  scripting, Python tooling, and network-automation config files rather than web dev.
- **Formatters**: `stylua`, `shfmt`, `ruff format`.
- **Explorer**: neo-tree · **Finder**: Telescope · **Completion**: blink.cmp
- **Theme**: `duskrose` — custom, hand-written, rose-pine × dracula blend (see above)
- **Dashboard/indent/notifications/zoom**: snacks.nvim
- **Splits + tmux navigation**: smart-splits.nvim
- **HTTP client**: kulala.nvim

No debugger (`nvim-dap`) is set up yet — ask if/when you want one for Python script debugging.
