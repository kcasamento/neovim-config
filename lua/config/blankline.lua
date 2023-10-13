local M = {}

function M.setup()
  local status_ok, blankline = pcall(require, "ibl")
  if not status_ok then return end

  blankline.setup({
    indent = { char = '┊' },
    -- show_trailing_blankline_indent = false,
  })
end

return M
