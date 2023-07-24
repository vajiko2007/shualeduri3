-- player.lua
local Player = {}
Player.__index = Player

function Player.new()
    local self = setmetatable({}, Player)
    self.x = 400
    self.y = 300
    self.speed = 200
    return self
end

return Player
