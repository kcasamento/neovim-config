local M = {}

function M.setup()
  local status_ok, oil = pcall(require, "oil")
  if not status_ok then return end

  oil.setup({
    view_options = {
      show_hidden = true,
    }
  })
end

return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = M.setup,
}
