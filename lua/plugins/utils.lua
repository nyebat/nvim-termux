return {
	-- alpha dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
	},

	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = { { '<leader>e', '<cmd>NvimTreeToggle<cr>' }, },
		config = function()
			require("config.utils.nvim-tree").setup()
		end
	},

	-- telescope
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
	},

	-- nvim surround
	--[[  Old text                    Command         New text
	  --------------------------------------------------------------------------------
		  surr*ound_words             ysiw)           (surround_words)
		  *make strings               ys$"            "make strings"
		  [delete ar*ound me!]        ds]             delete around me!
		  remove <b>HTML t*ags</b>    dst             remove HTML tags
		  'change quot*es'            cs'"            "change quotes"
		  <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
		  delete(functi*on calls)     dsf             function calls
	--]]
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "BufReadPre",
		config = function()
			require("nvim-surround").setup({})
		end
	},

	-- Comment/Uncomment
	{
		'numToStr/Comment.nvim',
		event = "BufRead",
		config = function()
			require('Comment').setup()
		end
	},

	-- bufferline
	{
		'akinsho/bufferline.nvim',
		event = "BufRead",
		dependencies = {
			{ 'nvim-tree/nvim-web-devicons' }
		},
	},

	-- toggle term
	{
		"akinsho/toggleterm.nvim",
		branch = "main",
	},

	-- auto pairs
	{ 'jiangmiao/auto-pairs' }

}
