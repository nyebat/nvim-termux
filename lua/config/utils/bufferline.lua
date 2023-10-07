-- local M = {}
-- M.setup = function()
local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end
bufferline.setup({
	options = {
		mode = 'buffers',
		offsets = {
			{ filetype = 'NvimTree' }
		},
		numbers = 'none',
		diagnostics = 'nvim_lsp',
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		seperator_style = 'slant' or 'padded_slant',
		show_tab_indicators = false,
		show_buffer_close_icons = false,
		show_close_icon = false,
	}
})

vim.keymap.set({ 'n', }, '<leader>bb', '<cmd>BufferLineCyclePrev<cr>')
vim.keymap.set({ 'n', }, '<leader>bn', '<cmd>BufferLineCycleNext<cr>')
vim.keymap.set({ 'n', }, '<leader>c', '<cmd>bd<cr>')
-- end
-- return M
