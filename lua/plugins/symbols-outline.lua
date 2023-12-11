local M = {}

function M.setup()
  require("symbols-outline").setup()
end

return {
  'simrat39/symbols-outline.nvim',
  config = M.setup,
}
