-- [[ COMMANDS ]]
local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight on yank',
	group = group,
	callback = function()
		vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {'help', 'man'},
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

-- Code Runner
function CodeRunner()
	local source = vim.fn.expand('%') --get path lengkap
	local temp = vim.fn.expand('%:r') --get dir dan nama file tanpa extensi
	local fileName = vim.fn.expand('%:t:r') --get nama file tanpa dir dan extensi
	local fileType = vim.fn.expand('%:e') --get extensi file

	local M = {
		rs = {
			compile = '',
			run = 'cd ' .. vim.fn.expand('%:h') .. ' && cargo run',
			delTemp = ''
		},
		cpp = {
			compile = 'g++ ' .. source .. ' -o ' .. temp,
			run = ' && ' .. temp,
			delTemp = ' && rm -rf ' .. temp
		},
		java = {
			compile = 'javac ' .. source .. ' -d ' .. temp,
			run = ' && cd ' .. temp .. ' && java ' .. fileName,
			delTemp = ' && cd $HOME && rm -rf ' .. temp
		},
		kt = {
			temp = temp .. '.jar',
			compile = 'kotlinc ' .. source .. ' -include-runtime -d ' .. temp,
			run = ' && java -jar ' .. temp,
			delTemp = ' && rm -rf ' .. temp
		},
	}

	local command = ''
	local F = M[fileType]

	if F then
		if F.compile ~= '' then command = F.compile end
		if F.run ~= '' then command = command .. F.run end
		if F.delTemp ~= '' then command = command .. F.delTemp end
	else
		print('\n[Err!] Buffer bukan file C++, Rust, Java, atau Kotlin!\n')
		return
	end

	if command ~= '' then
		vim.api.nvim_command(':w')
		vim.api.nvim_command('split term://' .. command)
	end
end

vim.api.nvim_command('command! -nargs=0 Cm lua CodeRunner()')

