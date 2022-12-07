local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then return end

local actions = require'telescope.actions'
local action_set = require('telescope.actions.set')
local lga_actions = require("telescope-live-grep-args.actions")

telescope.load_extension('live_grep_args')

telescope.setup({
  defaults = {

    prompt_prefix = "> ",
    path_display = { "truncate" },
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = { ["q"] = actions.close },
    },

  },

  pickers = {
    find_files = {
      attach_mappings = function(prompt_buffer)
        action_set.select:enhance({
          post = function()
            vim.cmd(":normal! zx")
          end
        })
        return true
      end
    },
  },

  extensions = {
    file_browsers = {
      hijack_netrw = true,
      initial_mode = 'normal',
      mappings = {
        ["i"] = {

        },
        ["n"] = {

        },
      }
    },
  }
})

telescope.load_extension('tmux')
telescope.load_extension('frecency')
telescope.load_extension('file_browser')
