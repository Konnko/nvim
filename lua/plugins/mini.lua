return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --  - va)  - Visually select Around )paren
      --  - yinq - Yank Inside Next Quote
      --  - ci'  - Change Inside 'quote
      require('mini.ai').setup { n_lines = 500 }

      -- File explorer
      require('mini.files').setup {
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = '<Right>',
          go_out = '<Left>',
          go_out_plus = 'H',
          mark_goto = "'",
          mark_set = 'm',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },
      }

      -- Sessions (auto-save per directory, like AstroNvim)
      require('mini.sessions').setup {
        autoread = false,
        autowrite = false,
      }

      -- Auto-save a session named after the cwd on exit (git projects only)
      vim.api.nvim_create_autocmd('VimLeavePre', {
        callback = function()
          if vim.bo.filetype == 'ministarter' then return end
          if vim.fn.isdirectory(vim.fn.getcwd() .. '/.git') == 0 then return end
          local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
          MiniSessions.write(cwd, { force = true })
        end,
      })

      -- Starter screen
      local starter = require 'mini.starter'
      starter.setup {
        items = {
          starter.sections.sessions(5, true),
          starter.sections.builtin_actions(),
        },
        header = '',
        footer = '',
      }

      -- Surround (replaces nvim-surround)
      require('mini.surround').setup {
        mappings = {
          add = 'ra',
          delete = 'rd',
          find = 'rf',
          find_left = 'rF',
          highlight = 'rh',
          replace = 'rr',
          update_n_lines = 'rn',
        },
        custom_surroundings = {
          ['='] = {
            input = { '<%%=%s*().-()%s*%%>' },
            output = { left = '<%= ', right = ' %>' },
          },
          ['%%'] = {
            input = { '<%% ().-() %%>' },
            output = { left = '<% ', right = ' %>' },
          },
        },
      }

      -- Highlight patterns (replaces todo-comments.nvim)
      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          warn = { pattern = '%f[%w]()WARN()%f[%W]', group = 'MiniHipatternsHack' },
        },
      }
    end,
  },
}
