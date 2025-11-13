return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
      },

      {
        'fredrikaverpil/neotest-golang',
        version = '*', -- Optional, but recommended; track releases
        build = function()
          vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait() -- Optional, but recommended
        end,
      },
    },
    config = function()
      local config = {
        runner = 'gotestsum', -- Optional, but recommended
      }
      require('neotest').setup {
        adapters = {
          require 'neotest-golang'(config),
        },
        output_panel = {
          enabled = true,
          open = 'botright split | resize 15',
        },
        quickfix = {
          enabled = true,
          open = true,
        },
      }
    end,
    keys = {
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = '[t]est run [f]ile',
      },
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        desc = '[t]est [n]earest',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { last_run = true, enter = true }
        end,
        desc = '[t]est [n]earest',
      },
    },
  },
}
