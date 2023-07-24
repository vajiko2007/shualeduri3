
local Player = require("player")
local Item = require("item")

local GameStates = {}
GameStates.__index = GameStates

function GameStates.new()
    local self = setmetatable({}, GameStates)
    self.currentState = "menu"
    self.font = love.graphics.newFont(20)
    self.player = Player.new()
    self.items = {}
    self.numItems = 5
    self:generateItems()
    return self
end

function GameStates:generateItems()
    for i = 1, self.numItems do
        local item = Item.new(math.random(50, 750), math.random(50, 550))
        table.insert(self.items, item)
    end
end

function GameStates:update(dt)
    if self.currentState == "game" then
        local dx, dy = 0, 0

        if love.keyboard.isDown("left") then
            dx = -self.player.speed * dt
        elseif love.keyboard.isDown("right") then
            dx = self.player.speed * dt
        end

        if love.keyboard.isDown("up") then
            dy = -self.player.speed * dt
        elseif love.keyboard.isDown("down") then
            dy = self.player.speed * dt
        end

        self.player.x = self.player.x + dx
        self.player.y = self.player.y + dy

        for i, item in ipairs(self.items) do
            if self:distance(self.player.x, self.player.y, item.x, item.y) < 30 then
                table.remove(self.items, i)
                break
            end
        end

        if #self.items == 0 then
            self.currentState = "end"
        end
    end
end

function GameStates:draw()
    love.graphics.setFont(self.font)

    if self.currentState == "menu" then
        love.graphics.setColor(255, 255, 255)
        love.graphics.printf("Press SPACE to start the game!", 0, 250, love.graphics.getWidth(), "center")
    elseif self.currentState == "game" then
        love.graphics.setColor(255, 255, 255)
        love.graphics.printf("Use arrow keys to move the character.", 0, 10, love.graphics.getWidth(), "center")
        love.graphics.rectangle("fill", self.player.x, self.player.y, 50, 50) -- Player rectangle

        love.graphics.setColor(255, 0, 0)
        for _, item in ipairs(self.items) do
            love.graphics.circle("fill", item.x, item.y, 10) -- Draw items as red circles
        end
    elseif self.currentState == "end" then
        love.graphics.setColor(255, 255, 255)
        love.graphics.printf("Congratulations! You collected all items.", 0, 250, love.graphics.getWidth(), "center")
    end
end

function GameStates:keypressed(key)
    if key == "space" then
        if self.currentState == "menu" then
            self.currentState = "game"
        elseif self.currentState == "game" then
            self.currentState = "end"
        elseif self.currentState == "end" then
            self.currentState = "menu"
            self.player = Player.new()
            self.items = {}
            self:generateItems()
        end
    end
end

function GameStates:distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

return GameStates
