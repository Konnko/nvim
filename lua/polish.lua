-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }
-- Shortcut to use blackhole register by default

map("v", "c", '"_c', options)
map("v", "C", '"_C', options)
map("n", "c", '"_c', options)
map("n", "C", '"_C', options)
map("v", "x", '"_x', options)
map("v", "X", '"_X', options)
map("n", "x", '"_x', options)
map("n", "X", '"_X', options)
