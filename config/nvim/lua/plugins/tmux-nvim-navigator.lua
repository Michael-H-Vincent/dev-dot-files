return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.keymap.set('n', '<C-h>', ':<C-U>TmuxNavigateLeft<CR>')
    vim.keymap.set('n', '<C-j>', ':<C-U>TmuxNavigateDown<CR>')
    vim.keymap.set('n', '<C-k>', ':<C-U>TmuxNavigateUp<CR>')
    vim.keymap.set('n', '<C-l>', ':<C-U>TmuxNavigateRight<CR>')
  end,
}
