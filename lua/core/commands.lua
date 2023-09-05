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
	local get = {
		src = vim.fn.expand('%'), -- get full path
		temp = vim.fn.expand('%:r'), -- get full path without ekstension
		type = vim.fn.expand('%:e'), -- get ekstension of buffer
		name = vim.fn.expand('%:t:r'), -- get a name of buffer
	}

	local M = {
		rs = {
			run = 'cd ' .. vim.fn.expand('%:h') .. ' && cargo run',
		},
		cpp = {
			compile = string.format("g++ %s -o %s ", get.src, get.temp),
			run = string.format("&& %s ", get.temp),
			delTemp = string.format("&& rm -rf %s", get.temp)
		},
		java = {
			compile = string.format("javac %s -d %s ", get.src, get.temp),
			run = string.format("&& cd %s && java %s ", get.temp, get.name),
			delTemp = string.format("&& cd $HOME && rm -rf %s", get.temp),
		},
		kt = {
			compile = string.format("kotlinc %s -include-runtime -d %s.jar ", get.src, get.temp),
			run = string.format("&& java -jar %s.jar ", get.temp),
			delTemp = string.format("&& rm -rf %s.jar", get.temp),
		},
	}

	local run = ''
	if M[get.type] then
		if M[get.type].compile then run = M[get.type].compile end
		if M[get.type].run then run = run .. M[get.type].run end
		if M[get.type].delTemp then run = run .. M[get.type].delTemp end
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
