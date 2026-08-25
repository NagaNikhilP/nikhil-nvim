-- Native nvim 0.11+ LSP config file — merged automatically with nvim-lspconfig's default
-- for this server name. See `:h lsp-config`.
return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}
