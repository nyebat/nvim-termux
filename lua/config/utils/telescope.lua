-- local M = {}
-- M.setup = function()
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.setup {
	-- Basic Configuration
	defaults = {
		prompt_prefix = " > ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "normal",
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			width = 0.80,
			height = 0.55,
			prompt_position = "bottom",
			horizontal = {
				mirror = false,
				preview_width = 0.65,
			},
			vertical = {
				mirror = false,
				--preview_width = 0.2,
			},
		},
		file_ignore_patterns = { 'node_modules', '.git' }, -- Hapus '__pycache__' dari daftar
		generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
		path_display = { "shorten" },
		mappings = {
			i = {
				--["<esc>"] = actions.close,
				["<M-n>"] = require('telescope.actions').cycle_history_next,
				["<M-p>"] = require('telescope.actions').cycle_history_prev,
				["<M-j>"] = require('telescope.actions').move_selection_next,
				["<M-k>"] = require('telescope.actions').move_selection_previous,
			},
		},
		file_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
	},
	pickers = {
		find_files = {
			hidden = true, -- Aktifkan opsi untuk menampilkan file tersembunyi'rg',
		},
	},
	extensions = {
		extensions = {
			fzf = {
				fuzzy = true,        -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		}
	}
}

-- Key Mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

map('n', '<leader>ff', builtin.find_files, opts)
map('n', '<leader>fh', builtin.oldfiles, opts)
map('n', '<leader>fg', builtin.live_grep, opts)
map('n', '<leader>fb', builtin.buffers, opts)
map('n', '<leader>f?', builtin.help_tags, opts)
map('n', '<leader>ft', builtin.treesitter, opts)
map('n', '<leader>fc', builtin.commands, opts)
map('n', '<leader>fd', builtin.colorscheme, opts)
map('n', '<leader>fi', builtin.lsp_document_symbols, opts)
map('n', '<leader>fs', builtin.grep_string, opts)
map('n', '<leader>fk', builtin.keymaps, opts)

-- Enable fzy native extension
require('telescope').load_extension('fzf')
-- end

-- return M
