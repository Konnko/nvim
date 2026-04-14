-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Shared rainbow colors used by both rainbow-delimiters and indent-blankline
local rainbow_colors = {
  { hl = 'RainbowDelimiterRed', fg = '#BD93F9' }, -- Purple
  { hl = 'RainbowDelimiterOrange', fg = '#FFA07A' }, -- Orange
  { hl = 'RainbowDelimiterYellow', fg = '#F1FA8C' }, -- Yellow
  { hl = 'RainbowDelimiterGreen', fg = '#50FA7B' }, -- Green
  { hl = 'RainbowDelimiterBlue', fg = '#FF6B6B' }, -- Red/Coral
  { hl = 'RainbowDelimiterViolet', fg = '#FF79C6' }, -- Pink
  { hl = 'RainbowDelimiterCyan', fg = '#A6E22E' }, -- Cyan
}

local rainbow_hl_groups = vim.tbl_map(function(c)
  return c.hl
end, rainbow_colors)

local function apply_rainbow_hl()
  for _, c in ipairs(rainbow_colors) do
    vim.api.nvim_set_hl(0, c.hl, { fg = c.fg })
  end
end

return {
  -- { 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons', opts = {} },
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
    },
  },
  {
    'Konnko/rainbow-delimiters.nvim',
    submodules = false,
    main = 'rainbow-delimiters.setup',
    opts = {
      query = {
        elixir = 'rainbow-blocks',
        lua = 'rainbow-blocks',
      },
    },
    config = function(_, opts)
      require('rainbow-delimiters.setup').setup(opts)
      vim.api.nvim_create_autocmd('ColorScheme', { callback = apply_rainbow_hl })
      vim.defer_fn(apply_rainbow_hl, 0)
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      local hooks = require 'ibl.hooks'
      hooks.register(hooks.type.HIGHLIGHT_SETUP, apply_rainbow_hl)
      require('ibl').setup { scope = { highlight = rainbow_hl_groups } }
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
