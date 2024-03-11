local M = {}

function M.setup()
  local status_ok, chatgpt = pcall(require, "chatgpt")
  if not status_ok then return end

  -- api_key_cmd = "op read op://private/openai_api_key/credential --no-newline"
  chatgpt.setup({
    api_key_cmd = "echo $OPENAI_API_KEY",
  })
end

return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = M.setup,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
