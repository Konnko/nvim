return {
  {
    'folke/snacks.nvim',
    opts = { input = {}, picker = {}, terminal = {} },
  },
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      'folke/snacks.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- add this
    },
    config = function()
      vim.g.opencode_opts = {}
      vim.o.autoread = true
      require('opencode').setup {
        preferred_picker = 'telescope', -- optional, auto-detects if nil
      }
    end,
    keys = {
      { '<leader>s', nil, desc = 'AI/OpenCode' },
      {
        '<leader>st',
        function()
          require('opencode').select()
        end,
        desc = 'Select OpenCode action',
      },
      {
        '<leader>sc',
        function()
          require('opencode').toggle()
        end,
        desc = 'Toggle OpenCode',
      },
      {
        '<leader>ss',
        function()
          require('opencode').ask('@this: ', { submit = true })
        end,
        mode = 'v',
        desc = 'Send to OpenCode',
      },
      {
        '<leader>sb',
        function()
          require('opencode').ask('@buffer ', { submit = false })
        end,
        desc = 'Add current buffer',
      },
      {
        '<leader>sa',
        function()
          require('opencode').select()
        end,
        desc = 'Action picker',
      },
      {
        '<leader>sm',
        function()
          require('opencode').command 'agent.cycle'
        end,
        desc = 'Cycle agent',
      },
      {
        '<leader>si',
        function()
          require('opencode').command 'session.interrupt'
        end,
        desc = 'Interrupt session',
      },
    },
  },
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = true,
    opts = {
      terminal = {
        split_width_percentage = 0.4,
      },
    },
    keys = {
      { '<leader>a', nil, desc = 'AI/Claude Code' },
      { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
      -- { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
      -- { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
      -- { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
      -- { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
      {
        '<leader>as',
        '<cmd>ClaudeCodeTreeAdd<cr>',
        desc = 'Add file',
        ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
      },
      -- Diff management
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },
}
