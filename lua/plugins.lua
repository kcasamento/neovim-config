local M = {}

function M.setup()
  -- auto install packer if not installed
  local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
      vim.cmd([[packadd packer.nvim]])
      return true
    end
    return false
  end
  local packer_bootstrap = ensure_packer() -- true if packer was just installed

  -- autocommand that reloads neovim and installs/updates/removes plugins
  -- when file is saved
  vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
  ]])

  -- import packer safely
  local status, packer = pcall(require, "packer")
  if not status then
    return
  end

  return packer.startup(function(use)
    -- packer can manage itself
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

    use 'xiyaowong/nvim-transparent'

    use({
      'rose-pine/neovim',
      as = 'rose-pine',
    })

    use("nvim-telescope/telescope-live-grep-args.nvim")

    use {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
      },
      setup = function() vim.g.neo_tree_legacy_commands = false end,
      config = function() require 'config.neo-tree'.setup() end,
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
    }

    use {
      'JoosepAlviste/nvim-ts-context-commentstring',
      after = 'nvim-treesitter',
    }

    use {
      'stevearc/aerial.nvim',
      config = function() require('config.aerial').setup() end
    }

    use {
      'akinsho/bufferline.nvim',
      tag = "v3.*",
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require 'config.bufferline'.setup() end
    }

    use {
      'mrjones2014/smart-splits.nvim',
      config = function() require 'config.smart-splits'.setup() end,
    }

    use {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      module = 'telescope',
      config = function()
        require 'config.telescope'.setup()
      end
    }

    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      after = 'telescope.nvim',
      disable = vim.fn.executable "make" == 0,
      run = "make",
      config = function()

      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      event = 'BufEnter',
      config = function()
        require 'config.gitsigns'.setup()
      end
    }

    use {
      'max397574/better-escape.nvim',
      event = 'InsertCharPre',
    }

    use {
      'ray-x/lsp_signature.nvim',
      config = function()
        require 'config.lsp_signature'.setup()
      end
    }

    use {
      'klen/nvim-test',
      cmd = {
        "TestSuite",
        "TestFile",
        "TestNearest",
        "TestLast",
        "TestVisit",
        "TestEdit",
      },
    }

    use {
      'scalameta/nvim-metals',
      requires = 'nvim-lua/plenary.nvim'
    }

    use('tpope/vim-fugitive')

    use {
      'williamboman/mason.nvim',
      config = function()
        require 'config.mason'.setup()
      end
    }

    use {
      'williamboman/mason-lspconfig.nvim',
      after = { 'mason.nvim', 'nvim-lspconfig' },
      config = function()
        require 'config.mason-lspconfig'.setup()
      end
    }

    use 'ray-x/guihua.lua'

    use {
      'ray-x/go.nvim',
      ft = 'go',
      config = function()
        require 'config.go'.setup()
      end
    }

    use({
      'ray-x/navigator.lua',
      requires = {
        { 'ray-x/guihua.lua',     run = 'cd lua/fzy && make' },
        { 'neovim/nvim-lspconfig' },
      },
      config = function()
        require 'config.navigator'.setup()
      end
    })

    use {
      'neovim/nvim-lspconfig',
      -- Currently trying out Navigator
      -- which has all the lsp configs
      -- config = function()
      --   require 'config.lsp'.setup()
      -- end
    }

    use {
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require 'config.treesitter-context'.setup()
      end
    }

    use({
      'hrsh7th/nvim-cmp',
    })

    use({
      'hrsh7th/cmp-path',
    })

    use({
      'hrsh7th/cmp-nvim-lsp',
    })

    use('saadparwaiz1/cmp_luasnip')

    use('L3MON4D3/LuaSnip')

    use({
      'numToStr/Comment.nvim',
      module = { 'Comment', 'Comment.api' },
      keys = { 'gc', 'gb' },
      config = function()
        require 'config.comment'.setup()
      end
    })

    use 'RRethy/nvim-base16'

    use({
      'nvim-lualine/lualine.nvim',
      requires = {
        { 'RRethy/nvim-base16', opt = false },
        {
          'kyazdani42/nvim-web-devicons',
          opt = true,
        }
      }
    })

    use({
      'famiu/bufdelete.nvim',
      cmd = { 'Bdelete', 'Bwipeout' },
    })

    use 'tpope/vim-unimpaired'

    use 'camgraff/telescope-tmux.nvim'
    use {
      'norcalli/nvim-terminal.lua',
      config = function()
        require 'terminal'.setup()
      end
    }

    use {
      "nvim-telescope/telescope-frecency.nvim",
      requires = { "kkharji/sqlite.lua" }
    }

    use { "nvim-telescope/telescope-file-browser.nvim" }

    use 'mbbill/undotree'

    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
      ft = { "markdown" },
    }

    use 'kkvh/vim-docker-tools'

    use 'Shougo/deoplete.nvim'

    use 'zchee/deoplete-clang'

    use 'dense-analysis/ale'

    use 'hashivim/vim-terraform'

    if packer_bootstrap then
      require('packer').sync()
    end
  end)
end

return M
