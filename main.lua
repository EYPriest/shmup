--Class = require "hump.class"
require "player"

function love.keypressed(key)
  Player:keypressed(key)
end

function love.keyreleased(key)
  Player:keyreleased(key)
end


function love.load()
  Player.load()
end

function love.update(dt)
  Player.update(dt)
end

function love.draw()
  Player.draw()
end
