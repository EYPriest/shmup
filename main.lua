Class = require "hump.class"
Vector = require 'hump.vector'

require "player"
require "asteroid"
require "asteroid-blue"
require "bullet"

Background = {}
Background.image = nil
Background.image_copy = nil
Background.pos_x = 0
Background.scale = 4

asteroids = {}
asteroid_time_accumulator = 0
asteroid_spawn_time = 1

bullets = {}

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
    
  --love.graphics.setDefaultFilter( min, mag, anisotropy )
  love.graphics.setDefaultFilter( "nearest" )
  
  Player.load()
  --Asteroid:load()
  --a = Asteroid( Vector(100,100) )
  --b = Asteroid( Vector(200,200) )
  Background.image = love.graphics.newImage("res/parallax-space-backgound.png")
  Background.image_copy = love.graphics.newImage("res/parallax-space-backgound.png")
end

function love.update(dt)
  
  --Create Asteroids
  asteroid_time_accumulator = asteroid_time_accumulator + dt
  if ( asteroid_time_accumulator > asteroid_spawn_time ) then
    asteroid_time_accumulator = asteroid_time_accumulator - asteroid_spawn_time
    table.insert( asteroids, AsteroidBlue( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
    --table.insert( asteroids, AsteroidBlue( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
  end
  
  --Update Player
  Player.update(dt)
  --a:update(dt)
  --b:update(dt)
  
  --Update Asteroids
  for i,v in ipairs( asteroids ) do
    v:update(dt)
    if ( v.pos.x < 0 - 100 ) then
      table.remove(asteroids,i)
    end
  end
  
  --Update Bullets
  for i,v in ipairs( bullets ) do
    v:update(dt)
    if ( v.pos.x > love.graphics.getWidth() ) then
      table.remove(bullets,i)
    end
  end
  
  
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
  
  for i,v in ipairs( asteroids ) do
    v:draw()
  end
  
  for i,v in ipairs( bullets ) do
    v:draw()
  end
  
  Player.draw()
  --a:draw()
  --b:draw()
end
