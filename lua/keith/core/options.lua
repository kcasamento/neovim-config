local opt = vim.opt

-- set leader key to space
vim.g.mapleader = " "

-- add chars for tabs and spaces, etc
-- opt.list = true
-- opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.relativenumber = true
opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

-- Save undo history
opt.undofile = true

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

opt.termguicolors = true
opt.background = "dark"

opt.clipboard:append("unnamedplus")

opt.foldenable = false
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldmethod = 'expr'
opt.foldlevel = 99

-- opt.conceallevel = 1

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
    --
    -- NOTE: mappings I use most often and are setup propertly
    nmap('<leader>ld', vim.diagnostic.open_float, "Diagnostic Open Float")
    nmap('<leader>ca', vim.lsp.buf.code_action, "Code Action")
    nmap('K', vim.lsp.buf.hover, "Hover")
    nmap('gd', function() require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' }) end,
      "Go to Definition")
    nmap('gi', function() require 'telescope.builtin'.lsp_implementations({ initial_mode = 'normal' }) end,
      "Go to Implementations")
    nmap('gr', function() require('telescope.builtin').lsp_references() end, "Go to References")

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    -- Fuzzy find all the symbols in your current workspace
    --  Similar to document symbols, except searches over your whole project.
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- TODO: figure these out someday, do I need them
    -- what do they do, use the 'nmap' func, etc
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
  end,
})
