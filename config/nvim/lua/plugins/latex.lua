return {
  {
    "lervag/vimtex",
    lazy = false, -- load immediately for .tex files
    init = function()
      -- Viewer setup
      vim.g.vimtex_view_method = "zathura"

      -- Compiler setup
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }

      -- Disable auto opening of the quickfix window
      vim.g.vimtex_quickfix_mode = 0

      -- Optional: don't show compile messages inline
      vim.g.vimtex_log_ignore = {
        "Underfull",
        "Overfull",
        "specifier changed to",
      }

      -- Optional quality of life
      vim.g.vimtex_complete_close_braces = 1
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 1,
      }

      -- Use local `.latexmkrc` if present (nice for per-project builds)
      -- vim.g.vimtex_latexmk_enabled = 1
    end,
  },
}
