local utils = {}

utils.check_is_valid_position = function(screen_buf, new_row, new_col)
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

    local line = vim.fn.getbufline(screen_buf, new_row+1)
    -- print(string.sub(line, (new_col-2), (new_col-2)))
    if line[1] == nil then
        return true
    elseif (string.sub(line[1], (new_col-2), (new_col-2)) ~= '') and (string.sub(line[1], (new_col-2), (new_col-2)) ~= ' ') then
        print(line[1])
        return false
    end
    return true
end

return utils
