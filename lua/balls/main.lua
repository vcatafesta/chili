#!/usr/bin/env lua

local love = require("love")
local game = {
    state = {
        menu = true,
        paused = false,
        running = true,
        ended = true
    }
}

local player = {
    radius = 20,
    x = 30,
    y = 30
}

function love.load()
    love.window.setTitle("Save the ball")
end

function love.update(dt)
    player.x, player.y = love.mouse.getPosition()
end

function love.draw()
    love.graphics.printf("FPS: " .. love.timer.getFPS(), love.graphics.newFont(16), 10, love.graphics.getWidth() - 30,
        love.graphics.getWidth())
    if game.state["running"] then
        love.graphics.circle("fill", player.x, player.y, player.radius)
    end
    if game.state["running"] then
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    end
end

