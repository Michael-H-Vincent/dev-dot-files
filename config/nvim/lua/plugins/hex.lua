-- lua/plugins/hex.lua
return {
    "RaafatTurki/hex.nvim",
    config = function()
        require("hex").setup({
            -- how many bytes per line to show
            dump_cmd = "xxd -g 1 -u",
            assemble_cmd = "xxd -r",
            -- whether to open in a new tab (false = same window)
            -- in_new_tab = false,
            -- enable pretty colors for the hex dump
            -- set to false if you want plain text
            -- highlight = true,
        })

        -- Optional: keymaps for toggling
        vim.keymap.set("n", "<leader>hx", function()
            require("hex").toggle()
        end, { desc = "Toggle hex view (hex.nvim)" })

        -- Optional: explicit commands (wrappers around the plugin)
        vim.api.nvim_create_user_command("HexOn", function()
            require("hex").open()
        end, { desc = "Open buffer in hex view" })

        vim.api.nvim_create_user_command("HexOff", function()
            require("hex").close()
        end, { desc = "Close hex view" })

        vim.api.nvim_create_user_command("HexToggle", function()
            require("hex").toggle()
        end, { desc = "Toggle hex view" })
    end,
}

