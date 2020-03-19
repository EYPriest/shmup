LevelForest2Test = Class{ __includes = Level}

function LevelForest2Test:init()
  
  self.waves = {}
  
  --table.insert( terrains, Terrain( Vector(1200,0) ) )
  --table.insert( terrains, LevelOneTerrain( Vector(1200,0) ) )
  
  
  
  self.backgrounds = {}
  
  self.foregrounds = {}
  
  --[[
  local forest2scale = 4
  
  self.backgrounds[1] = {}
  self.backgrounds[1].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2/forest bg.png")
  self.backgrounds[1].pos_x = 0
  self.backgrounds[1].speed_x = 1
  self.backgrounds[1].scale = forest2scale
  
  self.backgrounds[2] = {}
  self.backgrounds[2].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2/forest far.png")
  self.backgrounds[2].pos_x = 0
  self.backgrounds[2].speed_x = 2
  self.backgrounds[2].scale = forest2scale
  
  self.backgrounds[3] = {}
  self.backgrounds[3].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2/forest mid.png")
  self.backgrounds[3].pos_x = 0
  self.backgrounds[3].speed_x = 3
  self.backgrounds[3].scale = forest2scale
  
  self.backgrounds[4] = {}
  self.backgrounds[4].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2/forest close.png")
  self.backgrounds[4].pos_x = 0
  self.backgrounds[4].speed_x = 4
  self.backgrounds[4].scale = forest2scale
  --]]
  
  self.size = 2
  self:change_size()
  
  --print( self.backgrounds[1].pos_x )
  
end


function LevelForest2Test:update(dt)
  
  Level.update(self,dt)
  
  --TODO: have enemies spawn up to level height - ship height.
  --      problem is that i can't get ship height for random position before ship is created.
  --      Hardcode it? or pass in the range and have the ship randomize it's own pos?
  
  --Create Asteroids
  asteroid_time_accumulator = asteroid_time_accumulator + dt
  if ( asteroid_time_accumulator > asteroid_spawn_time ) then
    asteroid_time_accumulator = asteroid_time_accumulator - asteroid_spawn_time
    table.insert( enemies_alive, AsteroidBlue( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight() * 1) ) ) )
  end
  
  --Create Enemy Ships
  enemy_ship_time_accumulator = enemy_ship_time_accumulator + dt
  if ( enemy_ship_time_accumulator > enemy_ship_spawn_time ) then
    enemy_ship_time_accumulator = enemy_ship_time_accumulator - enemy_ship_spawn_time
    table.insert( enemies_alive, EnemyShip( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight() ) ) ) )
  end
  
  --Create C Ships
  c_ship_time_accumulator = c_ship_time_accumulator + dt
  if ( c_ship_time_accumulator > c_ship_spawn_time ) then
    c_ship_time_accumulator = c_ship_time_accumulator - c_ship_spawn_time
    table.insert( enemies_alive, EnemyCShip( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight() ) ) ) )
  end
  
  --Create Bird Ships
  bird_ship_time_accumulator = bird_ship_time_accumulator + dt
  if ( bird_ship_time_accumulator > bird_ship_spawn_time ) then
    bird_ship_time_accumulator = bird_ship_time_accumulator - bird_ship_spawn_time
    table.insert( enemies_alive, EnemyBird( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight() ) ) ) )
  end
  
  --Create Circle Spinner Ships
  circle_spinner_ship_time_accumulator = circle_spinner_ship_time_accumulator + dt
  if ( circle_spinner_ship_time_accumulator > circle_spinner_ship_spawn_time ) then
    circle_spinner_ship_time_accumulator = circle_spinner_ship_time_accumulator - circle_spinner_ship_spawn_time
    table.insert( enemies_alive, EnemyCircleSpinner( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight() ) ) ) )
  end
  
    --Create C-Forward Ships
  forward_c_time_accumulator = forward_c_time_accumulator + dt
  if ( forward_c_time_accumulator > forward_c_spawn_time ) then
    forward_c_time_accumulator = forward_c_time_accumulator - forward_c_spawn_time
    table.insert( enemies_alive, EnemyCForward( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight() ) ) ) )
  end
  
  --Create Green Triangle Ships
  green_triangle_time_accumulator = green_triangle_time_accumulator + dt
  if ( green_triangle_time_accumulator > green_triangle_spawn_time ) then
    green_triangle_time_accumulator = green_triangle_time_accumulator - green_triangle_spawn_time
    table.insert( enemies_alive, EnemyGreenTriangle( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight() ) ) ) )
  end
  
  --Create Spin Ship Wave
  spin_ship_time_accumulator = spin_ship_time_accumulator + dt
  if ( spin_ship_time_accumulator > spin_ship_spawn_time ) then
    spin_ship_time_accumulator = spin_ship_time_accumulator - spin_ship_spawn_time
    table.insert( self.waves, Wave(SpinShip,5) )
  end
  
end

function LevelForest2Test:draw()
  
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

function LevelForest2Test:change_size()
  
  self.size = self.size + 1
  if ( self.size > 5 ) then
    self.size = 1
  end
  
  if ( self.size == 1 ) then
    
    local forest2scale = 4
    
    self.backgrounds[1] = {}
    self.backgrounds[1].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2/forest bg.png")
    self.backgrounds[1].pos_x = 0
    self.backgrounds[1].speed_x = 1
    self.backgrounds[1].scale = forest2scale
    
    self.backgrounds[2] = {}
    self.backgrounds[2].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2/forest far.png")
    self.backgrounds[2].pos_x = 0
    self.backgrounds[2].speed_x = 2
    self.backgrounds[2].scale = forest2scale
    
    self.backgrounds[3] = {}
    self.backgrounds[3].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2/forest mid.png")
    self.backgrounds[3].pos_x = 0
    self.backgrounds[3].speed_x = 3
    self.backgrounds[3].scale = forest2scale
    
    self.backgrounds[4] = {}
    self.backgrounds[4].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2/forest close.png")
    self.backgrounds[4].pos_x = 0
    self.backgrounds[4].speed_x = 4
    self.backgrounds[4].scale = forest2scale
  elseif ( self.size == 2 ) then
    
    local forest2scale = 2
    
    self.backgrounds[1] = {}
    self.backgrounds[1].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2 2X/Forest 2 2X bg.png")
    self.backgrounds[1].pos_x = 0
    self.backgrounds[1].speed_x = 1
    self.backgrounds[1].scale = forest2scale
    
    self.backgrounds[2] = {}
    self.backgrounds[2].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2 2X/Forest 2 2X far.png")
    self.backgrounds[2].pos_x = 0
    self.backgrounds[2].speed_x = 2
    self.backgrounds[2].scale = forest2scale
    
    self.backgrounds[3] = {}
    self.backgrounds[3].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2 2X/Forest 2 2X mid.png")
    self.backgrounds[3].pos_x = 0
    self.backgrounds[3].speed_x = 3
    self.backgrounds[3].scale = forest2scale
    
    self.backgrounds[4] = {}
    self.backgrounds[4].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2 2X/Forest 2 2X close.png")
    self.backgrounds[4].pos_x = 0
    self.backgrounds[4].speed_x = 4
    self.backgrounds[4].scale = forest2scale
  elseif ( self.size == 3 ) then
    
    --local forest2scale = 1.3
    local forest2scale = 1
    --local forest2scale = 1.33
    
    self.backgrounds[1] = {}
    self.backgrounds[1].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2 3X/Forest 2 3X bg.png")
    self.backgrounds[1].pos_x = 0
    self.backgrounds[1].speed_x = 1
    self.backgrounds[1].scale = forest2scale
    
    self.backgrounds[2] = {}
    self.backgrounds[2].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2 3X/Forest 2 3X far.png")
    self.backgrounds[2].pos_x = 0
    self.backgrounds[2].speed_x = 2
    self.backgrounds[2].scale = forest2scale
    
    self.backgrounds[3] = {}
    self.backgrounds[3].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2 3X/Forest 2 3X mid.png")
    self.backgrounds[3].pos_x = 0
    self.backgrounds[3].speed_x = 3
    self.backgrounds[3].scale = forest2scale
    
    self.backgrounds[4] = {}
    self.backgrounds[4].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2 3X/Forest 2 3X close.png")
    self.backgrounds[4].pos_x = 0
    self.backgrounds[4].speed_x = 4
    self.backgrounds[4].scale = forest2scale
    
    --[[
    self.foregrounds[1] = {}
    self.foregrounds[1].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest 2 3X/Forest 2 3X close.png")
    self.foregrounds[1].pos_x = 0
    self.foregrounds[1].speed_x = 4
    self.foregrounds[1].scale = forest2scale
    --]]
    
  elseif ( self.size == 4 ) then
    local forest2scale = 1
    self.backgrounds[1] = {}
    self.backgrounds[1].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest2-3x-blue/Forest2-3x-blue bg.png")
    self.backgrounds[1].pos_x = 0
    self.backgrounds[1].speed_x = 1
    self.backgrounds[1].scale = forest2scale
    
    self.backgrounds[2] = {}
    self.backgrounds[2].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest2-3x-blue/Forest2-3x-blue far.png")
    self.backgrounds[2].pos_x = 0
    self.backgrounds[2].speed_x = 2
    self.backgrounds[2].scale = forest2scale
    
    self.backgrounds[3] = {}
    self.backgrounds[3].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest2-3x-blue/Forest2-3x-blue mid.png")
    self.backgrounds[3].pos_x = 0
    self.backgrounds[3].speed_x = 3
    self.backgrounds[3].scale = forest2scale
    
    self.backgrounds[4] = {}
    self.backgrounds[4].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest2-3x-blue/Forest2-3x-blue close.png")
    self.backgrounds[4].pos_x = 0
    self.backgrounds[4].speed_x = 4
    self.backgrounds[4].scale = forest2scale
    
  elseif ( self.size == 5 ) then
    local forest2scale = 1
    self.backgrounds[1] = {}
    self.backgrounds[1].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest2-3x-teal/Forest2-3x-teal bg.png")
    self.backgrounds[1].pos_x = 0
    self.backgrounds[1].speed_x = 1
    self.backgrounds[1].scale = forest2scale
    
    self.backgrounds[2] = {}
    self.backgrounds[2].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest2-3x-teal/Forest2-3x-teal far.png")
    self.backgrounds[2].pos_x = 0
    self.backgrounds[2].speed_x = 2
    self.backgrounds[2].scale = forest2scale
    
    self.backgrounds[3] = {}
    self.backgrounds[3].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest2-3x-teal/Forest2-3x-teal mid.png")
    self.backgrounds[3].pos_x = 0
    self.backgrounds[3].speed_x = 3
    self.backgrounds[3].scale = forest2scale
    
    self.backgrounds[4] = {}
    self.backgrounds[4].image = love.graphics.newImage("res/Parallax Backgrounds/Assets/Forest2-3x-teal/Forest2-3x-teal close.png")
    self.backgrounds[4].pos_x = 0
    self.backgrounds[4].speed_x = 4
    self.backgrounds[4].scale = forest2scale
  end
    
  
end
--[[
function LevelForest2Test:drawForeground()
  
  love.graphics.setColor(1,1,1,0.9)
  Level.drawForeground(self)
  love.graphics.setColor(1,1,1,1)

end
--]]