local M = {}

function M.setup()
  local status_ok, smart_splits = pcall(require, "smart-splits")
  if not status_ok then return end
  smart_splits.setup({
    ignored_filetypes = {
      "nofile",
      "quickfix",
      "qf",
      "prompt",
    },
    ignored_buftypes = { "nofile" },
  })
end

return {
  'mrjones2014/smart-splits.nvim',
  config = M.setup,
}
