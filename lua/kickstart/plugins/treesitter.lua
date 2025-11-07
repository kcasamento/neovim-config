return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      local langs = {
        'go',
        'javascript',
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      }
      require('nvim-treesitter').setup {}

      require('nvim-treesitter').install(langs)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = langs,
        callback = function()
          vim.treesitter.start()
        end,
      })

      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  },
}
