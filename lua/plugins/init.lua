return {
  { "folke/neoconf.nvim", cmd = "Neoconf" },

  "nvim-lua/plenary.nvim",

  {
    'max397574/better-escape.nvim',
    event = 'InsertCharPre',
  },

  {
    'klen/nvim-test',
    cmd = {
      "TestSuite",
      "TestFile",
      "TestNearest",
      "TestLast",
      "TestVisit",
      "TestEdit",
    },
    config = function()
      require 'nvim-test'.setup {}
    end
  },

  {
    'scalameta/nvim-metals',
    dependencies = 'nvim-lua/plenary.nvim'
  },

  'tpope/vim-fugitive',

  'ray-x/guihua.lua',

  'L3MON4D3/LuaSnip',

  'RRethy/nvim-base16',

  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
  },

  'tpope/vim-unimpaired',

  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },

  'Shougo/deoplete.nvim',

  'zchee/deoplete-clang',

  'hashivim/vim-terraform',

  'mfussenegger/nvim-dap',

  {
    'xiyaowong/transparent.nvim',
    lazy = false,
  },

  -- 'TaDaa/vimade',
}
