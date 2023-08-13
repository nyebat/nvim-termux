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
-- COMPILE AND RUN
function CodeRunner()
    local source = vim.fn.expand('%')
    local temp = vim.fn.expand('%:r') -- get pathfile/filename (without ekstension)
    local typeFile = vim.fn.expand('%:e')
    local nameFile = vim.fn.expand('%:t:r')

    local compile = ''
    local run = ''
    local delTemp = ' && rm -rf ' .. temp

    if typeFile == 'rs' then
        -- rust
        compile = 'rustc ' .. source .. ' -o ' .. temp
        run = ' && ' .. temp

    elseif typeFile == 'cpp' then
        -- c++
        compile = 'g++ ' .. source .. ' -o ' .. temp
        run = ' && ' .. temp

    elseif typeFile == 'java' then
        -- java
        compile = 'javac ' .. source .. ' -d ' .. temp
        run = ' && cd ' .. temp .. ' && java ' .. nameFile
        delTemp = ' && cd $HOME && rm -rf ' .. temp

    elseif typeFile == 'kt' then
        -- kotlin
        temp = temp .. '.jar'
        compile = 'kotlinc ' .. source .. ' -include-runtime -d ' .. temp
        run = ' && java -jar ' .. temp
        delTemp = ' && rm -rf ' .. temp
    end

    if compile ~= '' then
        vim.api.nvim_command(':w')
        -- compile, run, and delete binary temp
		print("masuk ke: " .. temp)
        vim.api.nvim_command('split term://' .. compile .. run .. delTemp)
        -- os.remove(temp)
    else
        print('\n[Err!] Buffer bukan file C++, Rust, Java, atau Kotlin!\n')
    end
end

vim.api.nvim_command('command! -nargs=0 Cm lua CodeRunner()')

