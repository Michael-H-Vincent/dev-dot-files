
-- lua/options.lua
-- Basic Neovim settings with explanations

local opt = vim.opt  -- shorthand

-- ========== Tabs & Indentation ==========
opt.tabstop = 4        -- Number of spaces a <Tab> counts for (when reading a file)
opt.shiftwidth = 4     -- Number of spaces to use for each step of (auto)indent
opt.expandtab = true   -- Use spaces instead of actual <Tab> characters
opt.smartindent = true -- Smart auto-indenting when starting a new line
opt.autoindent = true  -- Copy indent from current line when starting a new one

-- ========== UI ==========
opt.number = true          -- Show line numbers
opt.relativenumber = true  -- Show relative line numbers (e.g. for easier movement with j/k)
opt.cursorline = true      -- Highlight the line the cursor is on
opt.signcolumn = "yes"     -- Always show the sign column (for git, diagnostics, etc.)
opt.wrap = false           -- Don't wrap long lines (scroll horizontally instead)
opt.scrolloff = 8          -- Keep 8 lines visible above/below cursor when scrolling
opt.sidescrolloff = 8      -- Keep 8 columns visible left/right when scrolling horizontally
opt.termguicolors = true   -- Enable 24-bit RGB colors in the terminal

-- ========== Search ==========
opt.ignorecase = true  -- Ignore case when searching (e.g. "foo" matches "Foo")
opt.smartcase = true   -- BUT: if search contains uppercase, respect case (e.g. "Foo" != "foo")
opt.hlsearch = true    -- Highlight search matches
opt.incsearch = true   -- Show matches as you type

-- ========== Behavior ==========
opt.mouse = "a"        -- Enable mouse support (all modes)
opt.clipboard = "unnamedplus" -- Use system clipboard for yank, delete, etc.
opt.swapfile = false   -- Don’t use swapfiles (disable backup files like .filename.swp)
opt.backup = false     -- Don’t create backup files
opt.undofile = true    -- Save undo history to an undo file
opt.updatetime = 300   -- Faster update time (affects CursorHold events, etc.)
opt.timeoutlen = 500   -- Time (ms) to wait for a mapped sequence to complete

-- ========== Splits ==========
opt.splitright = true  -- Vertical splits open to the right
opt.splitbelow = true  -- Horizontal splits open below

-- ========== Misc ==========
opt.hidden = true      -- Allow switching buffers without saving
opt.wrap = false       -- Don’t wrap long lines by default



vim.opt.autoread = true

vim.api.nvim_create_autocmd(
  { "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" },
  {
    pattern = "*",
    callback = function()
      if vim.fn.mode() ~= "c" then
        vim.cmd("checktime")
      end
    end,
  }
)

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  command = 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None',
})
