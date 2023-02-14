local event_loop = {}

event_loop.start = function(pet_win, speed)
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


local loop = function()
end
