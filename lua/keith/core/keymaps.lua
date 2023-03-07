-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local mapopts = {
  noremap = true,
  silent = true,
}

-- Standard
keymap.set("n", "<leader>fn", "<cmd>enew<cr>")
keymap.set("v", "<leader>js", ":!python -m json.tool<cr>")
keymap.set("n", "<C-d>", "<C-d>zz", mapopts)
keymap.set("n", "<C-u>", "<C-u>zz", mapopts)
keymap.set("n", "n", "nzzzv", mapopts)
keymap.set("n", "N", "Nzzzv", mapopts)

-- Comment
keymap.set("n", "<leader>/", function() require'Comment.api'.toggle.linewise.current() end, mapopts)
keymap.set("v", "<leader>/", "<esc><cmd>lua require'Comment.api'.toggle.linewise(vim.fn.visualmode())<cr>", mapopts)

-- Bufdelete
keymap.set("n", "<leader>c", "<cmd>Bdelete<cr>", mapopts)

-- Navigate buffers
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", mapopts)
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", mapopts)


-- NeoTree
keymap.set("n", "<leader>e", ":Neotree toggle<cr>", mapopts)
keymap.set("n", "<leader>nh", ":nohl<CR>", mapopts)


-- Telescope
keymap.set("n", "<leader>ff",
  function()
    require'telescope.builtin'.find_files()
  end,
  mapopts
)
keymap.set("n", "<leader>fg",
  function()
    require'telescope'.extensions.live_grep_args.live_grep_args()
  end,
  mapopts
)

keymap.set("v", "<leader>fg",
  function()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    local t = ''
    if #text > 0 then
      t = text
    end
    require'telescope'.extensions.live_grep_args.live_grep_args({default_text=t})
  end,
  mapopts
)

keymap.set("n", "<leader>fw", ":Telescope current_buffer_fuzzy_find<cr>", mapopts)

keymap.set("n", "<leader>fb", function() require'telescope.builtin'.buffers() end, mapopts)
keymap.set("n", "<leader>gs", function() require'telescope.builtin'.git_status() end, mapopts)
keymap.set("n", "<leader>gb", function() require'telescope.builtin'.git_branches() end, mapopts)
keymap.set("n", "<leader>gc", function() require'telescope.builtin'.git_commits() end, mapopts)

-- -- Tmux
keymap.set("n", "<leader>ts", ":Telescope tmux sessions initial_mode=normal<cr>", mapopts)
keymap.set("n", "<leader>tw", ":Telescope tmux windows initial_mode=normal<cr>", mapopts)

-- -- Frecency
keymap.set("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD', initial_mode='normal' })<CR>", mapopts)


keymap.set("n", "<leader>fe", ":Telescope file_browser initial_mode=normal<cr>", mapopts)

-- Smart Splits
keymap.set("n", "<C-h>", function() require'smart-splits'.move_cursor_left() end, mapopts)
keymap.set("n", "<C-j>", function() require'smart-splits'.move_cursor_down() end, mapopts)
keymap.set("n", "<C-k>", function() require'smart-splits'.move_cursor_up() end, mapopts)
keymap.set("n", "<C-l>", function() require'smart-splits'.move_cursor_right() end, mapopts)


keymap.set("n", "<C-Up>", function() require'smart-splits'.resize_up() end, mapopts)
keymap.set("n", "<C-Down>", function() require'smart-splits'.resize_down() end, mapopts)
keymap.set("n", "<C-Left>", function() require'smart-splits'.resize_left() end, mapopts)
keymap.set("n", "<C-Right>", function() require'smart-splits'.resize_right() end, mapopts)

-- -- Lsp Signature
keymap.set("i", "<C-t>", function() require'lsp_signature'.toggle_float_win() end, mapopts)

-- -- Docker
keymap.set("n", "<leader>dt", ":DockerToolsToggle<cr>", mapopts)
