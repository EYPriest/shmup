Class = require "hump.class"
Vector = require 'hump.vector'

scale_x = love.graphics.getWidth() / 240
scale_y = love.graphics.getHeight() / 160
SCALE_GLOBAL = scale_x

STATE_ALIVE = 1
STATE_DYING = 2
STATE_DEAD = 3

require "player"
require "asteroid"
require "asteroid-blue"
require "bullet"

--TODO: uncapitalize??
Background = {}
Background.image = nil
Background.image_copy = nil
Background.pos_x = 0
--Background.scale = 4

--asteroids = {}
entities_alive = {}
entities_dying = {}
asteroid_time_accumulator = 0
asteroid_spawn_time = 1

bullets = {}
enemies_alive = {}
enemies_dying = {}
--obstacles = {}
--pickups = {}


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
  --love.graphics.setDefaultFilter( "nearest" )
  love.graphics.setDefaultFilter("nearest","nearest")
  
  Player.load()
  --Asteroid:load()
  Background.image = love.graphics.newImage("res/parallax-space-backgound.png")
  Background.image_copy = love.graphics.newImage("res/parallax-space-backgound.png")
end

function love.update(dt)
  
  --Create Asteroids
  asteroid_time_accumulator = asteroid_time_accumulator + dt
  if ( asteroid_time_accumulator > asteroid_spawn_time ) then
    asteroid_time_accumulator = asteroid_time_accumulator - asteroid_spawn_time
    table.insert( enemies_alive, AsteroidBlue( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
    --table.insert( asteroids, AsteroidBlue( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
  end
  
  --Update Player
  Player.update(dt)
  
  --Update Enemies
  --Alive
  for i,en in ipairs( enemies_alive ) do
    en:update(dt)
    if ( en.pos.x < 0 - 100 ) then
      table.remove(enemies_alive,i)
    end
    if ( en.state == STATE_DEAD ) then
      table.remove(enemies_alive,i)
    end
  end
  
  --Dead
  for i,ed in ipairs( enemies_dying ) do
    ed:update(dt)
    if ( ed.pos.x < 0 - 100 ) then
      table.remove(enemies_dying,i)
    end
    if ( ed.state == STATE_DEAD ) then
      table.remove(enemies_dying,i)
    end
  end
  
  --Update Bullets
  for i,v in ipairs( bullets ) do
    v:update(dt)
    if ( v.pos.x > love.graphics.getWidth() ) then
      table.remove(bullets,i)
    end
  end
  
  --Move Background
  Background.pos_x = Background.pos_x - 1
  if ( Background.pos_x < Background.image:getWidth() * -1 * scale_x ) then
    Background.pos_x = 0
  end
  
  --bullets_to_remove = {}
  
  --Collision Detection
  for i,b in ipairs( bullets ) do
    b_collide = b:getColliders()
    for j,a in ipairs( enemies_alive ) do
      a_collide = a:getColliders()
        if CheckCollision(a_collide[1],a_collide[2],a_collide[3],a_collide[4],
                          b_collide[1],b_collide[2],b_collide[3],b_collide[4] ) then
          
          a_hp = a:hit()
          if ( a_hp <= 0 ) then
            -- asteroids need to do a death animation, so they can't die here
            --table.remove(asteroids,j)
            table.insert(enemies_dying,a)
            table.remove(enemies_alive,j)
            
          end
          --if ( a_hp >= 0 ) then
            --table.remove(bullets,i)
          --end
          table.remove(bullets,i)
         
          --table.insert(bullets_to_remove,b)
          break
        end
    end
  end
  
  --[[
  for k,v in ipairs( bullets_to_remove ) do
    table.remove(bullets, 1)
  end
  --]]
  
  
end

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.draw()
  --love.graphics.setColor(1.0,0.0,0.0,1.0)
  --love.graphics.setColor(1,1,1,1)
  
  --love.graphics.setColor(1.0,0.0,1.0,1.0)
  --love.graphics.draw(Background.image,Background.pos_x,-20,0,Background.scale,Background.scale)
  --love.graphics.draw(Background.image,Background.pos_x + Background.image:getWidth() * Background.scale ,-20,0,4,4)
  love.graphics.draw(Background.image,Background.pos_x,-20,0,scale_x,scale_y)
  love.graphics.draw(Background.image,Background.pos_x + Background.image:getWidth() * scale_x ,-20,0,scale_x,scale_y)
  
  for i,v in ipairs( enemies_dying ) do
    v:draw()
  end
  
  for i,v in ipairs( enemies_alive ) do
    v:draw()
  end

  for i,v in ipairs( bullets ) do
    v:draw()
  end
  
  Player.draw()

end
