return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'
      local themes = require 'telescope.themes'
      local builtin = require 'telescope.builtin'

      telescope.setup {
        defaults = {
          path_display = { 'truncate' },
          sorting_strategy = 'ascending',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.55,
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
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
            },
            n = { ['q'] = actions.close },
          },
        },
        extensions = {
          ['ui-select'] = {
            themes.get_dropdown(),
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      }

      local map = vim.keymap

      map.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      map.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      map.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      map.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      map.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      map.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      map.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      map.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      map.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      map.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      map.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      map.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      map.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
}