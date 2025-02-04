local M = {}

function M.setup()
  require("quicker").setup()
end

return {
  'stevearc/quicker.nvim',
  event = "FileType qf",
  opts = {},
  config = M.setup,
}
