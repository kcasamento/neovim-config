local wk = require('which-key')


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

keymap.set("n", "]q", "<cmd>cnext<cr>", mapopts)
keymap.set("n", "[q", "<cmd>cprev<cr>", mapopts)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Better Experience
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Word Wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- LSP
-- keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", mapopts)

-- Comment
keymap.set("n", "<leader>/", function() require 'Comment.api'.toggle.linewise.current() end, mapopts)
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
keymap.set("n", "<leader><Space>", function()
  require 'telescope.builtin'.buffers({ initial_mode = 'normal' })
end, { noremap = true, silent = true, desc = "List Buffers" })

wk.register({
  f = {
    name = "Telescope",
    f = { function() require 'telescope.builtin'.find_files() end, "Find Files" },
    g = {
      function()
        require 'telescope'.extensions.live_grep_args.live_grep_args()
      end,
      "Search Live Grep",
    },
    r = {
      ":Telescope resume<cr>",
      "Resume last query",
    },
    w = {
      ":Telescope current_buffer_fuzzy_find<cr>",
      "Current Buffer Fuzzy Find",
    }
  },
  -- g = {
  --   name = "Telescope Git",
  --   s = {
  --     function() require 'telescope.builtin'.git_status() end,
  --     "Git Status",
  --   },
  --   b = {
  --     function() require 'telescope.builtin'.git_branches() end,
  --     "Git Branches",
  --   },
  --   c = {
  --     function() require 'telescope.builtin'.git_commits() end,
  --     "Git Commits",
  --   }
  -- },
  s = {
    name = "Telescope Search",
    h = {
      function() require 'telescope.builtin'.help_tags() end,
      "Search Help",
    },
    d = {
      function()
        require('telescope.builtin').diagnostics({ initial_mode = 'normal' })
      end,
      "Show diagnostics",
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

  -- g = {
  --   name = "LSP",
  --   d = {
  --     function()
  --       require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' })
  --     end,
  --     "Show definitions"
  --   },
  --   t = {
  --     function()
  --       vim.lsp.buf.type_defintion()
  --     end,
  --     "Show type definition",
  --   },
  --   i = {
  --     function()
  --       require 'telescope.builtin'.lsp_implementations({ initial_mode = 'normal' })
  --     end,
  --     "Show implementations"
  --   },
  -- }
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
