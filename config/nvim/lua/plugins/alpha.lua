return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local dashboard = require("alpha.themes.dashboard")
        -- Read only palette values; the rest of the editor keeps its own theme.
        local function themeColors()
            local path = vim.fn.expand("~/.local/state/omarchy/current/theme/colors.toml")
            local palette = {}
            if vim.fn.filereadable(path) == 1 then
                for _, line in ipairs(vim.fn.readfile(path)) do
                    local name, hex = line:match([=[^%s*([%w_]+)%s*=%s*["'](#%x%x%x%x%x%x)["']]=])
                    if name then palette[name] = hex end
                end
            end
            local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
            local fallback = normal.fg and string.format("#%06x", normal.fg) or "#ffffff"
            return {
                a = { fg = palette.bright_red or palette.red or fallback },
                b = { fg = palette.yellow or palette.accent or fallback },
                c = { fg = palette.blue or fallback },
                d = { fg = palette.magenta or fallback },
                e = { fg = palette.cyan or fallback },
            }, palette, fallback
        end

        local function refreshTheme()
            local colors, palette, fallback = themeColors()
            for name, color in pairs(colors) do
                vim.api.nvim_set_hl(0, "Alpha" .. name, color)
            end
            vim.api.nvim_set_hl(0, "AlphaButtons", { fg = palette.foreground or fallback })
            vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = palette.accent or fallback })
            vim.api.nvim_set_hl(0, "AlphaFooter", { fg = palette.muted or fallback })
        end

        -- helper function for utf8 chars
        local function getCharLen(s, pos)
            local byte = string.byte(s, pos)
            if not byte then
                return nil
            end
            return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
        end

        local function applyColors(logo, colors, logoColors)
            dashboard.section.header.val = logo

            for key, color in pairs(colors) do
                local name = "Alpha" .. key
                vim.api.nvim_set_hl(0, name, color)
                colors[key] = name
            end

            dashboard.section.header.opts.hl = {}
            for i, line in ipairs(logoColors) do
                local highlights = {}
                local pos = 0

                for j = 1, #line do
                    local opos = pos
                    pos = pos + getCharLen(logo[i], opos + 1)

                    local color_name = colors[line:sub(j, j)]
                    if color_name then
                        table.insert(highlights, { color_name, opos, pos })
                    end
                end

                table.insert(dashboard.section.header.opts.hl, highlights)
            end
            return dashboard.opts
        end

        require("alpha").setup(applyColors({
[[███╗   ███╗██╗   ██╗██╗███╗   ██╗]],
[[████╗ ████║██║   ██║██║████╗  ██║]],
[[██╔████╔██║██║   ██║██║██╔██╗ ██║]],
[[██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╗██║]],
[[██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚████║]],
[[╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝  ╚═══╝]],
[[           N E O V I M           ]],
        }, themeColors(), {

[[bbba   bbbabba   bbabbabbba   bba]],
[[bbbba bbbbabba   bbabbabbbba  bba]],
[[bbabbbbabbabba   bbabbabbabba bba]],
[[bbaabbaabbaabba bbaabbabbaabbabba]],
[[bba aaa bba abbbbaa bbabba abbbba]],
[[aaa     aaa  aaaaa  aaaaaa  aaaaa]],
[[           c c c d d d           ]],
            }))


        dashboard.section.buttons.val = {
            dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
            dashboard.button( "f", "󰱼  > Find file", ":lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files' } })<CR>"),
            dashboard.button( "F", "󰥨  > Find folder", ":lua search_and_scope_into_directory()<CR>"),
            dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
            dashboard.button( "c", "  > Config" , ":cd ~/.config/nvim | Telescope find_files<CR>"),
            dashboard.button( "l", "󰒲 > Lazy", ":Lazy<CR>"),
            dashboard.button( "h", "  > Settings" , ":cd ~/.config/hypr | Telescope find_files<CR>"),
            dashboard.button( "q", "  > Quit", ":qa<CR>"),


        }
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end
        dashboard.section.footer.opts.hl = "AlphaFooter"
        refreshTheme()
        vim.api.nvim_create_autocmd({ "FocusGained", "ColorScheme", "BufEnter" }, {
            group = vim.api.nvim_create_augroup("AlphaOmarchyTheme", { clear = true }),
            callback = refreshTheme,
        })

        dashboard.section.footer.val = {
            "",
            "Welcome!",
        }

    end,
}
