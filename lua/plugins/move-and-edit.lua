return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
  },

  {
    'chrisgrieser/nvim-spider',
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'x' }, desc = 'Next word' },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'x' }, desc = 'Next end of word' },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'x' }, desc = 'Previous word' },
      { 'ge', "<cmd>lua require('spider').motion('ge')<CR>", mode = { 'n', 'x' }, desc = 'Previous end of word' },
    },
    opts = {},
  },

  {
    'stevearc/aerial.nvim',
    opts = {},
    config = function()
      require('aerial').setup {
        on_attach = function(bufnr)
          vim.keymap.set('n', '(', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', ')', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
      }
    end,
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },

  {
    'sustech-data/wildfire.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },

  
}
