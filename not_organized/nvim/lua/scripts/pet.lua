local M = {}
M.pet_list = {}
-- local conf = {character="🦆", speed=10, width=2, height=1}
local conf = {character="🐜", speed=10, width=2, height=1}

local check_is_valid_position = function(new_row, new_col)
    if new_row < 0 then
        return false
    end

    if new_row > vim.o.lines then
        return false
    end

    if new_col < 0 then
        return false
    end

    if new_col > vim.o.columns then
        return false
    end

    local line = vim.fn.getline(math.floor(new_row+1))
    if (string.sub(line, new_col-2, new_col-2) ~= '') and (string.sub(line, new_col-2, new_col-2) ~= ' ') then
        return false
    end

    return true
end

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
            -- local angle = 2 * math.pi * math.random()
            -- local s = math.sin(angle)
            -- local c = math.cos(angle)
            -- local new_row = row + 0.5 + s
            -- local new_col = col + 1 * c
            local new_row = row
            local new_col = col

            local move = {}
            local num_try = 0
            repeat
                -- if math.random() < 0.5 then
                --     new_row = new_row - 1
                -- end
                -- if math.random() < 0.5 then
                --     new_col = new_col - 1
                -- end
                -- if math.random() < 0.5 then
                --     new_row = new_row + 1
                -- end
                -- if math.random() < 0.5 then
                --     new_col = new_col + 1
                -- end

                    new_row = new_row + math.random()
                    new_row = new_row - math.random()
                    new_col = new_col + 2*math.random()
                    new_col = new_col - 2*math.random()

                move = check_is_valid_position(new_row, new_col)
                num_try = num_try + 1
            until move == true or num_try >= 3


            if move == true then
                config["row"] = new_row
                config["col"] = new_col
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

    waddle(pet_win, speed)
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
vim.keymap.set('n', 'ttt1', '', {callback=M.release_pet, desc = "release pet"})
vim.keymap.set('n', 'ttt0', '', {callback=M.new_pet})

return M
