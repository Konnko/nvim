return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    -- build = ':TSUpdate',
    init = function()
      vim.opt.runtimepath:prepend(vim.fn.stdpath 'data' .. '/lazy/nvim-treesitter/runtime')

      local installing = {}
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          local ok, ts = pcall(require, 'nvim-treesitter')
          if not ok then return end
          local ts_config = require 'nvim-treesitter.config'

          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if not lang then return end

          local installed = ts_config.get_installed()
          if vim.list_contains(installed, lang) then
            if pcall(vim.treesitter.start, ev.buf) then vim.bo[ev.buf].syntax = 'off' end
            return
          end

          if installing[lang] then return end
          local available = ts_config.get_available()
          if not vim.list_contains(available, lang) then return end

          installing[lang] = true
          local task = ts.install(lang)
          task:await(function(err)
            installing[lang] = nil
            if err then return end
            vim.schedule(function()
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype ~= '' then
                  local buf_lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
                  if buf_lang == lang then
                    if pcall(vim.treesitter.start, buf) then vim.bo[buf].syntax = 'off' end
                  end
                end
              end
            end)
          end)
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },
}
