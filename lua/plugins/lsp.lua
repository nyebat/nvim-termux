local M = {
	-- nvim-lsp
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- mason
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- completion
			{ "hrsh7th/cmp-nvim-lsp" },
			-- linters
			{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
		},
	},

	{
		"simrat39/rust-tools.nvim",
		-- lazy = true,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'mfussenegger/nvim-dap'
		}
	},

	-- cmp
	{
		"hrsh7th/cmp-nvim-lsp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/nvim-cmp" },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-nvim-lua' },
		}
	},

	-- snippets
	{
		'saadparwaiz1/cmp_luasnip',
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				'L3MON4D3/LuaSnip',
				lazy = true,
				dependencies = { 'VonHeikemen/the-good-snippets' },
			}
		}
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VimEnter",
		dependencies = {
			{ 'JoosepAlviste/nvim-ts-context-commentstring' },
		},
		config = function()
			pcall(vim.cmd, 'TSUpdate')
		end,
		-- opts = { highlight = { enable = false } },
	},
}

return M
