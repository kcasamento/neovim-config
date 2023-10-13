local M = {}

function M.setup()
  local status_ok, navbuddy = pcall(require, "nvim-navbuddy")
  if not status_ok then return end

  navbuddy.setup({
    lsp = {
      auto_attach = true,
    }
  })
end

return M
