return {
  "catgoose/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      filetypes = { "*" },
    })
  end,
}
