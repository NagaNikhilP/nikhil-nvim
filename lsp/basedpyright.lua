-- Type checking / go-to-definition for Python. Import sorting/linting is left to ruff.lua
-- to avoid the two servers fighting over the same job.
return {
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
