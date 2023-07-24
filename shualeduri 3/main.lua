
local Player = require("player")
local Item = require("item")
local GameStates = require("gamestates")

local font

function love.load()
    love.window.setTitle("pack man lite")
    love.window.setMode(800, 600)
    love.graphics.setBackgroundColor(0, 0, 0)

    font = love.graphics.newFont(20)

    gameStates = GameStates.new()
end

function love.update(dt)
    gameStates:update(dt)
end

function love.draw()
    gameStates:draw()
end

function love.keypressed(key)
    gameStates:keypressed(key)
end
