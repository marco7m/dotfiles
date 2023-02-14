Entity = require('scripts.game0.Entity')

e = Entity:new(nil, 1,10)

print(e:get_char())
e:set_char('ooo')
print(e:get_char())
