local M = {}

function M.setup()
  local status_ok, go = pcall(require, 'go')
  if not status_ok then return end

  go.setup({
    -- max_line_len = 100,
    goimports = "gopls",
    icons = false,
    fillstruct = "gopls",
    dap_debug = true,
    dap_debug_gui = true,
    lsp_gofumpt = true,
    -- lsp_diag_virtual_text = true,
    dap_debug_keymap = false,
    lsp_inlay_hints = {
      enable = false,
    },
    textobjects = false,
  })
  --
  local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      require('go.format').goimport()
    end,
    group = format_sync_grp,
  })
end

return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = M.setup,
  event = { "CmdlineEnter" },
  ft = { "go", 'gomod' },
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
