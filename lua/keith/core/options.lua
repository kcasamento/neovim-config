local opt = vim.opt

-- set leader key to space
vim.g.mapleader = " "

opt.relativenumber = true
opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"

opt.clipboard:append("unnamedplus")

opt.foldenable = false
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldmethod = 'expr'
opt.foldlevel = 99

vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect'
vim.o.breakindent = true

vim.g.icons_enabled = true
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])

vim.g.copilot_no_tab_map = true

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('MyGroup', {}),
  callback = function(ev)
    local nmap = function(keys, func, desc)
      local bufnr = ev.buf
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true })
    end

    local opts = { noremap = true, silent = true, buffer = ev.buf }

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    nmap('<leader>ld', vim.diagnostic.open_float, "Diagnostic Open Float")
    nmap('<leader>ca', vim.lsp.buf.code_action, "Code Action")
    nmap('K', vim.lsp.buf.hover, "Hover")
    nmap('gd', function() require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' }) end,
      "Go to Definition")
    nmap('gi', function() require 'telescope.builtin'.lsp_implementations({ initial_mode = 'normal' }) end,
      "Go to Implementations")
    nmap('gr', function() require('telescope.builtin').lsp_references() end, "Go to References")

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
  end,
})
