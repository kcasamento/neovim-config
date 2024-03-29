local M = {}

function M.setup()
  local status_ok, Comment = pcall(require, "Comment")
  if not status_ok then return end

  local utils = require "Comment.utils"
  Comment.setup({
    pre_hook = function(ctx)
      local location = nil
      if ctx.ctype == utils.ctype.blockwise then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring {
        key = ctx.ctype == utils.ctype.linewise and "__default" or "__multiline",
        location = location,
      }
    end,
  })
end

return {
  'numToStr/Comment.nvim',
  keys = { 'gc', 'gb' },
  config = M.setup,
}
