local Plugin = {
	 'norcalli/nvim-colorizer.lua',
}

function Plugin.config()
	require'colorizer'.setup()
end

return Plugin
