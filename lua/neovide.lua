if vim.g.neovide then
  vim.o.guifont = 'JetBrainsMono Nerd Font Mono:h18'
  -- vim.o.guifont = 'RobotoMono Nerd Font Mono:h18'
  -- vim.o.guifont = 'RobotoMono Nerd Font Mono:h18'
  -- vim.o.guifont = 'TX-02:h18'
  vim.g.neovide_fullscreen = true

  -- Paste in terminal mode (Cmd+V)
  vim.keymap.set('t', '<D-v>', function()
    local clipboard = vim.fn.getreg '+'
    local escaped = vim.api.nvim_replace_termcodes(clipboard, true, true, true)
    vim.api.nvim_feedkeys(escaped, 't', false)
  end, { desc = 'Paste in terminal' })

  -- Paste in normal/visual mode
  vim.keymap.set({ 'n', 'v' }, '<D-v>', '"+p', { desc = 'Paste' })
  -- Paste in insert mode
  vim.keymap.set('i', '<D-v>', '<C-r>+', { desc = 'Paste' })
  -- Paste in command-line mode (/ search, : commands)
  vim.keymap.set('c', '<D-v>', '<C-r>+', { desc = 'Paste' })

  -- Word navigation with Option+arrows in terminal
  vim.keymap.set('t', '<A-Left>', '<Esc>b', { desc = 'Word left' })
  vim.keymap.set('t', '<A-Right>', '<Esc>f', { desc = 'Word right' })

  -- Line navigation with Cmd+arrows in terminal
  vim.keymap.set('t', '<D-Left>', '<C-a>', { desc = 'Line start' })
  vim.keymap.set('t', '<D-Right>', '<C-e>', { desc = 'Line end' })
end
