
-- init.lua
-- Minimal starter config for Neovim using Lazy.nvim

-- Set <space> as the leader key
-- NOTE: Must happen before lazy is required (otherwise wrong mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- import all plugin specs from lua/plugins/
  },
  defaults = {
    lazy = false, -- plugins are lazy-loaded by default
    version = false, -- always use latest git commit
  },
  install = { colorscheme = { "habamax" } }, -- fallback colorscheme
  checker = { enabled = true, notify = false }, -- auto check for plugin updates
})


-- Load your options and keymaps (you can add these files later)
pcall(require, "options")
pcall(require, "keymaps")
