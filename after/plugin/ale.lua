local M = {}

function M.setup()
  vim.g.ale_fixers = { 'eslint', 'prettier' }
  vim.g.ale_fix_on_save = 1
end

M.setup()
