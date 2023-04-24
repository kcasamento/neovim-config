local M = {}

function M.setup()
  local status_ok, neotree = pcall(require, "neo-tree")
  if not status_ok then return end

  local get_icon = require 'keith.utils'.get_icon

  neotree.setup({
    close_if_last_window = true,
    enable_diagnostics = false,
    source_selector = {
      winbar = true,
      content_layout = "center",
      -- tab_labels = {
      --   filesystem = get_icon "FolderClosed" .. " File",
      --   buffers = get_icon "DefaultFile" .. " Bufs",
      --   git_status = get_icon "Git" .. " Git",
      --   diagnostics = get_icon "Diagnostic" .. " Diagnostic",
      -- },
    },
    default_component_configs = {
      indent = {
        padding = 0,
      },
      icon = {
        folder_closed = get_icon "FolderClosed",
        folder_open = get_icon "FolderOpen",
        folder_empty = get_icon "FolderEmpty",
        default = get_icon "DefaultFile",
      },
      git_status = {
        symbols = {
          added = get_icon "GitAdd",
          deleted = get_icon "GitDelete",
          modified = get_icon "GitChange",
          renamed = get_icon "GitRenamed",
          untracked = get_icon "GitUntracked",
          ignored = get_icon "GitIgnored",
          unstaged = get_icon "GitUnstaged",
          staged = get_icon "GitStaged",
          conflict = get_icon "GitConflict",
        },
      },
    },
    window = {
      width = 30,
      mappings = {
        ["o"] = "open",
      },
    },
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    event_handlers = {
      { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
    },
  })
end

return M
