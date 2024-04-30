-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

return {
    {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
            mappings = {
                -- first key is the mode
                n = {
                    -- second key is the lefthand side of the map
                    -- mappings seen under group name "Buffer"
                    ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
                    ["<Leader>bD"] = {
                        function()
                            require("astroui.status").heirline.buffer_picker(function(bufnr)
                                require("astrocore.buffer").close(bufnr)
                            end)
                        end,
                        desc = "Pick to close",
                    },
                    -- tables with the `name` key will be registered with which-key if it's installed
                    -- this is useful for naming menus
                    ["<Leader>b"] = { name = "Buffers" },
                    ["<leader>fp"] = { "<cmd>Telescope projects<CR>", desc = "Search projects" },
                    -- quick save
                    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
                },
                t = {
                    -- setting a mapping to false will disable it
                    -- ["<esc>"] = false,
                },
            },
        },
    }
}
