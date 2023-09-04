local M = {
	-- mason
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- nvim-lsp
	{ "neovim/nvim-lspconfig" },

	-- cmp 
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-nvim-lua' },

	-- snippets
	{ 'saadparwaiz1/cmp_luasnip' },
	{'L3MON4D3/LuaSnip',
		lazy = true,
		dependencies = {'VonHeikemen/the-good-snippets'},
	},

	-- linters
	{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters

	-- treesitter
	{"nvim-treesitter/nvim-treesitter",
		event = "VimEnter",
		dependencies = {
			{ 'JoosepAlviste/nvim-ts-context-commentstring' },
		},
		opts = function()
			pcall(vim.cmd, 'TSUpdate')
		end
	},
}

return M
