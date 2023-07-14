local M = {}

function M.setup()
  local status_ok, neodev = pcall(require, "neodev")
  if not status_ok then return end

  neodev.setup({
    library = {
      plugins = {
        "nvim-dap-ui",
        "nvim-treesitter",
        "plenary.nvim",
        "telescope.nvim",
      },
      types = true
    },
  })
end

return M
