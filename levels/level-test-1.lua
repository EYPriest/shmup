LevelTest1 = Class{ __includes = Level}

LevelTest1.waves = {}

function LevelTest1:init()
  
  --table.insert( terrains, Terrain( Vector(1200,0) ) )
  table.insert( terrains, LevelOneTerrain( Vector(1200,0) ) )
  
  --[[
  Background = {}
  Background.image = nil
  Background.image_copy = nil
  Background.pos_x = 0
  
  Background.image = love.graphics.newImage("res/parallax-space-backgound.png")
  Background.image_copy = love.graphics.newImage("res/parallax-space-backgound.png")
  --]]
  
  self.backgrounds = {}
  
  self.backgrounds[1] = {}
  self.backgrounds[1].image = love.graphics.newImage("res/parallax-space-backgound.png")
  --self.backgrounds[1].image_copy = love.graphics.newImage("res/parallax-space-backgound.png")
  self.backgrounds[1].pos_x = 0
  self.backgrounds[1].speed_x = 1
  self.backgrounds[1].scale = 1.5
  
end


function LevelTest1:update(dt)
  
  Level.update(self,dt)
  
  --[[
  --Move Backgrounds
  for i,b in ipairs( self.backgrounds ) do
    b.pos_x = b.pos_x - b.speed_x
    if ( b.pos_x < b.image:getWidth() * -1 * SCALE_X * b.scale ) then
      b.pos_x = 0
    end
  end
  --]]
  
  --Create Asteroids
  asteroid_time_accumulator = asteroid_time_accumulator + dt
  if ( asteroid_time_accumulator > asteroid_spawn_time ) then
    asteroid_time_accumulator = asteroid_time_accumulator - asteroid_spawn_time
    table.insert( enemies_alive, AsteroidBlue( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
    --table.insert( asteroids, AsteroidBlue( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
  end
  
  --Create Enemy Ships
  enemy_ship_time_accumulator = enemy_ship_time_accumulator + dt
  if ( enemy_ship_time_accumulator > enemy_ship_spawn_time ) then
    enemy_ship_time_accumulator = enemy_ship_time_accumulator - enemy_ship_spawn_time
    table.insert( enemies_alive, EnemyShip( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
  end
  
  --Create Spin Ships
  --[[
  spin_ship_time_accumulator = spin_ship_time_accumulator + dt
  if ( spin_ship_time_accumulator > spin_ship_spawn_time ) then
    spin_ship_time_accumulator = spin_ship_time_accumulator - spin_ship_spawn_time
    spin_ship_spawn_time = love.math.random(4) / 2 + 1
    table.insert( enemies_alive, SpinShip( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
  end
  --]]
  
  --Create Spin Ship Wave
  spin_ship_time_accumulator = spin_ship_time_accumulator + dt
  if ( spin_ship_time_accumulator > spin_ship_spawn_time ) then
    spin_ship_time_accumulator = spin_ship_time_accumulator - spin_ship_spawn_time
    table.insert( LevelTest1.waves, Wave(SpinShip,5) )
  end
  
  --[[
  for i,w in ipairs( LevelTest1.waves ) do
    w:update(dt)
    if ( w.size <= 0 ) then
      table.remove(LevelTest1.waves,i)
    end
  end
  --]]
  
end

function LevelTest1:draw()
  
  Level.draw(self)
  
  --[[
  scaleAgain = 4
  
  --love.graphics.draw(Background.image,Background.pos_x,-20,0,SCALE_X,SCALE_Y)
  --love.graphics.draw(Background.image,Background.pos_x + Background.image:getWidth() * SCALE_X ,-20,0,SCALE_X,SCALE_Y)
  love.graphics.draw(Background.image,Background.pos_x,0,0,SCALE_X * scaleAgain,SCALE_Y * scaleAgain)
  love.graphics.draw(Background.image,Background.pos_x + Background.image:getWidth() * SCALE_X * scaleAgain ,0,0,SCALE_X *scaleAgain,SCALE_Y * scaleAgain)
  --TODO: Remeber Why was that -20???
  --]]
  
  --[[
  for i,b in ipairs( self.backgrounds ) do
    love.graphics.draw(b.image,b.pos_x,0,0,SCALE_X * b.scale,SCALE_Y * b.scale)
    love.graphics.draw(b.image,b.pos_x + b.image:getWidth() * SCALE_X * b.scale,0,0,SCALE_X *b.scale,SCALE_Y * b.scale)
  end
  --]]
  
end
