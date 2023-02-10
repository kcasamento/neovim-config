local status_ok, go = pcall(require, 'go')

if not status_ok then return end

local capabilities = require"cmp_nvim_lsp".default_capabilities()

go.setup({
  max_line_len = 100,
  goimport = "gopls",
  icons = false,
  fillstruct = "gopls",
  dap_debug = true,
  dap_debug_gui = true,
  -- lsp_cfg = {
  --   capabilities = capabilities,
  --   settings = {
  --     gopls = {
  --       codelenses = {
  --         generate = true,
  --         gc_details = false,
  --         test = true,
  --         tidy = true,
  --       },
  --       analyses = {
  --         unusedparams = true,
  --       },
  --     },
  --   },
  -- },
  lsp_gofumpt = true,
  -- lsp_keymaps = false,
  -- lsp_on_attach = astronvim.lsp and astronvim.lsp.on_attach or nil,
  lsp_diag_virtual_text = true,
  dap_debug_keymap = false,
  textobjects = false,
})

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})
