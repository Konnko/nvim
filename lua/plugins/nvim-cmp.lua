return {
  { "onsails/lspkind.nvim", version = "*" },
  { -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    dependencies = {
      "luckasRanarison/tailwind-tools.nvim",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      -- ...
    },
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      -- modify the sources part of the options table
      opts.formatting = {
        format = require("lspkind").cmp_format {
          before = require("tailwind-tools.cmp").lspkind_format,
        },
      }
      opts.mapping["<Tab>"] = nil
    end,
  },
}
