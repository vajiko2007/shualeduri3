
local Item = {}
Item.__index = Item

function Item.new(x, y)
    local self = setmetatable({}, Item)
    self.x = x
    self.y = y
    return self
end

return Item
