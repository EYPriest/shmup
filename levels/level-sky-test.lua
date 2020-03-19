LevelSkyTest = Class{ __includes = Level}

--LevelSkyTest.waves = {}

function LevelSkyTest:init()
  
  self.waves = {}
  
  --table.insert( terrains, Terrain( Vector(1200,0) ) )
  --table.insert( terrains, LevelOneTerrain( Vector(1200,0) ) )
  
  self.backgrounds = {}
  
  self.backgrounds[1] = {}
  self.backgrounds[1].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Sky-3x/3x-sky bg.png")
  self.backgrounds[1].pos_x = 0
  self.backgrounds[1].speed_x = 1
  --self.backgrounds[1].scale = 3.3
  self.backgrounds[1].scale = 1
  
  self.backgrounds[2] = {}
  self.backgrounds[2].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Sky-3x/3x-clouds far.png")
  self.backgrounds[2].pos_x = 0
  self.backgrounds[2].speed_x = 2
  --self.backgrounds[2].scale = 3.3
  self.backgrounds[2].scale = 1
  
--[[
  self.backgrounds[3] = {}
  self.backgrounds[3].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Sky/clouds mid.png")
  self.backgrounds[3].pos_x = 0
  self.backgrounds[3].speed_x = 3
  self.backgrounds[3].scale = 3.3
  

  self.backgrounds[4] = {}
  self.backgrounds[4].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Sky/clouds close.png")
  self.backgrounds[4].pos_x = 0
  self.backgrounds[4].speed_x = 4
  self.backgrounds[4].scale = 3.3
--]]
  
  self.foregrounds = {}
  
  self.foregrounds[1] = {}
  self.foregrounds[1].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Sky-3x/3x-clouds mid.png")
  self.foregrounds[1].pos_x = 0
  self.foregrounds[1].speed_x = 3
  --self.foregrounds[1].scale = 3.3
  self.foregrounds[1].scale = 1

  self.foregrounds[2] = {}
  self.foregrounds[2].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Sky-3x/3x-clouds close.png")
  self.foregrounds[2].pos_x = 0
  self.foregrounds[2].speed_x = 4
  --self.foregrounds[2].scale = 3.3
  self.foregrounds[2].scale = 1
  
  --print( self.backgrounds[1].pos_x )
  
end


function LevelSkyTest:update(dt)
  
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
  end
  
  --Create Enemy Ships
  enemy_ship_time_accumulator = enemy_ship_time_accumulator + dt
  if ( enemy_ship_time_accumulator > enemy_ship_spawn_time ) then
    enemy_ship_time_accumulator = enemy_ship_time_accumulator - enemy_ship_spawn_time
    table.insert( enemies_alive, EnemyShip( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
  end
  
  --Create Spin Ship Wave
  spin_ship_time_accumulator = spin_ship_time_accumulator + dt
  if ( spin_ship_time_accumulator > spin_ship_spawn_time ) then
    spin_ship_time_accumulator = spin_ship_time_accumulator - spin_ship_spawn_time
    table.insert( self.waves, Wave(SpinShip,5) )
  end
  
  --[[
  for i,w in ipairs( LevelSkyTest.waves ) do
    w:update(dt)
    if ( w.size <= 0 ) then
      table.remove(LevelSkyTest.waves,i)
    end
  end
  --]]
  
end

function LevelSkyTest:draw()
  
  Level.draw(self)
  
  --TODO: make a level class
  
  --scaleAgain = 3.3
  
  --love.graphics.draw(Background.image,Background.pos_x,-20,0,SCALE_X,SCALE_Y)
  --love.graphics.draw(Background.image,Background.pos_x + Background.image:getWidth() * SCALE_X ,-20,0,SCALE_X,SCALE_Y)
  --love.graphics.draw(self.backgrounds[1].image,self.backgrounds[1].pos_x,0,0,SCALE_X * scaleAgain,SCALE_Y * scaleAgain)
  --love.graphics.draw(self.backgrounds[1].image,self.backgrounds[1].pos_x + self.backgrounds[1].image:getWidth() * SCALE_X * scaleAgain ,0,0,SCALE_X *scaleAgain,SCALE_Y * scaleAgain)
  --TODO: Remeber Why was that -20???
  
  
  --TODO: only draw 2nd image if needed. But this is probably not a bottleneck is it probably doesn't matter
  
  --[[
  for i,b in ipairs( self.backgrounds ) do
    love.graphics.draw(b.image,b.pos_x,0,0,SCALE_X * b.scale,SCALE_Y * b.scale)
    love.graphics.draw(b.image,b.pos_x + b.image:getWidth() * SCALE_X * b.scale ,0,0,SCALE_X *b.scale,SCALE_Y * b.scale)
  end
  --]]
  
end

function LevelSkyTest:drawForeground()
  
  love.graphics.setColor(1,1,1,0.6)
  Level.drawForeground(self)
  love.graphics.setColor(1,1,1,1)

end
