-- Fast Python linter (diagnostics only here — formatting is handled by conform.nvim's
-- ruff_format, see lua/plugins/formatting.lua). Hover is disabled so basedpyright's
-- richer hover is the only one shown on `K`.
return {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
