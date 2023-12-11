local M = {}

function M.setup()
  local status_ok, harpoon = pcall(require, "harpoon")
  if not status_ok then return end

  harpoon.setup({})
end

return {
  "ThePrimeagen/harpoon",
  config = M.setup,
}
