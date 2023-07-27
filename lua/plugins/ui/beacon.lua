
local Plugin = {'DanilaMihailov/beacon.nvim', event = "BufRead"}

function Plugin.config()
	vim.cmd([[highlight Beacon guibg=#ffffff ctermbg=15]])
	vim.g.beacon_size = 18
	vim.g.beacon_show_jumps = 0
	vim.g.beacon_minimal_jump = 0

	vim.keymap.set('n', '<leader>.', '<cmd>Beacon<cr>')
end
return Plugin
