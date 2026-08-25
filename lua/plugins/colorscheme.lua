-- omni.nvim: one theme, seven flavours (blackout, moss, dusk, frost, blossom, ember, velvet).
-- Adds a picker + transparency toggle + remembers your last choice across restarts (none of
-- that ships with the plugin itself — small additions on top).
local state_file = vim.fn.stdpath("state") .. "/omni_theme.txt"
local flavours = { "blackout", "moss", "dusk", "frost", "blossom", "ember", "velvet" }

local function read_saved_flavour()
  local f = io.open(state_file, "r")
  if not f then
    return "blackout"
  end
  local flavour = f:read("*l")
  f:close()
  return flavour or "blackout"
end

local function save_flavour(flavour)
  local f = io.open(state_file, "w")
  if f then
    f:write(flavour)
    f:close()
  end
end

return {
  "harshrajsachan/omni.nvim",
  lazy = false,
  priority = 1000,
  keys = {
    {
      "<leader>th",
      function()
        vim.ui.select(flavours, { prompt = "omni.nvim flavour" }, function(choice)
          if not choice then
            return
          end
          vim.cmd.colorscheme(choice)
          save_flavour(choice)
        end)
      end,
      desc = "Pick colorscheme flavour",
    },
    {
      "<leader>tt",
      function()
        vim.g.omnitheme_transparent = not vim.g.omnitheme_transparent
        vim.cmd.colorscheme(read_saved_flavour())
      end,
      desc = "Toggle transparent background",
    },
  },
  config = function()
    vim.g.omnitheme_transparent = false
    vim.cmd.colorscheme(read_saved_flavour())
  end,
}
