return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	config = function()
		require("nvim-treesitter").setup()

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
