return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.g.mkdp_browser = "firefox"
    vim.g.mkdp_command_for_global = 1
    vim.g.mkdp_filetypes = { "markdown" }
  end,
}
