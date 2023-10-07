-- [[ KEYMAPS ]]


-- Space as leader key
vim.g.mapleader = ' '


local map = vim.keymap.set
-- local opts = {noremap = true, silent = true}


-- Shortcuts
-- go to homeline
map({ 'n', 'x', 'o' }, '<leader>h', '^')
-- goto endline
map({ 'n', 'x', 'o' }, '<leader>l', 'g_')
--~ -- seleck all text
map('n', '<leader>a', ':keepjumps normal! ggVG<cr>')
map('n', '<leader>t', 'ggVG=<cr>')

--=== NEOVIM ===--

-- nohlsearch
map('n', '<leader>uh', '<cmd>nohlsearch<cr>')

-- Basic clipboard interaction
map({ 'n', 'x' }, 'cp', '"+y')
map({ 'n', 'x' }, 'cv', '"+p')

-- Delete text
map({ 'n', 'x' }, 'x', '"_x')

-- Reload config
map('n', '<leader>S', '<cmd>luafile %<cr>')

-- Buffer
map('n', '<leader>w', '<cmd>write<cr>')
map('n', '<leader>q', '<cmd>quit<cr>')

-- Close Buffer
map('n', '<leader>x', '<cmd>BuffRun<cr>')

--=== PLUGIN ===--

-- NvimTreeToggle
