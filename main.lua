Class = require "hump.class"
Vector = require 'hump.vector'

local ProFi = require "other.ProFi"
--ProFi:start()

--Constants
--SCALE_X = love.graphics.getWidth() / 240
--SCALE_Y = love.graphics.getHeight() / 160
SCALE_X = love.graphics.getWidth() / 240
SCALE_Y = love.graphics.getHeight() / 160
--SCALE_GLOBAL = SCALE_X

--Enemy States
STATE_ALIVE = 1
STATE_DYING = 2
STATE_DEAD = 3

--Game State
GAMESTATE_RUNNING = 1
GAMESTATE_GAMEOVER = 2
gamestate = GAMESTATE_RUNNING

--Files
require "shaders"
require "player"
require "bullet"
require "enemy"
require "bullet_enemy"
--require "asteroid"
require "asteroid-blue"
require "enemy_ship"
require "spin_ship"
require "level-test-1"
require "wave"
require "terrain"
require "level-1-terrain"

--Debug Constants
DEBUG_SHOW_HITBOXES = true
DEBUG_SHOW_ORIGIN = true
DEBUG_SHOW_STATS = true
--DEBUG_STATS_ACCUMULATOR = 0

debug_time_t1 = nil
debug_time_t2 = nil
debug_time_t3 = nil
debug_time_t4 = nil
debug_time_totals = {0,0,0,0} -- Per ~60 frames
debug_time_adders = {0,0,0,0}
debug_time_accumulator = 0
-- 1,2 : update and draw totals
-- 3,4 : in update: updating stuff, collision detection

--print(_VERSION)


--TODO: uncapitalize??
Background = {}
Background.image = nil
Background.image_copy = nil
Background.pos_x = 0

--Camera stuff
camera_offset_y = 0

--Asteroid stuff
asteroid_time_accumulator = 0
asteroid_spawn_time = 0.8

--Enemy Ship stuff
enemy_ship_time_accumulator = 0
enemy_ship_spawn_time = 2

--Spin Ship stuff
spin_ship_time_accumulator = 0
spin_ship_spawn_time = 6

--Entity Collections
bullets_from_player = {}
bullets_from_enemies = {}
enemies_alive = {}
enemies_dying = {}
terrains = {}
--obstacles = {}
--pickups = {}

screen_flash = 0
screen_flash_time = 1

--Inputs
function love.keypressed(key)
  
  if key == 'escape' then
    love.event.quit( 0 )
  else
    Player:keypressed(key)
  end
end

function love.keyreleased(key)
  Player:keyreleased(key)
end

function love.mousepressed(x,y,button,istouch)
    Player:mousepressed(x,y,button,istouch)
end

function love.mousereleased(x,y,button,istouch)
    Player:mousereleased(x,y,button,istouch)
end

function love.load()
  
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  --love.graphics.setDefaultFilter( min, mag, anisotropy )
  --love.graphics.setDefaultFilter( "nearest" )
  love.graphics.setDefaultFilter("nearest","nearest")
  
  ProFi:start()
  
  Player.load()
  --Asteroid:load()
  Background.image = love.graphics.newImage("res/parallax-space-backgound.png")
  Background.image_copy = love.graphics.newImage("res/parallax-space-backgound.png")
  
  LevelTest1.load()
end

function love.update(dt)
  --dt = 0.1
  
  debug_time_t1 = love.timer.getTime()
  
  if ( gamestate == GAMESTATE_GAMEOVER ) then
    Restart()
    gamestate = GAMESTATE_RUNNING
    return
  end
  
  
  --print (dt)
  
  debug_time_t3 = love.timer.getTime()

  LevelTest1.update(dt)
  
  
  --Update Player
  Player.update(dt)
  
  --TODO: maybe, instead of the player staying still, and the enemies and level
  -- moving left.
  -- Maybe I keep everything in a specific location. and have the Player, move RIGHT
  -- then it's like a real ship, and i can do things like terrain collision boxes being where
  -- they're supposed to be.
  -- There are prob drawbacks tho. i have to review this. Maybe it doesn't really matter.
  
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
  
  --Update Player Bullets
  for i,v in ipairs( bullets_from_player ) do
    v:update(dt)
    if ( v.pos.x > love.graphics.getWidth() ) then
      table.remove(bullets_from_player,i)
    end
  end
  
  --Update Enemy Bullets
  for i,be in ipairs( bullets_from_enemies ) do
    be:update(dt)
    if( be.pos.x < -10 ) then
      table.remove(bullets_from_enemies,i)
    end
  end
  
  --Update Terrain
  for i,t in ipairs( terrains ) do
    t:update(dt)
    if( t.pos.x < -11000 ) then
      table.remove(terrains,i)
    end
  end
  
  --Move Background
  Background.pos_x = Background.pos_x - 1
  if ( Background.pos_x < Background.image:getWidth() * -1 * SCALE_X ) then
    Background.pos_x = 0
  end
  
  --bullets_to_remove = {}
  
  --Debug Timer Stuff
  debug_time_t4 = love.timer.getTime()
  debug_time_adders[3] = debug_time_adders[3] + debug_time_t4 - debug_time_t3
  
  debug_time_t3 = love.timer.getTime()
  
  --Collision Detection
  --Bullets from Player with Enemy Ships
  for i,b in ipairs( bullets_from_player ) do
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
          table.remove(bullets_from_player,i)
         
          --table.insert(bullets_to_remove,b)
          break
        end
    end
  end
  
  --Player with enemy bullets
  p_collide = Player:getColliders()
  for i, be in ipairs( bullets_from_enemies ) do
    be_collide = be:getColliders()
    if CheckCollision(p_collide[1],p_collide[2],p_collide[3],p_collide[4],
                          be_collide[1],be_collide[2],be_collide[3],be_collide[4] )    then
      PlayerHit()
      table.remove(bullets_from_enemies,i)
    end
  end
  
  --Player with enemies alive
  p_collide = Player:getColliders()
  for i, e in ipairs( enemies_alive ) do
    e_collide = e:getColliders()
    if CheckCollision(p_collide[1],p_collide[2],p_collide[3],p_collide[4],
                          e_collide[1],e_collide[2],e_collide[3],e_collide[4] )    then
      PlayerHit()
      table.remove(enemies_alive,i)
      table.insert(enemies_dying,e)
      e:die()
    end
  end
  
  --Player with terrain
  p_collide = Player:getColliders()
  --TODO: don't need to repeat the above line 6 times
  for i,t in ipairs( terrains ) do
    for j,cbox in ipairs( t.collision_boxes ) do
      if CheckCollision(p_collide[1],p_collide[2],p_collide[3],p_collide[4],
                          cbox[1] + t.pos.x,cbox[2] + t.pos.y,cbox[3],cbox[4] ) then
        PlayerHit()
        
      end
    end
  end
      
  --[[
  for k,v in ipairs( bullets_to_remove ) do
    table.remove(bullets, 1)
  end
  --]]
  
  debug_time_t4 = love.timer.getTime()
  debug_time_adders[4] = debug_time_adders[4] + debug_time_t4 - debug_time_t3
  
  debug_time_t2 = love.timer.getTime()
  debug_time_adders[1] = debug_time_adders[1] + debug_time_t2 - debug_time_t1
  
end
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  -- Collision detection function;
  -- Returns true if two boxes overlap, false if they don't;
  -- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
  -- x2,y2,w2 & h2 are the same, but for the second box.
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

--Draw
function love.draw()
  
  debug_time_t1 = love.timer.getTime()
  
  --love.graphics.scale(2,2)
  
  love.graphics.translate(0,camera_offset_y)
  
  --love.graphics.draw(Background.image,Background.pos_x,-20,0,SCALE_X,SCALE_Y)
  --love.graphics.draw(Background.image,Background.pos_x + Background.image:getWidth() * SCALE_X ,-20,0,SCALE_X,SCALE_Y)
  love.graphics.draw(Background.image,Background.pos_x,0,0,SCALE_X,SCALE_Y)
  love.graphics.draw(Background.image,Background.pos_x + Background.image:getWidth() * SCALE_X ,0,0,SCALE_X,SCALE_Y)
  --TODO: Remeber Why was that -20???
  
  
  --love.graphics.print( text, x, y, r, sx, sy, ox, oy, kx, ky )
  love.graphics.print( "HP = " .. Player.hp, 22, 31 - camera_offset_y, 0, 1 )
  if ( DEBUG_SHOW_STATS ) then
    --print( "enemies_alive size: " .. table.getn(enemies_alive) )
    --print( "enemies_dying size: " .. table.getn(enemies_dying) )
    --print( "bullets size: " .. table.getn(bullets_from_player) )
    love.graphics.print( "enemies_alive size: " .. #enemies_alive, 22, 43 - camera_offset_y, 0, 1 )
    love.graphics.print( "enemies_dying size: " .. #enemies_dying, 22, 55 - camera_offset_y, 0, 1 )
    love.graphics.print( "bullets_from_player size: " .. #bullets_from_player, 22, 67 - camera_offset_y, 0, 1 )
    love.graphics.print( "bullets_from_enemies size: " .. #bullets_from_enemies, 22, 79 - camera_offset_y, 0, 1 )
    
    debug_time_accumulator = debug_time_accumulator + 1
    if ( debug_time_accumulator > 60 ) then
      debug_time_accumulator = 0
      debug_time_totals[1] = debug_time_adders[1]
      debug_time_totals[2] = debug_time_adders[2]
      debug_time_totals[3] = debug_time_adders[3]
      debug_time_totals[4] = debug_time_adders[4]

      debug_time_adders[1] = 0
      debug_time_adders[2] = 0
      debug_time_adders[3] = 0
      debug_time_adders[4] = 0
    end
    love.graphics.print( "update total time: " .. debug_time_totals[1], 22, 91 - camera_offset_y, 0, 1 )
    love.graphics.print( "draw total time: " .. debug_time_totals[2], 22, 103 - camera_offset_y, 0, 1 )
    love.graphics.print( "update update time: " .. debug_time_totals[3], 22, 115 - camera_offset_y, 0, 1 )
    love.graphics.print( "updade collision time: " .. debug_time_totals[4], 22, 127 - camera_offset_y, 0, 1 )
    --love.graphics.print( "Player.y: " .. Player.y, 22, 139 - camera_offset_y, 0, 1 )
    --love.graphics.print( "camera_offset_y: " .. camera_offset_y, 22, 151 - camera_offset_y, 0, 1 )
    love.graphics.print( "dimensions: " .. love.graphics.getWidth() .. ", " .. love.graphics.getHeight(), 22, 139 - camera_offset_y, 0, 1 )
  end
  
  --[[
  for i,t in ipairs( terrains ) do
    t:draw()
    if ( DEBUG_SHOW_HITBOXES ) then
      for i,q in ipairs( t.collision_boxes ) do
        love.graphics.setColor(255,0,0,0.2)
        box = q
        --TODO: do scale_global multiplacion in terrain, not here
        love.graphics.rectangle("fill", box[1] + t.pos.x, box[2] + t.pos.y, box[3], box[4] )
        love.graphics.setColor(255,255,255,1)
      end
    end
  end
  --]]
  for i,t in ipairs( terrains ) do
    t:draw()
    if ( DEBUG_SHOW_HITBOXES ) then
      for i,q in ipairs( t.collision_boxes ) do
        love.graphics.setColor(1,0,0,0.2)
        box = q
        --TODO: do scale_global multiplacion in terrain, not here
        love.graphics.rectangle("fill", box[1] + t.pos.x, box[2] + t.pos.y, box[3], box[4] )
        love.graphics.setColor(1,1,1,1)
      end
    end
  end
  
  for i,v in ipairs( enemies_dying ) do
    v:draw()
  end
  
  for i,v in ipairs( enemies_alive ) do
    v:draw()
    if ( DEBUG_SHOW_HITBOXES ) then
      love.graphics.setColor(1,0,0,0.2)
      box = v:getColliders()
      love.graphics.rectangle("fill", box[1], box[2], box[3], box[4] )
      love.graphics.setColor(1,1,1,1)
    end
    if ( DEBUG_SHOW_ORIGIN ) then
      love.graphics.setColor(0,0.5,0,1)
      love.graphics.points(v.pos.x,v.pos.y)
      love.graphics.setColor(1,1,1,1)
    end
  end
  if ( DEBUG_SHOW_HITBOXES ) then
      love.graphics.setColor(1,0,0,0.2)
      box = Player:getColliders()
      love.graphics.rectangle("fill", box[1], box[2], box[3], box[4] )
      love.graphics.setColor(1,1,1,1)
    end

  for i,v in ipairs( bullets_from_player ) do
    v:draw()
  end
  
  for i,v in ipairs( bullets_from_enemies ) do
    v:draw()
    if ( DEBUG_SHOW_ORIGIN ) then
      love.graphics.setColor(0,1,0,1)
      love.graphics.points(v.pos.x,v.pos.y)
      love.graphics.setColor(1,1,1,1)
    end
  end
  
  --love.graphics.setColor(0.5,0.5,0.5,1)
  
  Player.draw()
  
  --[[
  if ( DEBUG_SHOW_STATS ) then
    DEBUG_STATS_ACCUMULATOR = DEBUG_STATS_ACCUMULATOR + 1
    if ( DEBUG_STATS_ACCUMULATOR > 60 ) then
      DEBUG_STATS_ACCUMULATOR = DEBUG_STATS_ACCUMULATOR - 60
      --print( "enemies_alive size: " .. table.getn(enemies_alive) )
      --print( "enemies_dying size: " .. table.getn(enemies_dying) )
      --print( "bullets size: " .. table.getn(bullets_from_player) )
    end
  end
  --]]
  
  if ( screen_flash > 0 ) then
    love.graphics.setColor(1,0.9,0.9,1)
    --ffbf00
    --love.graphics.setColor(
    love.graphics.rectangle("fill", 0, -camera_offset_y, love.graphics.getWidth(), love.graphics.getHeight() )
    love.graphics.setColor(1,1,1,1)
    screen_flash = screen_flash - 1
  end
  
  debug_time_t2 = love.timer.getTime()
  debug_time_adders[2] = debug_time_adders[2] + debug_time_t2 - debug_time_t1
  
end

function AddBullet( self,b )
  table.insert(bullets_from_enemies, b)
  --print("addBullet")
end

function PlayerHit()
  
  if Player.hitFlash <= 0 then
    player_hp = Player.takeHit() --TODO: can just access Player.hp directly tho, so no need to even return anything from that function
    if ( player_hp <= 0 ) then
      --TODO: GAME OVER
      gamestate = GAMESTATE_GAMEOVER 
    end
    screen_flash = screen_flash_time
  end
  
end



function Restart()
  --Player = {}
  enemies_alive = {}
  enemies_dying = {}
  bullets_from_enemies = {}
  bullets_from_player = {}
  
  Background.pos_x = 0
  asteroid_time_accumulator = 0
  enemy_ship_time_accumulator = 0
  DEBUG_STATS_ACCUMULATOR = 0
  
  --TODO: make player an object, so I can just make a new instance of it
  --Player.load()
  Player.hp = Player.hp_max
end

function love.quit()
  ProFi:stop()
  ProFi:writeReport()
end

