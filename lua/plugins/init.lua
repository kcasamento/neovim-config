return {
  { "folke/neoconf.nvim",          cmd = "Neoconf" },

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
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  -- 'TaDaa/vimade',
  'wesQ3/vim-windowswap',
  {
    "LintaoAmons/scratch.nvim",
    event = "VeryLazy",
  },
  { "shortcuts/no-neck-pain.nvim", version = "*" },
  {
    "vinnymeller/swagger-preview.nvim",
    build = "npm install -g swagger-ui-watcher",
    config = function()
      require("swagger-preview").setup({
        -- The port to run the preview server on
        port = 9000,
        -- The host to run the preview server on
        host = "localhost",
      })
    end
  },
  'AndrewRadev/splitjoin.vim',
}
