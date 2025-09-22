local M = {}

function M.setup()
  -- Example mapping to toggle outline
  vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
    { desc = "Toggle Outline" })

  require("outline").setup {
    -- Your setup opts here (leave empty to use defaults)
  }
end

return {
  "hedyhli/outline.nvim",
  config = M.setup,
}
