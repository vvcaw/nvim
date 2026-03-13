return {
  'nvim-tree/nvim-tree.lua',
  keys = {
    {
      '<leader>;',
      mode = { 'n' },
      function()
        local nvim_tree_api = require 'nvim-tree.api'
        nvim_tree_api.tree.open()

        while true do
          local results = require('flash').jump { search = { multi_window = false }, labels = 'asdfghjklqwertyuiopzxcvbnm', label = { uppercase = false } }

          if next(results.results) == nil then goto continue end

          local node = nvim_tree_api.tree.get_node_under_cursor()

          nvim_tree_api.node.open.edit(node)

          if node.type == 'file' then break end
          ::continue::
        end
      end,
    },
    {
      '<leader>:',
      mode = { 'n' },
      function() require('nvim-tree.api').tree.toggle() end,
    },
  },
  config = function()
    -- Setup nvim tree
    require('nvim-tree').setup {
      filters = {
        dotfiles = true,
        custom = { 'node_modules', '\\.cache', '.git', 'dist' },
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      log = {
        enable = true,
        truncate = true,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          diagnostics = true,
          git = false,
          profile = false,
          watcher = true,
        },
      },
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local w_h = math.floor(screen_w / 2)
            local s_h = screen_h - 4
            local center_x = (screen_w - w_h) / 2
            local center_y = ((vim.opt.lines:get() - s_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = math.floor(screen_w / 2),
              height = s_h,
            }
          end,
        },
        width = function() return math.floor(vim.opt.columns:get() * 5) end,
      },

      diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = false,
        debounce_delay = 500,

        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = 'H',
          info = 'I',
          warning = 'W',
          error = 'E',
        },
      },
      git = {
        enable = true,
        ignore = true,
      },
      filesystem_watchers = {
        enable = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
        remove_file = {
          close_window = true,
        },
        change_dir = {
          enable = true,
          global = true,
          restrict_above_cwd = false,
        },
      },
      renderer = {
        root_folder_label = true,
        highlight_git = true,
        highlight_opened_files = 'none',
        special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md', 'LICENSE', 'Dockerfile' },

        indent_markers = {
          enable = true,
          icons = {
            corner = '└',
            edge = '│',
            none = '',
          },
        },

        icons = {
          git_placement = 'after',
          modified_placement = 'after',
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = true,
          },

          glyphs = {
            default = '',
            symlink = '',
            folder = {
              default = '/',
              empty = '/',
              empty_open = '/',
              open = '/',
              symlink = '/',
              symlink_open = '/',
            },
            git = {
              unstaged = '[U]',
              staged = '[S]',
              unmerged = '[ ]',
              renamed = '[R]',
              untracked = '[?]',
              deleted = '[D]',
              ignored = '[I]',
            },
          },
        },
      },
    }
  end,
  dependencies = { 'folke/flash.nvim' },
}
