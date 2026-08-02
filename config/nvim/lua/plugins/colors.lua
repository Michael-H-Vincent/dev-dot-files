
return {
  -- Gruvbox
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin") -- default colorscheme
    end,
  },

  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    lazy = true,
    name = "tokyonight",
  },

  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = true,
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = true,
  },

}
