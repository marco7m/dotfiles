require('scripts.pet')
require('scripts.car')
game0 = require('scripts.game0')
vim.keymap.set('n', 'ttt5', '', {callback=game0.release_pet, desc = "release pet"})
vim.keymap.set('n', 'ttt4', '', {callback=game0.new_pet})

--local textmode = require('scripts.textmode')
--vim.api.nvim_create_user_command('TextmodeEnter', textmode, {force = false})
