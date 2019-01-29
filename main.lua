Class = require "hump.class"
Vector = require 'hump.vector'

require "player"
require "asteroid"

Background = {}
Background.image = nil
Background.image_copy = nil
Background.pos_x = 0
Background.scale = 4

function love.keypressed(key)
  Player:keypressed(key)
end

function love.keyreleased(key)
  Player:keyreleased(key)
end

function love.mousepressed(x,y,button,istouch)
    Player:mousepressed(x,y,button,istouch)
end



function love.load()
  
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  effect = love.graphics.newShader [[
        extern number time;
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            return vec4((1.0+sin(time))/2.0, abs(cos(time)), abs(sin(time)), 1.0);
        }
    ]]
  
  Player.load()
  Asteroid.load()
  Background.image = love.graphics.newImage("res/parallax-space-backgound.png")
  Background.image_copy = love.graphics.newImage("res/parallax-space-backgound.png")
end

function love.update(dt)
  Player.update(dt)
  Asteroid.update(dt)
  
  Background.pos_x = Background.pos_x - 1
  if ( Background.pos_x < Background.image:getWidth() * -1 * Background.scale ) then
    Background.pos_x = 0
  end
end

function love.draw()
  --love.graphics.setColor(1.0,0.0,0.0,1.0)
  --love.graphics.setColor(1,1,1,1)
  
  --love.graphics.setColor(1.0,0.0,1.0,1.0)
  love.graphics.draw(Background.image,Background.pos_x,-20,0,Background.scale,Background.scale)
  love.graphics.draw(Background.image,Background.pos_x + Background.image:getWidth() * Background.scale ,-20,0,4,4)
  
  Player.draw()
  Asteroid.draw()
end
