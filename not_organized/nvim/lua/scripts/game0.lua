utils = require('scripts.game0.utils')

local M = {}
M.pet_list = {}
local conf = {character="🚗", speed=10, width=2, height=1}

local time_ini = vim.fn.reltime()
local vel_x = 0
local vel_y = 0
local screen_buf

local waddle = function(pet_win, speed)
    local timer = vim.loop.new_timer()
    local new_pet_win = { name = pet_win, timer = timer }
    table.insert(M.pet_list, new_pet_win)

    local waddle_period = 1000 / (speed or conf.speed)
    vim.loop.timer_start(timer, 1000, waddle_period, vim.schedule_wrap(function()
        if vim.api.nvim_win_is_valid(pet_win) then
            local config = vim.api.nvim_win_get_config(pet_win)
            local col, row = config["col"][false], config["row"][false]

            math.randomseed(os.time()*pet_win)
            local new_row = row + vel_y
            local new_col = col + vel_x
            -- vel_y = 0
            -- vel_x = 0

            local move
            move = utils.check_is_valid_position(screen_buf, new_row, new_col)

            if move == true then
                config["row"] = new_row
                config["col"] = new_col
            else                
                -- print("dont move")
            end

            vim.api.nvim_win_set_config(pet_win, config)
        end
    end))
end

M.new_pet = function(character, speed)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf , 0, 1, true , {character or conf.character})

    local pet_win = vim.api.nvim_open_win(buf, false, {
        relative='cursor', style='minimal', row=20, col=100, width=conf.width, height=conf.height
    })
    vim.api.nvim_win_set_option(pet_win, 'winhighlight', 'Normal:Normal')
    -- vim.cmd([[ set winblend=100 ]])

    -- set keymaps on pet buffer
    screen_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_set_current_buf(buf)
    vim.keymap.set({'n', 'i'}, '<Up>', '', {callback=M.key_press_up, buffer=0})
    vim.keymap.set({'n', 'i'}, '<Left>', '', {callback=M.key_press_left, buffer=0})
    vim.keymap.set({'n', 'i'}, '<Right>', '', {callback=M.key_press_right, buffer=0})
    vim.keymap.set({'n', 'i'}, '<Down>', '', {callback=M.key_press_down, buffer=0})
    vim.api.nvim_set_current_buf(screen_buf)

    waddle(pet_win, speed)
end

M.key_press_up = function()
    -- print(vim.fn.reltimefloat(vim.fn.reltime(time_ini)))
    time_ini = vim.fn.reltime()
    if vel_y ~= -1 then
        vel_y = -1
        vel_x = 0
    else
        vel_y = 0
        vel_x = 0
    -- print("up")
    end
end
M.key_press_left = function()
    if vel_x ~= -2 then
        vel_x = -2
        vel_y = 0
    else
        vel_y = 0
        vel_x = 0
    -- print("left")
    end
end
M.key_press_right = function()
    if vel_x ~= 2 then
        vel_x = 2
        vel_y = 0
    else
        vel_y = 0
        vel_x = 0
    -- print("right")
    end
end
M.key_press_down = function()
    if vel_y ~= 1 then
        vel_y = 1
        vel_x = 0
    else
        vel_y = 0
        vel_x = 0
    -- print("down")
    end
end


M.release_pet = function()
    local last_pet_win = M.pet_list[#M.pet_list]

    if not last_pet_win then
        vim.notify("No pets to remove!")
        return
    end

    local pet_win = last_pet_win['name']
    local timer = last_pet_win['timer']
    table.remove(M.pet_list, #M.pet_list)
    timer:stop()

    vim.api.nvim_win_close(pet_win, true)
end

M.setup = function(opts)
    conf = vim.tbl_deep_extend('force', conf, opts or {})
end

-- vim.api.nvim_set_keymap('n', 'ttt0', '', { noremap = true, callback= M.new_pet, desc = "new pet"})

return M
