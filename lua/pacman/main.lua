#!/usr/bin/env lua

_G.love = require("love")

function love.load()
    love.graphics.setBackgroundColor(0.5, 0.5, 1)
    _G.number = 0
    _G.pacman = {
        x = 200,
        y = 250,
        eat = true,
        angle1 = 1,
        angle2 = 5
    }
    _G.food = {
        x = 600,
        eaten = false
    }
end

function love.update(dt)
    number = number + 1
    if love.keyboard.isDown("a", "left") then
        pacman.x = pacman.x - 1
    end
    if love.keyboard.isDown("d", "right") then
        pacman.x = pacman.x + 1
    end
    if love.keyboard.isDown("w", "up") then
        pacman.y = pacman.y - 1
    end
    if love.keyboard.isDown("s", "down") then
        pacman.y = pacman.y + 1
    end

    if pacman.x >= food.x + 50 then
        food.eaten = true
    end
end

function love.draw()
    -- love.graphics.print(number)

    if not food.eaten then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", food.x, 200, 70, 70)
    end
    love.graphics.setColor(1, 0.7, 0.1)
    love.graphics.arc("fill", pacman.x, pacman.y, 60, pacman.angle1, pacman.angle2)
end

