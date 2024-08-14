require 'keith.core.options'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

require 'keith.core.theme'
require 'keith.core.keymaps'
require 'keith.custom.terminal'

-- after load
-- require 'cmp.cmp'.setup()
-- vim.cmd [[ highlight Normal guibg=colour236 ]]
--
--

vim.cmd [[
  set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
]]
