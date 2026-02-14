return {
  {
    'nvim-telescope/telescope-project.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}

        pickers = {},
        defaults = {
          layout_config = { horizontal = { preview_width = 0.5 } },
          mappings = {
            i = {
              ['<CR>'] = function(prompt_bufnr)
                local actions = require 'telescope.actions'
                local action_state = require 'telescope.actions.state'
                local picker = action_state.get_current_picker(prompt_bufnr)
                local multi_selections = picker:get_multi_selection()

                if #multi_selections > 1 then
                  actions.close(prompt_bufnr)
                  for _, entry in ipairs(multi_selections) do
                    if entry.path or entry.filename then
                      local file_path = entry.path or entry.filename
                      pcall(vim.cmd, 'ClaudeCodeAdd ' .. vim.fn.fnameescape(file_path))
                    end
                  end
                  pcall(vim.cmd, 'ClaudeCodeFocus')
                else
                  actions.select_default(prompt_bufnr)
                end
              end,
            },
            n = {
              ['<CR>'] = function(prompt_bufnr)
                local actions = require 'telescope.actions'
                local action_state = require 'telescope.actions.state'
                local picker = action_state.get_current_picker(prompt_bufnr)
                local multi_selections = picker:get_multi_selection()

                if #multi_selections > 1 then
                  actions.close(prompt_bufnr)
                  for _, entry in ipairs(multi_selections) do
                    if entry.path or entry.filename then
                      local file_path = entry.path or entry.filename
                      pcall(vim.cmd, 'ClaudeCodeAdd ' .. vim.fn.fnameescape(file_path))
                    end
                  end
                  pcall(vim.cmd, 'ClaudeCodeFocus')
                else
                  actions.select_default(prompt_bufnr)
                end
              end,
            },
          },
        },

        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          project = {
            hidden_files = true,
            on_project_selected = function(prompt_bufnr)
              -- Get the selected entry from the Telescope picker
              local action_state = require 'telescope.actions.state'
              local selection = action_state.get_selected_entry()

              -- First, change the directory to the selected project path
              vim.cmd.cd(selection.value)

              -- Then, open the file finder
              -- We use vim.schedule to make sure this runs after the
              -- project picker has fully closed.
              vim.schedule(function()
                require('telescope.builtin').find_files()
              end)
            end,
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'project')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Files' })
      vim.keymap.set('n', '<leader>fs', builtin.symbols, { desc = 'Symbols' })
      vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = 'Find Telescope builtin' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Current word' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'by Grep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader>fp', '<cmd>Telescope project<cr>', { desc = 'Find project' })
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })

      -- Set up Telescope-based LSP keymaps when an LSP attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf

          -- Find references for the word under your cursor.
          vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = 'Goto References' })

          -- Jump to the implementation of the word under your cursor.
          vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = 'Goto Implementation' })

          -- Jump to the definition of the word under your cursor.
          -- To jump back, press <C-t>.
          vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = 'Goto Definition' })

          -- Fuzzy find all the symbols in your current document.
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

          -- Fuzzy find all the symbols in your current workspace.
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

          -- Jump to the type of the word under your cursor.
          vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = 'Goto Type Definition' })
        end,
      })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Search in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search Neovim files' })
    end,
  },
}
