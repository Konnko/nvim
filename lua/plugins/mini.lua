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

      -- Sessions
      require('mini.sessions').setup {
        autoread = false,
        autowrite = true,
      }

      -- Starter screen
      local starter = require 'mini.starter'
      starter.setup {
        items = {
          starter.sections.sessions(),
          starter.sections.recent_files(10, false),
          starter.sections.recent_files(10, true),
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
