local wk = require('which-key')

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

keymap.set("n", "]q", "<cmd>cnext<cr>", mapopts)
keymap.set("n", "[q", "<cmd>cprev<cr>", mapopts)

-- LSP
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", mapopts)

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
    b = {
      function()
        require 'telescope.builtin'.buffers({ initial_mode = 'normal' })
      end,
      "List Buffers",
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
  g = {
    s = {
      function() require 'telescope.builtin'.git_status() end,
      "Git Status",
    },
    b = {
      function() require 'telescope.builtin'.git_branches() end,
      "Git Branches",
    },
    c = {
      function() require 'telescope.builtin'.git_commits() end,
      "Git Commits",
    }
  }
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

-- -- Frecency
keymap.set("n", "<leader><leader>",
  "<Cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD', initial_mode='normal' })<CR>", mapopts)

-- Smart Splits
keymap.set("n", "<C-h>", function() require 'smart-splits'.move_cursor_left() end, mapopts)
keymap.set("n", "<C-j>", function() require 'smart-splits'.move_cursor_down() end, mapopts)
keymap.set("n", "<C-k>", function() require 'smart-splits'.move_cursor_up() end, mapopts)
keymap.set("n", "<C-l>", function() require 'smart-splits'.move_cursor_right() end, mapopts)


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
  ["sd"] = {
    function()
      require('telescope.builtin').diagnostics({ initial_mode = 'normal' })
    end,
    "Show diagnostics",
  },

  g = {
    name = "LSP",
    d = {
      function()
        require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' })
      end,
      "Show definitions"
    },
    t = {
      function()
        vim.lsp.buf.type_defintion()
      end,
      "Show type definition",
    },
    i = {
      function()
        require 'telescope.builtin'.lsp_implementations({ initial_mode = 'normal' })
      end,
      "Show implementations"
    },
  }
})

-- -- Harpoon
wk.register({
  h = {
    name = "Harpoon",
    h = { ":Telescope harpoon marks initial_mode=normal<cr>", "Toggle Harpoon Marks UI" },
    m = { function() require('harpoon.mark').add_file() end, "Add Harpoon Mark" },
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
