local M = {}

function M.initialize_icons()
  M.icons = require "keith.core.icons.nerd_font"
  M.text_icons = require "keith.core.icons.text"
end

function M.get_icon(kind)
  local icon_pack = vim.g.icons_enabled and "icons" or "text_icons"
  if not M[icon_pack] then M.initialize_icons() end
  return M[icon_pack] and M[icon_pack][kind] or ""
end


return M;
