-- nvim/lua/user/lsp/handlers.lua

-- First, we declare an empty object and put auto-complete features from nvim-cmp (we will set up cmp.lua later) in the LSP
local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- protected call to get the cmp
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

-- Here we declare the setup function and add the modifications in signs and extra configs, like virtual text, false update_in_insert, rounded borders for float windows, etc.
M.setup = function()
	local signs = {
		-- change the "?" to an icon that you like
		{ name = 'DiagnosticSignError', text = '✘' },
		{ name = 'DiagnosticSignWarn', text = '▲' },
		{ name = 'DiagnosticSignHint', text = '⚑' },
		{ name = 'DiagnosticSignInfo', text = '' },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			border = 'rounded',
			source = 'always',
		},
	}
	vim.diagnostic.config(config)

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{ border = 'rounded' }
	)

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = 'rounded' }
	)
end

-- Here we set up keymaps. You can change them if you already have specifics for these functions, or just want to try another keymap.
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	-- Displays hover information about the symbol under the cursor
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

	-- Jump to the definition
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

	-- Jump to declaration
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)

	-- Lists all the implementations for the symbol under the cursor
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)

	-- Jumps to the definition of the type symbol
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

	-- Lists all the references
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)

	-- Displays a function's signature information
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

	-- Renames all references to the symbol under the cursor
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'glr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

	-- Selects a code action available at the current cursor position
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', opts)

	-- Show diagnostics in a floating window
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)

	-- Move to the previous diagnostic
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)

	-- Move to the next diagnostic
	vim.api.nvim_buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)


	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end

-- Here we let the LSP prioritize null-ls formatters. Why? Normally when we install a separate formatter or linter in null-ls we want to use just them.
-- if you don't prioritize any, neovim will ask you every time you format which one you want to use.
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- this function will attach our previously set keymaps and our lsp_formatting function to every buffer.
M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

-- And finally, here we create a way to toggle format on save with the command "LspToggleAutoFormat" and after everything, we return the M object to use it in other files.
function M.enable_format_on_save()
	vim.cmd [[
		augroup format_on_save
	autocmd!
autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
	augroup end
	]]
	vim.notify "Enabled format on save"
end

function M.disable_format_on_save()
	M.remove_augroup "format_on_save"
	vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
	if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
		M.enable_format_on_save()
	else
		M.disable_format_on_save()
	end
end

function M.remove_augroup(name)
	if vim.fn.exists("#" .. name) == 1 then
		vim.cmd("au! " .. name)
	end
end

vim.cmd [[ command! LspToggleAutoFormat execute 'lua ]]

-- Toggle "format on save" once, to start with the format on.
M.toggle_format_on_save()
-- M.disable_format_on_save()



return M
