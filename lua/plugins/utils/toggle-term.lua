-- Terminal
local Plugin = {
  "akinsho/toggleterm.nvim",
  config = true,
  branch = "main",
}

Plugin.opts = {

  --~ size = 60,
  open_mapping = [[<M-i>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = false,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = "float",
  close_on_exit = true, -- close the terminal window when the process exits
  shell = nil, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = "curved",
    width = 65,
    height = 20,
    winblend = 0,
    highlights = {
      border = "normal",
      background = "Normal",
    },
  },
}

-- Plugin.keys = {
--   {'<M-i>', '<cmd>ToggleTerm<cr>'},
--   {'<M-1>', '<cmd>ToggleTerm open_mapping=[[<M-2>]] size=60 direction=vertical<cr>'},
--   {'<M-2>', '<cmd>ToggleTerm open_mapping=[[<M-2>]] size=25 direction=horizontal<cr>'},
--   {'<M-3>', '<cmd>ToggleTerm open_mapping=[[<M-3>]] direction=float<cr>'},
-- }

return Plugin
