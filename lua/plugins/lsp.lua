-- LSP stack: mason installs the servers, mason-lspconfig wires them up using Neovim's native
-- vim.lsp.enable()/vim.lsp.config() (nvim 0.11+), reading per-server overrides from ~/.config/nvim/lsp/*.lua.
-- nvim-lspconfig is only a dependency here for its bundled default server configs — no more
-- `require('lspconfig').xxx.setup{}` calls anywhere in this config.

-- Keymaps + diagnostics: registered once, apply to any buffer an LSP attaches to.
vim.diagnostic.config {
  virtual_text = { prefix = "●" },
  severity_sort = true,
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
  callback = function(event)
    local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc }) end

    map("n", "gR", "<cmd>Telescope lsp_references<CR>", "LSP: show references")
    map("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
    map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "LSP: go to definition")
    map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "LSP: go to implementation")
    map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "LSP: go to type definition")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: rename symbol")
    map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "LSP: buffer diagnostics")
    map("n", "<leader>d", vim.diagnostic.open_float, "LSP: line diagnostics")
    map("n", "[d", function() vim.diagnostic.jump { count = -1, float = true } end, "LSP: previous diagnostic")
    map("n", "]d", function() vim.diagnostic.jump { count = 1, float = true } end, "LSP: next diagnostic")
    map("n", "K", vim.lsp.buf.hover, "LSP: hover documentation")
    map("n", "<leader>rs", "<cmd>LspRestart<CR>", "LSP: restart server")
  end,
})

return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp", -- so LSP servers gain blink's completion capabilities automatically
    },
    opts = {
      ensure_installed = {
        "lua_ls", -- edits this very config
        "bashls", -- shell scripts (labs, CTFs, automation)
        "basedpyright", -- Python (scripting, scapy, requests, exploit-dev)
        "ruff", -- Python lint + import sort, pairs with basedpyright
        "yamlls", -- Ansible / network-automation / compose files
        "jsonls", -- API payloads, configs
        "marksman", -- Markdown study notes
        "dockerls", -- lab containers
        "taplo", -- TOML configs
      },
      -- automatic_enable = true would enable ANY mason-installed tool that happens to
      -- match a known lspconfig server name — not just the servers above. stylua ships
      -- a real LSP mode that nvim-lspconfig knows about, so with `true` it silently
      -- attaches itself to every Lua buffer even though it's only installed here as a
      -- formatter (see lua/plugins/formatting.lua). Scoping this to the exact list above
      -- is the fix mason-lspconfig's own docs recommend for this.
      automatic_enable = {
        "lua_ls",
        "bashls",
        "basedpyright",
        "ruff",
        "yamlls",
        "jsonls",
        "marksman",
        "dockerls",
        "taplo",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "stylua", -- lua formatter
        "shfmt", -- shell formatter
        "shellcheck", -- shell linter
        "debugpy", -- Python debug adapter, used by lua/plugins/dap.lua
        "nixfmt", -- nix formatter for nixos-config
      },
    },
  },
  { "neovim/nvim-lspconfig", lazy = true },
}
