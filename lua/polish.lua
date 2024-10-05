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

local lspconfig = require "lspconfig"
local capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.tailwindcss.setup {
  capabilities = capabilities,
  filetypes = { "html", "elixir", "eelixir", "heex" },
  init_options = {
    userLanguages = {
      elixir = "html-eex",
      eelixir = "html-eex",
      heex = "html-eex",
    },
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'class[:]\\s*"([^"]*)"',
        },
      },
    },
  },
}

lspconfig.emmet_ls.setup {
  capabilities = capabilities,
  filetypes = { "html", "css", "elixir", "eelixir", "heex" },
}

local cmp = require "cmp"

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "path" }, { name = "cmdline" } },
})

vim.o.guifont = "RobotoMono Nerd Font Mono:h17"
