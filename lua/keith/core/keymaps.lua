local wk = require('which-key')


local keymap = vim.keymap -- for conciseness
local mapopts = {
  noremap = true,
  silent = true,
}

-- new file
-- keymap.set("n", "<leader>fn", "<cmd>enew<cr>")

-- search notes
-- format json
keymap.set("v", "<leader>js", ":!python -m json.tool<cr>", { desc = "Format [J]ava[S]cript" })

-- Scroll up.down but keep cursor centered
keymap.set("n", "<C-d>", "<C-d>zz", mapopts)
keymap.set("n", "<C-u>", "<C-u>zz", mapopts)

-- always centers search results
keymap.set("n", "n", "nzzzv", mapopts)
keymap.set("n", "N", "Nzzzv", mapopts)

-- navigate quickfix list
keymap.set("n", "]q", "<cmd>cnext<cr>", mapopts)
keymap.set("n", "[q", "<cmd>cprev<cr>", mapopts)

-- move line up/down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Better Experience
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Word Wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Comment
keymap.set("n", "<leader>/", function() require 'Comment.api'.toggle.linewise.current() end, mapopts)
keymap.set("v", "<leader>/", "<esc><cmd>lua require'Comment.api'.toggle.linewise(vim.fn.visualmode())<cr>", mapopts)

-- Bufdelete
keymap.set("n", "<leader>c", "<cmd>Bdelete<cr>", mapopts)


keymap.set("n", "<leader>nh", ":nohl<CR>", mapopts)

-- Oil
keymap.set("n", "<leader>e", ":Oil<cr>", mapopts)

-- Telescope
keymap.set("n", "<leader><Space>", function()
  require 'telescope.builtin'.buffers({ initial_mode = 'normal' })
end, { noremap = true, silent = true, desc = "List Buffers" })

keymap.set(
  { "n", "x" },
  "<leader>rr",
  function() require('telescope').extensions.refactoring.refactors() end,
  {
    desc = "Refactor"
  }
)

wk.add({
  { "<leader>f",  group = "file" }, -- group
  { "<leader>ff", function() require 'telescope.builtin'.find_files() end,                       desc = "[F]ind [F]iles" },
  { "<leader>fg", function() require 'telescope'.extensions.live_grep_args.live_grep_args() end, desc = "Search [F]iles with Live [G]rep" },
  { "<leader>fr", ":Telescope resume<cr>",                                                       desc = "[R]esume last query" },
  { "<leader>fc", function() require 'telescope.builtin'.current_buffer_fuzzy_find() end,        desc = "[F]ind [C]urrent Buffer (Fuzzy Find)" },
  {
    "<leader>fn",
    ":ObsidianSearch<cr>",
    desc = "[F]ind [N]otes in the Obsidian vault"
  },
  {
    "<leader>fg",
    function()
      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg('v')
      vim.fn.setreg('v', {})

      text = string.gsub(text, "\n", "")
      local t = ''
      if #text > 0 then
        t = text
      end
      require 'telescope'.extensions.live_grep_args.live_grep_args({ default_text = t })
    end,
    mode = "v",
    desc = "Search Live [G]rep Under Cursor"
  }
})
wk.add({
  { "<leader>g",  group = "git" }, -- group
  { "<leader>gs", function() require 'telescope.builtin'.git_status({ initial_mode = 'normal' }) end,   desc = "[G]it [S]tatus" },
  { "<leader>gb", function() require 'telescope.builtin'.git_branches({ initial_mode = 'normal' }) end, desc = "[G]it [B]ranches" },
  { "<leader>gc", function() require 'telescope.builtin'.git_commits({ initial_mode = 'normal' }) end,  desc = "[G]it [C]ommits" },
})
wk.add({
  { "<leader>s",  group = "help" }, -- group
  { "<leader>sh", function() require 'telescope.builtin'.help_tags() end,                              desc = "[S]earch [H]elp" },
  { "<leader>sd", function() require 'telescope.builtin'.diagnostics({ initial_mode = 'normal' }) end, desc = "[S]how [D]iagnostics" },
  { "<leader>sk", function() require 'telescope.builtin'.keymaps({}) end,                              desc = "[S]how [K]eymaps" },
})

wk.add({
  { "<leader>fz", function() require('telescope').extensions.chezmoi.find_files() end, desc = "[F]ind Che[z]moi files" },
})

-- Tmux
keymap.set("n", "<leader>ts", ":Telescope tmux sessions initial_mode=normal<cr>", mapopts)
keymap.set("n", "<leader>tw", ":Telescope tmux windows initial_mode=normal<cr>", mapopts)

-- Smart Splits
keymap.set("n", "<C-h>", function() require 'smart-splits'.move_cursor_left() end, mapopts)
keymap.set("n", "<C-j>", function() require 'smart-splits'.move_cursor_down() end, mapopts)
keymap.set("n", "<C-k>", function() require 'smart-splits'.move_cursor_up() end, mapopts)
keymap.set("n", "<C-l>", function() require 'smart-splits'.move_cursor_right() end, mapopts)

keymap.set("n", "<C-\\>", ":vsplit<cr>", mapopts)
keymap.set("n", "<C-c>", ":close<cr>", mapopts)
-- keymap.set("n", "<C- >", ":vertical resize 1<cr>", mapopts)
-- keymap.set("n", "<C- >", ":vertical resize 2<cr>", mapopts)

keymap.set("n", "<C-Up>", function() require 'smart-splits'.resize_up() end, mapopts)
keymap.set("n", "<C-Down>", function() require 'smart-splits'.resize_down() end, mapopts)
keymap.set("n", "<C-Left>", function() require 'smart-splits'.resize_left() end, mapopts)
keymap.set("n", "<C-Right>", function() require 'smart-splits'.resize_right() end, mapopts)

-- Lsp Signature
-- keymap.set("i", "<C-t>", function() require 'lsp_signature'.toggle_float_win() end, mapopts)

-- -- -- Docker
-- keymap.set("n", "<leader>dt", ":DockerToolsToggle<cr>", mapopts)

-- Fugitive
wk.add({
  { "<leader>g",  group = "Fugitive [G]it" },
  { "<leader>gg", ":Gvdiffsplit!<cr>",     desc = "Vert Diff Split" },
  { "<leader>gj", ":diffget //3<cr>",      desc = "Take diff from right side" },
  { "<leader>gf", ":diffget //2<cr>",      desc = "Take diff from left side" },
})

-- Lsp
wk.add({
  {
    "[d",
    function()
      vim.diagnostic.goto_prev()
    end,
    desc = "Go to prev diagnostic",
  },
  {
    "]d",
    function()
      vim.diagnostic.goto_next()
    end,
    desc = "Go to next diagnostic",
  }
})

-- Harpoon
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    initial_mode = "normal",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

wk.add({
  { "<leader>h",  group = "Harpoon" },
  { "<leader>ha", function() require('harpoon'):list():add() end,                                    desc = "[H]arpoon [A]dd to List" },
  { "<leader>ht", function() toggle_telescope(require('harpoon'):list()) end,                        desc = "[H]arpoon [T]oggle Marks UI (Telescope)" },
  { "<leader>hh", function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = "[H]arpoon Toggle Marks UI" },
})

-- Zen
wk.add({
  { "<leader>zz", ":ZenMode<cr>", desc = "Toggle Zen" },
})

-- DAP
wk.add({
  { "<leader>d",  group = "Debug" },
  { "<leader>db", function() require 'dap'.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  { "<leader>do", function() require 'dap'.step_over() end,         desc = "Step Over" },
  { "<leader>di", function() require 'dap'.step_into() end,         desc = "Step Into" },
  { "<leader>dc", function() require 'dap'.continue() end,          desc = "Continue" },
  { "<leader>dh", function() require('dap.ui.widgets').hover() end, desc = "Hover" },
  { "<leader>dt", function() require('dap-go').debug_test() end,    desc = "Debug Test" },
  { "<leader>du", function() require('dapui').toggle() end,         desc = "UI Toggle" },
})

wk.add({
  { "<leader>nb", ":Navbuddy<cr>", desc = "Open [N]av[b]uddy" },
})

wk.add({
  { "<leader>nn", ":NoNeckPain<cr>", desc = "Toggle [N]o[N]eckPain" },
})


--
-- wk.add({
--     ["<C-K>"] = { function() require('luasnip').expand() end, "Snip: expand" },
--     ["<C-L>"] = { function() require('luasnip').jump(1) end, "Snip: goto next" },
--     ["<C-J>"] = { function() require('luasnip').jump(-1) end, "Snip: goto prev" },
--     ["<C-E>"] = { function()
--       local ls = require('luasnip')
--
--       if ls.choice_active() then
--         ls.change_choice(1)
--       end
--     end, "Snip: change choice" },
--   },
--   {
--     prefix = "<leader>",
--     mode = "n",
--   }
-- )
--
-- Split-Join
-- gS -> one line to many
-- gJ -> many lines to one
