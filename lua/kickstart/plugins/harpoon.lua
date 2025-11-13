local M = {}

function M.setup()
  local status_ok, harpoon = pcall(require, 'harpoon')
  if not status_ok then
    return
  end

  harpoon:setup {
    settings = {
      save_on_toggle = true,
    },
  }

  harpoon:extend {
    UI_CREATE = function(cx)
      vim.keymap.set('n', '<C-v>', function()
        harpoon.ui:select_menu_item { vsplit = true }
      end, { buffer = cx.bufnr })

      vim.keymap.set('n', '<C-x>', function()
        harpoon.ui:select_menu_item { split = true }
      end, { buffer = cx.bufnr })

      vim.keymap.set('n', '<C-t>', function()
        harpoon.ui:select_menu_item { tabedit = true }
      end, { buffer = cx.bufnr })
    end,
  }

  vim.keymap.set('n', '<leader>ha', function()
    harpoon:list():add()
  end, { desc = '[H]arpoon [A]dd to list' })

  vim.keymap.set('n', '<leader>ho', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = '[H]arpoon [O]pen window' })
end

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = M.setup,
}
