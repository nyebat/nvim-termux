-- [[ COMMANDS ]]
local group = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight on yank',
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'help', 'man' },
	group = group,
	command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

-- disable nomor baris pada TermOpen
vim.api.nvim_create_autocmd('TermOpen', {
	pattern = '*',
	group = group,
	callback = function()
		vim.cmd('setlocal nonumber')
		vim.cmd('setlocal norelativenumber')
		vim.api.nvim_feedkeys('i', 'n', false)
	end,
})
-- COMPILE AND RUN
function CodeRunner()
	local source = vim.fn.expand('%')
	local temp = vim.fn.expand('%:r') -- get pathfile/filename (without ekstension)
	local typeFile = vim.fn.expand('%:e')
	local nameFile = vim.fn.expand('%:t:r')

	local M = {
		rs = {
			run = 'cd ' .. vim.fn.expand('%:h') .. ' && cargo run',
		},
		cpp = {
			compile = 'g++ ' .. source .. ' -o ' .. temp,
			run = ' && ' .. temp,
			delTemp = ' && rm -rf ' .. temp
		},
		java = {
			compile = 'javac ' .. source .. ' -d ' .. temp,
			run = ' && cd ' .. temp .. ' && java ' .. nameFile,
			delTemp = ' && cd $HOME && rm -rf ' .. temp,
		},
		kt = {
			compile = 'kotlinc ' .. source .. ' -include-runtime -d ' .. temp .. '.jar',
			run = ' && java -jar ' .. temp .. '.jar',
			delTemp = ' && rm -rf ' .. temp .. '.jar',
		},
	}

	local run = ''
	if M[typeFile] then
		if M[typeFile].compile then run = M[typeFile].compile end
		if M[typeFile].run then run = run .. M[typeFile].run end
		if M[typeFile].delTemp then run = run .. M[typeFile].delTemp end
	else
		print('\n[Err!] Buffer bukan file C++, Rust, Java, atau Kotlin!\n')
	 	return
	end

	if run ~= '' then
		-- save file
		vim.api.nvim_command(':w')
		-- compile, run, and delete binary temp
		vim.api.nvim_command('split term://' .. run)
	end
end

vim.api.nvim_command('command! -nargs=0 Cm lua CodeRunner()')
