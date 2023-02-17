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
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
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
    barnch = 'v2.x',
    module = 'neo-tree',
    cmd = 'Neotree',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      { 'MunifTanjim/nui.nvim', module = 'nui' },
    },
    setup = function() vim.g.neo_tree_legacy_commands = true end,
    config = function() require'keith.plugins.neo-tree' end,
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
    config = function() require('aerial').setup() end
  }

  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'keith.plugins.bufferline' end
  }

  use {
    'mrjones2014/smart-splits.nvim',
    config = function() require'keith.plugins.smart-splits' end,
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    event = "BufEnter",
    -- config = function() require'keith.plugins.null-ls' end
  }

  use {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    module = 'telescope',
    config = function() 
      require'keith.plugins.telescope'
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
      require'keith.plugins.gitsigns'
    end
  }

  use {
    'max397574/better-escape.nvim',
    event = 'InsertCharPre',
  }

  use('nathom/filetype.nvim')


  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require'keith.plugins.lsp_signature'
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
    config = function()
      require('keith.plugins.nvim-test')
    end
  }

  use {
    'scalameta/nvim-metals',
    requires = 'nvim-lua/plenary.nvim'
  }

  use('tpope/vim-fugitive')

  use {
    'williamboman/mason.nvim',
    config = function()
      require'keith.plugins.mason'
    end
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    after = { 'mason.nvim', 'nvim-lspconfig' },
    config = function() 
      require'keith.plugins.mason-lspconfig'
    end

  }

  use 'ray-x/guihua.lua'

  use {
    'ray-x/go.nvim',
    ft = 'go',
    config = function()
      require'keith.plugins.go'
    end
  }


  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('keith.plugins.lspconfig')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('keith.plugins.treesitter-context')
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

  use ('saadparwaiz1/cmp_luasnip')

  use('L3MON4D3/LuaSnip')

  use({
    'numToStr/Comment.nvim',
    module = { 'Comment', 'Comment.api' },
    keys = { 'gc', 'gb' },
    config = function()
      require'keith.plugins.comment'
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
      require'terminal'.setup()
    end
  }

  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = {"kkharji/sqlite.lua"}
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

  use{
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  }


  if packer_bootstrap then
    require('packer').sync()
  end


end)
