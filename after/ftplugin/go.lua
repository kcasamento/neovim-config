local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>gi", ":GoImports<CR>", { noremap = true, silent = true, desc = "[G]o[I]mport" })
keymap.set("n", "<leader>gs", ":GoFillStruct<CR>", { noremap = true, silent = true, desc = "[G]oFill[S]truct" })
