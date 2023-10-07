-- nvim/lua/config/lsp/init.lua

require("config.lsp.mason")
require("config.lsp.handlers").setup()
require("config.lsp.null-ls")
require("config.lsp.cmp")
require("config.lsp.treesitter")
require("config.lsp.rust-tools")
