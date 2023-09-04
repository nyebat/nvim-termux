

vim.cmd([[highlight Beacon guibg=#ffffff ctermbg=15]])
vim.cmd([[let g:beacon_show_jumps = 0]])
vim.cmd([[let g:beacon_size = 18]])
vim.cmd([[let g:beacon_minimal_jump = 0]])
-- vim.g.beacon_size = 18
-- vim.g.beacon_show_jumps = 0
-- vim.g.beacon_minimal_jump = 0

vim.keymap.set('n', '<leader>.', '<cmd>Beacon<cr>')