-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons' },
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
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'Konnko/rainbow-delimiters.nvim',
    submodules = false,
    main = 'rainbow-delimiters.setup',
    opts = {
      query = {
        [''] = 'rainbow-blocks',
      },
    },
    config = function(plugin, opts)
      -- The 'main' key usually handles the basic setup call.
      -- If 'main' wasn't actually calling setup, you might need to call it here:
      -- require("rainbow-delimiters.setup").setup(opts)
      -- However, with 'main' defined, this config function typically runs *after* it.

      local my_rainbow_colors = {
        '#FF6B6B', -- Bright Red/Coral
        '#FFA07A', -- Bright Orange (Light Salmon)
        '#F1FA8C', -- Bright Yellow (Dracula Yellow)
        '#50FA7B', -- Bright Green (Dracula Green)
        '#82AAFF', -- Bright Blue
        '#BD93F9', -- Bright Purple (Dracula Purple)
        '#8BE9FD', -- Bright Cyan (Dracula Cyan)
      }

      local rainbow_hl_groups = {
        'RainbowDelimiterRed',
        'RainbowDelimiterOrange',
        'RainbowDelimiterYellow',
        'RainbowDelimiterGreen',
        'RainbowDelimiterBlue',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      }

      -- Override the highlight groups with my colors
      -- for i, hex_color in ipairs(my_rainbow_colors) do
      --   if i <= #rainbow_hl_groups then
      --     vim.api.nvim_set_hl(0, rainbow_hl_groups[i], { fg = hex_color, bold = true })
      --     -- Example: vim.api.nvim_set_hl(0, rainbow_hl_groups[i], { fg = hex_color, bold = true })
      --   else
      --     print 'Info: Defined more custom colors than default rainbow highlight group names.'
      --     break
      --   end
      -- end
    end,
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
    config = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }
      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require('ibl').setup { scope = { highlight = highlight } }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>gl', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
