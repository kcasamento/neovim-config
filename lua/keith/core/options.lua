local opt = vim.opt

vim.cmd.colorscheme("rose-pine")

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


vim.g.icons_enabled = true
