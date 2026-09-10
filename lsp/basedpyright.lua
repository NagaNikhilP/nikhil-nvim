-- Type checking / go-to-definition for Python. Import sorting/linting is left to ruff.lua
-- to avoid the two servers fighting over the same job.
return {
  -- Point the server at the project's virtualenv, so `import requests` resolves instead of
  -- showing a red squiggle just because the package isn't installed system-wide.
  --
  -- NOTE: this mutates config.settings IN PLACE rather than replacing it, which is what
  -- nvim's own `before_init` docstring suggests. The client copies `config.settings` into
  -- `client.settings` when it is constructed (runtime/lua/vim/lsp/client.lua:409), but
  -- before_init only runs later (:571). Assigning a *new* table here would leave
  -- client.settings pointing at the old one, and that old one is what gets sent in
  -- workspace/didChangeConfiguration (:601). Mutating the existing table avoids that.
  before_init = function(_, config)
    local python = config.settings.python or {}
    python.pythonPath = require("util.python").interpreter(config.root_dir)
    config.settings.python = python
  end,
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- ruff handles this
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
