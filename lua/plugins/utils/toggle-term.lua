-- Terminal
local Plugin = {
  "akinsho/toggleterm.nvim",
  config = true,
  branch = "main",
}

Plugin.opts = {

  --active = true,
  --on_config_done = nil,
  -- size can be a number or function which is passed the current terminal
  --~ size = 60,
  open_mapping = [[<M-i>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
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
    --width = 50,
    --height = 25,
    winblend = 0,
    highlights = {
      border = "normal",
      background = "Normal",
    },
  },
}

Plugin.keys = {
  {'<M-i>', '<cmd>ToggleTerm size=20 direction=float<cr>'},
  {'<M-1>', '<cmd>ToggleTerm open_mapping=[[<M-2>]] size=60 direction=vertical<cr>'},
  {'<M-2>', '<cmd>ToggleTerm open_mapping=[[<M-2>]] size=10 direction=horizontal<cr>'},
  {'<M-3>', '<cmd>ToggleTerm open_mapping=[[<M-3>]] size=20 direction=float<cr>'},
}

return Plugin
