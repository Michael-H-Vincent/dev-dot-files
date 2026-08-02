
return {
  "OXY2DEV/markview.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- ensure Treesitter loads first
  config = function()
    require("markview").setup({
      experimental = {
        check_rtp_message = false,  -- <- disables the runtime path warning message
      },
    })
  end,
}
