return {
  {
    "Konnko/rainbow-delimiters.nvim",
    submodules = false,
    event = "User AstroFile",
    main = "rainbow-delimiters.setup",
    opts = {
      condition = function(bufnr)
        local buf_utils = require "astrocore.buffer"
        return buf_utils.is_valid(bufnr) and not buf_utils.is_large(bufnr)
      end,
      query = {
        [""] = "rainbow-blocks",
      },
    },
    config = function(plugin, opts)
      -- The 'main' key usually handles the basic setup call.
      -- If 'main' wasn't actually calling setup, you might need to call it here:
      -- require("rainbow-delimiters.setup").setup(opts)
      -- However, with 'main' defined, this config function typically runs *after* it.

      local my_rainbow_colors = {
        "#FF6B6B", -- Bright Red/Coral
        "#FFA07A", -- Bright Orange (Light Salmon)
        "#F1FA8C", -- Bright Yellow (Dracula Yellow)
        "#50FA7B", -- Bright Green (Dracula Green)
        "#82AAFF", -- Bright Blue
        "#BD93F9", -- Bright Purple (Dracula Purple)
        "#8BE9FD", -- Bright Cyan (Dracula Cyan)
      }

      local rainbow_hl_groups = {
        "RainbowDelimiterRed",
        "RainbowDelimiterOrange",
        "RainbowDelimiterYellow",
        "RainbowDelimiterGreen",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      }

      -- Override the highlight groups with my colors
      for i, hex_color in ipairs(my_rainbow_colors) do
        if i <= #rainbow_hl_groups then
          vim.api.nvim_set_hl(0, rainbow_hl_groups[i], { fg = hex_color, bold = true })
          -- Example: vim.api.nvim_set_hl(0, rainbow_hl_groups[i], { fg = hex_color, bold = true })
        else
          print "Info: Defined more custom colors than default rainbow highlight group names."
          break
        end
      end
    end,
  },
}
