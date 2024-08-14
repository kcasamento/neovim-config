return {
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme "gruber-darker"
      vim.cmd.colorscheme "gruvbuddy"
      -- vim.cmd.colorscheme "ayu"
    end,
  },
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
  {
    "Shatur/neovim-ayu",
    config = function()
      require('ayu').setup({
        overrides = function()
          if vim.o.background == 'dark' then
            return { NormalNC = { bg = '#0f151e', fg = '#808080' } }
          else
            return { NormalNC = { bg = '#f0f0f0', fg = '#808080' } }
          end
        end
      })
    end
  },
  {
    "blazkowolf/gruber-darker.nvim"
  },
  -- {
  --   'thimc/gruber-darker.nvim',
  --   config = function()
  --     require('gruber-darker').setup({
  --       -- OPTIONAL
  --       transparent = false, -- removes the background
  --       -- underline = false, -- disables underline fonts
  --       -- bold = false, -- disables bold fonts
  --     })
  --   end,
  -- }
}
