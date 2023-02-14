-- want libmodal (see libmodal readme)
local _maps = {
    ['u'] = function() vim.api.nvim_command('vs') end,
}

return function()
	require('libmodal').mode.enter('TEXTMODE', _maps)
end
