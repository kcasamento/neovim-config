return {
  'navarasu/onedark.nvim',

  'marko-cerovac/material.nvim',

  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        transparent_background = false,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
      })
    end
  },
}
