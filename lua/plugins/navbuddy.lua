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

return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "numToStr/Comment.nvim",            -- Optional
    "nvim-telescope/telescope.nvim"     -- Optional
  },
  config = M.setup,
}
