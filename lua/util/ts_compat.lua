-- Compatibility shim: nvim-treesitter `master` vs Neovim 0.12.
--
-- Upstream nvim-treesitter's README (checked 2026-09-05) says the `master` branch is
-- locked and kept "for backward compatibility with Nvim 0.11"; `main` is the branch
-- that targets 0.12. This machine runs Nvim 0.12.5 on `master`, and one breaking
-- change bites hard.
--
-- Observed on this machine, in the installed source:
--   * runtime/lua/vim/treesitter/query.lua:851 -- `Query:_apply_directives` now hands a
--     directive handler `captures: table<integer, TSNode[]>`, i.e. a LIST of nodes per
--     capture, not a single node.
--   * runtime/lua/vim/treesitter/query.lua:794 -- `add_directive` reads only `opts.force`.
--     The `all = false` opt that nvim-treesitter still passes (its own comment calls it a
--     "compatibility shim for breaking change on nightly/0.11") is no longer honoured.
--
-- So nvim-treesitter's three text-reading directives call `get_node_text()` on a plain
-- Lua table and every affected injection query dies with:
--   /usr/share/nvim/runtime/lua/vim/treesitter.lua:197:
--     attempt to call method 'range' (a nil value)
--
-- Reproduced with `-u NONE` plus only nvim-treesitter on the runtimepath, so this is not
-- caused by any other plugin. It surfaces wherever markdown gets parsed -- the blink.cmp
-- documentation popup, render-markdown.nvim, snacks.indent/scope, and the built-in
-- treesitter highlighter -- and the same three directives are used by the bash, hcl,
-- html_tags, hurl, markdown, php_only and ruby injection queries.
--
-- Below, those three are re-registered with list-aware versions. The unwrapping follows
-- the convention Neovim uses in its own `#gsub!` handler (query.lua): bail on an empty
-- list, otherwise take nodes[1]. The rest of the logic is copied verbatim from
-- nvim-treesitter's lua/nvim-treesitter/query_predicates.lua so behaviour is unchanged.
--
-- DELETE THIS FILE once nvim-treesitter is moved to the `main` branch.

local M = {}

--- Neovim >= 0.12 passes a list of nodes per capture; older versions passed one node.
--- Accept either and return a single TSNode, or nil.
local function first_node(captured)
  if captured == nil then return nil end
  if type(captured) == "table" then return captured[1] end
  return captured -- a bare TSNode (userdata), from an older Neovim
end

-- Copied from nvim-treesitter/query_predicates.lua
local html_script_type_languages = {
  ["importmap"] = "json",
  ["module"] = "javascript",
  ["application/ecmascript"] = "javascript",
  ["text/ecmascript"] = "javascript",
}

-- Copied from nvim-treesitter/query_predicates.lua
local non_filetype_match_injection_language_aliases = {
  ex = "elixir",
  pl = "perl",
  sh = "bash",
  uxn = "uxntal",
  ts = "typescript",
}

local function get_parser_from_markdown_info_string(injection_alias)
  local match = vim.filetype.match { filename = "a." .. injection_alias }
  return match or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
end

--- Re-register the broken directives. Safe to call more than once.
function M.apply()
  local query = require "vim.treesitter.query"
  local force = { force = true }

  query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
    local node = first_node(match[pred[2]])
    if not node then return end

    local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
    if not type_attr_value then return end

    local configured = html_script_type_languages[type_attr_value]
    if configured then
      metadata["injection.language"] = configured
    else
      local parts = vim.split(type_attr_value, "/", {})
      metadata["injection.language"] = parts[#parts]
    end
  end, force)

  query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = first_node(match[pred[2]])
    if not node then return end

    local text = vim.treesitter.get_node_text(node, bufnr)
    if not text then return end

    metadata["injection.language"] = get_parser_from_markdown_info_string(text:lower())
  end, force)

  query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = first_node(match[id])
    if not node then return end

    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
    if not metadata[id] then metadata[id] = {} end
    metadata[id].text = string.lower(text)
  end, force)
end

return M
