
return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()

      vim.o.pumheight = 10
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
  -- LSP support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",           -- installer
      "williamboman/mason-lspconfig.nvim", -- bridge mason <-> lspconfig
    },
    config = function()
      -- Mason setup
      require("mason").setup()
      local servers = { "lua_ls", "pyright", "clangd", "texlab" }
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = false,
      })
      -- Capabilities so LSP works with nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Function to run when LSP attaches to a buffer
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        -- Hover documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- Signature help (manual trigger)
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
      end

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end
      vim.lsp.enable(servers)
    end,
  },
}
