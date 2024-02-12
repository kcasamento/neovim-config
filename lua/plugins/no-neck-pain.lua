local M = {}

function M.setup()
  require('no-neck-pain').setup({
    width = 200,
    autocmds = {
      enableOnVimEnter = true,
    },
  })
end

return {
  'shortcuts/no-neck-pain.nvim',
  version = '*',
  config = M.setup,
}
