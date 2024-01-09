local M = {}

function M.setup()
  require("ibl").setup({
    indent = { char = '┊' },
  })
end

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = M.setup,
  }
}
