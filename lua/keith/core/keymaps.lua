local wk = require('which-key')


local keymap = vim.keymap -- for conciseness
local mapopts = {
  noremap = true,
  silent = true,
}

-- new file
keymap.set("n", "<leader>fn", "<cmd>enew<cr>")

-- format json
keymap.set("v", "<leader>js", ":!python -m json.tool<cr>", { desc = "Format [J]ava[S]cript" })

-- Scroll up.down but keep cursor centered
keymap.set("n", "<C-d>", "<C-d>zz", mapopts)
keymap.set("n", "<C-u>", "<C-u>zz", mapopts)

-- ??
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


-- NeoTree
keymap.set("n", "<leader>e", ":Neotree reveal=true position=float toggle<cr>", mapopts)
keymap.set("n", "<leader>nh", ":nohl<CR>", mapopts)


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

wk.register({
  f = {
    name = "Telescope",
    f = { function() require 'telescope.builtin'.find_files() end, "[F]ind [F]iles" },
    g = {
      function()
        require 'telescope'.extensions.live_grep_args.live_grep_args()
      end,
      "Search Live [G]rep",
    },
    r = {
      ":Telescope resume<cr>",
      "[R]esume last query",
    },
    c = {
      ":Telescope current_buffer_fuzzy_find<cr>",
      "[F]ind [C]urrent Buffer (Fuzzy Find)",
    }
  },
  g = {
    name = "Telescope Git",
    s = {
      function() require 'telescope.builtin'.git_status({ initial_mode = 'normal' }) end,
      "[G]it [S]tatus",
    },
    b = {
      function() require 'telescope.builtin'.git_branches({ initial_mode = 'normal' }) end,
      "[G]it [B]ranches",
    },
    c = {
      function() require 'telescope.builtin'.git_commits({ initial_mode = 'normal' }) end,
      "[G]it [C]ommits",
    }
  },
  s = {
    name = "Telescope Search",
    h = {
      function() require 'telescope.builtin'.help_tags() end,
      "[S]earch [H]elp",
    },
    d = {
      function()
        require('telescope.builtin').diagnostics({ initial_mode = 'normal' })
      end,
      "[S]how [d]iagnostics",
    },
    k = {
      function()
        require('telescope.builtin').keymaps({})
      end,
      "[S]how [k]eymaps",
    }
  },
}, {
  prefix = "<leader>",
  mode = "n",
})

wk.register({
  f = {
    g = {
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
      "Search Live Grep Under Cursor",
    },
    r = {
      function()
        require 'telescope.builtin'.resume()
      end,
      "List Buffers",
    },
  },
}, {
  prefix = "<leader>",
  mode = "v",
})

-- -- Tmux
keymap.set("n", "<leader>ts", ":Telescope tmux sessions initial_mode=normal<cr>", mapopts)
keymap.set("n", "<leader>tw", ":Telescope tmux windows initial_mode=normal<cr>", mapopts)

-- Smart Splits
keymap.set("n", "<C-h>", function() require 'smart-splits'.move_cursor_left() end, mapopts)
keymap.set("n", "<C-j>", function() require 'smart-splits'.move_cursor_down() end, mapopts)
keymap.set("n", "<C-k>", function() require 'smart-splits'.move_cursor_up() end, mapopts)
keymap.set("n", "<C-l>", function() require 'smart-splits'.move_cursor_right() end, mapopts)

keymap.set("n", "<C-\\>", ":vsplit", mapopts)
keymap.set("n", "<C-->>", ":split", mapopts)

keymap.set("n", "<C-Up>", function() require 'smart-splits'.resize_up() end, mapopts)
keymap.set("n", "<C-Down>", function() require 'smart-splits'.resize_down() end, mapopts)
keymap.set("n", "<C-Left>", function() require 'smart-splits'.resize_left() end, mapopts)
keymap.set("n", "<C-Right>", function() require 'smart-splits'.resize_right() end, mapopts)

-- -- Lsp Signature
keymap.set("i", "<C-t>", function() require 'lsp_signature'.toggle_float_win() end, mapopts)

-- -- Docker
keymap.set("n", "<leader>dt", ":DockerToolsToggle<cr>", mapopts)
wk.register({
  d = {
    name = "Docker",
    t = { ":DockerToolsToggle<cr>", "Toggle Docker Tools" },
  }
}, {
  prefix = "<leader>",
})

-- -- Fugitive
wk.register({
  g = {
    name = "Fugitive",
    g = { ":Gvdiffsplit!<cr>", "Vert Diff Split" },
    j = { ":diffget //3<cr>", "Take diff from right side" },
    f = { ":diffget //2<cr>", "Take diff from left side" },
  }
}, {
  prefix = "<leader>",
})

-- -- Lsp
wk.register({
  ["[d"] = {
    function()
      vim.diagnostic.goto_prev()
    end,
    "Go to prev diagnostic",
  },
  ["]d"] = {
    function()
      vim.diagnostic.goto_next()
    end,
    "Go to next diagnostic",
  },
})

-- -- Harpoon
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

wk.register({
  h = {
    name = "Harpoon",
    a = { function() require('harpoon'):list():append() end, "Append to List" },
    h = { function() toggle_telescope(require('harpoon'):list()) end, "Toggle Harpoon Marks UI" },
  }
}, {
  prefix = "<leader>",
})

-- -- Zen
wk.register({
  z = {
    name = "Zen",
    z = { ":ZenMode<cr>", "Toggle Zen Mode" },
  }
}, {
  prefix = "<leader>",
})


-- -- DAP
wk.register({
  d = {
    name = "Debug",
    b = { function() require 'dap'.toggle_breakpoint() end, "Toggle Breakpoint" },
    o = { function() require 'dap'.step_over() end, "Step Over" },
    i = { function() require 'dap'.step_into() end, "Step Into" },
    c = { function() require 'dap'.continue() end, "Continue" },
    h = { function() require('dap.ui.widgets').hover() end, "Hover" },
    t = { function() require('dap-go').debug_test() end, "Debug Test" },
    u = { function() require('dapui').toggle() end, "UI Toggle" },
  }
}, {
  prefix = "<leader>",
})

wk.register({
  ["<leader>"] = {
    name = "leader",
    n = {
      name = "Navbuddy",
      o = { ":Navbuddy<cr>", "Open Navbuddy" },
    },
  },
})

wk.register({
  n = {
    n = { ":NoNeckPain<cr>", "Toggle NoNeckPain" },
  },
}, {
  prefix = "<leader>",
})

wk.register({
    ["<C-K>"] = { function() require('luasnip').expand() end, "Snip: expand" },
    ["<C-L>"] = { function() require('luasnip').jump(1) end, "Snip: goto next" },
    ["<C-J>"] = { function() require('luasnip').jump(-1) end, "Snip: goto prev" },
    ["<C-E>"] = { function()
      local ls = require('luasnip')

      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, "Snip: change choice" },
  },
  {
    prefix = "<leader>",
    mode = "n",
  }
)
