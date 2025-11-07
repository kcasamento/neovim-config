local M = {}

function M.setup()
  require('Comment').setup()
end

return {
  'numToStr/Comment.nvim',
  keys = { 'gc', 'gb' },
  config = M.setup,
}
