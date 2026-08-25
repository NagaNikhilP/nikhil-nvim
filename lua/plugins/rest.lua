-- kulala.nvim: an in-editor HTTP client (write requests in a .http file, send, see the response).
-- Kept from the existing install — genuinely useful for API/web-app testing on hackpath.dev
-- without leaving Neovim for Postman/curl.
return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  keys = {
    { "<leader>Rs", function() require("kulala").run() end, desc = "REST: send request" },
    { "<leader>Ra", function() require("kulala").run_all() end, desc = "REST: send all requests in file" },
    { "<leader>Rb", function() require("kulala").scratchpad() end, desc = "REST: open scratchpad" },
  },
  opts = {},
}
