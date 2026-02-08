local map = vim.keymap.set
local blackholeOptions = { silent = true }
vim.opt.swapfile = false
-- Shortcut to use blackhole register by default

map('v', 'c', '"_c', blackholeOptions)
map('v', 'C', '"_C', blackholeOptions)
map('n', 'c', '"_c', blackholeOptions)
map('n', 'C', '"_C', blackholeOptions)
map('v', 'x', '"_x', blackholeOptions)
map('v', 'X', '"_X', blackholeOptions)
map('n', 'x', '"_x', blackholeOptions)
map('n', 'X', '"_X', blackholeOptions)

-- Open mini.files with current dir in focus
map('n', '<leader>o', function()
  local mf = require 'mini.files'
  mf.open(vim.api.nvim_buf_get_name(0), false)
  mf.reveal_cwd()
end, { desc = 'Files' })

map('n', '<leader>c', ':bd<CR>', { desc = '[C]lose buffer' })
map('n', '<leader>q', ':q<CR>', { desc = '[Q]uit buffer' })
map('n', '<leader>w', ':w<CR>', { desc = '[W]rite' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- TOGGLES
vim.keymap.set('n', '<leader>tf', '<cmd>FormatToggle<cr>', { desc = 'Toggle format on save' })
vim.keymap.set('n', '<leader>ta', '<cmd>AerialToggle<cr>', { desc = 'Toggle aerial' })

vim.keymap.set('n', '<leader>tt', ':ToggleTerm size=80 dir=git_dir direction=vertical<CR>', { desc = 'ToggleTerm' })

-- TERMINAL OVERRIDES
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }

  vim.keymap.set('t', ';;', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- QUICK SPLIT GD
vim.keymap.set('n', '|', '<C-w>vgd', { noremap = true, silent = true })
vim.keymap.set('n', '\\', '<C-w>sgd', { noremap = true, silent = true })

-- LSP
--
vim.keymap.set('n', 'E', function()
  vim.diagnostic.open_float(nil, { scope = 'line' })
end, { desc = 'See LSP output' })
