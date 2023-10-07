local M = {
	-- color schemes
	{ "folke/tokyonight.nvim", lazy = false, },
	{ "Mofiqul/dracula.nvim",  lazy = false, },

	{ -- cursor jump
		'DanilaMihailov/beacon.nvim',
		event = "BufRead",
		config = function()
			vim.cmd([[highlight Beacon guibg=white ctermbg=15]])
			vim.g.beacon_size = 18
			vim.g.beacon_show_jumps = 0
			vim.g.beacon_minimal_jump = 0

			vim.keymap.set('n', '<leader>.', '<cmd>Beacon<cr>')
		end
	},

	{ -- indent
		-- 'lukas-reineke/indent-blankline.nvim',
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		dependencies = {
			"echasnovski/mini.indentscope",
			version = false, -- wait till new 0.7.0 release to put it back on semver
			event = { "BufReadPre", "BufNewFile" },
		}
	},

	{ -- lua line
		'nvim-lualine/lualine.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
	},

	{ -- barbeque
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
	},

	{ -- color palet
		'norcalli/nvim-colorizer.lua',
		config = function()
			require 'colorizer'.setup()
		end
	},
}

return M
