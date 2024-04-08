-- this will not enter the next qf buffer which I think I prefer
vim.keymap.set("n", "dd", "<cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')<CR>", {
  noremap = true,
  buffer = true,
  silent = true,
})
-- this will enter into the next item in the list in insert mode, which I currently do not like
-- vim.keymap.set("n", "dd", "<cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <bar> cc<CR>", {
--   noremap = true,
--   buffer = true,
--   silent = true,
-- })
