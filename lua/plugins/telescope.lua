return {
 "nvim-telescope/telescope.nvim",
 opts = function(_, opts)
  opts.pickers = {
   find_files = {
    find_command = { "rg", "--files", "--hidden" },
   },
  }
  return opts
 end,
}
