local Entity = {
    char = '@',
    vel_x = 0,
    vel_y = 0,
    pos_x = 0,
    pos_y = 0,
}

function Entity:new(o, pos_x, pos_y)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.pos_x = pos_x
    self.pos_y = pos_y
    return o
end

function Entity:set_char(char)
    self["char"] = char
end

function Entity:get_char()
    return self["char"]
end

return Entity
