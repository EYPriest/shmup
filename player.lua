
Player = {}
--Player.x = 100
--Player.y = 100
Player.x = 20 * SCALE_X
Player.y = 20 * SCALE_Y
--Player.default_speed = 300
Player.speed_y = 0
Player.speed_boost = -280
--Player.default_acceleration = 40
--Player.current_acceleration = Player.default_acceleration
Player.gravity = 10
--Player.max_speed = 180
--Player.max_speed = 220000
--TODO: add vectors
Player.image = nil

Player.sprites = {}
Player.spritesheet = nil
Player.active_sprite = nil

Player.scale = SCALE_GLOBAL

Player.width = 18
Player.height = 8

Player.shot_time_accumulator = 0
Player.shot_time = 0.5
--Player.shot_time = 0.5
Player.shot_time = 0.1

Player.shot_mode = 1 -- 1=automatic, 2=on_press

Player.accelerating = 0


function Player.jump()
  Player.speed_y = Player.speed_boost
  if ( Player.shot_mode == 2 ) then -- if on press
    Player.shoot()
  end
end


function Player:keypressed(key)
  if key == "space" then
    --Player.current_acceleration = -Player.default_acceleration
    
    --Player.speed_y = Player.speed_boost
    Player.jump()
    
    --Player.gravity = 0
    --Player.speed_y = -Player.default_speed * 2
  end
  
  if key == 'a' then
    Player.accelerating = 1
  end
  
end

function Player:mousepressed(x,y,button,istouch)
  --TODO: decide on controls
  if ( button == 1 ) then
    Player.accelerating = 1
  else
    Player.jump()
  end
  
  --[[
  table.insert( bullets, Bullet(
        Vector(Player.x + Player.image:getWidth() - 3,
        Player.y + Player.image:getHeight() / 2 - 4) ) )
        --]]
end

function Player:mousereleased(x,y,button,istouch)
  
  print( "Mouse Released")
  
  --TODO: decide on controls
  if ( button == 1 ) then
    Player.accelerating = 0
  else
    --nothing
  end
  
  --[[
  table.insert( bullets, Bullet(
        Vector(Player.x + Player.image:getWidth() - 3,
        Player.y + Player.image:getHeight() / 2 - 4) ) )
        --]]
end


function Player:keyreleased(key)
  if key == "space" then
    
    --Player.gravity = 10
    --Player.current_acceleration = Player.default_acceleration
    --Player.speed_y = Player.default_speed
  end
  
  if key == 'a' then
    Player.accelerating = 0
  end
  
end

function Player.load()
  
  Player.spritesheet = love.graphics.newImage("res/ShipSheet1.png")
  Player.sprites[1] = love.graphics.newQuad(0,0,18,4,Player.spritesheet:getDimensions())
  Player.sprites[2] = love.graphics.newQuad(0,6,18,8,Player.spritesheet:getDimensions())
  Player.sprites[3] = love.graphics.newQuad(0,16,18,8,Player.spritesheet:getDimensions())
  
  Player.active_sprite = Player.sprites[1]
end

function Player.shoot()
  
  table.insert( bullets, Bullet(
        Vector(Player.x + Player.width - 3,
        Player.y + Player.height * Player.scale / 2 - 4) ) )
  
end


function Player.update(dt)
  

  if ( Player.shot_mode == 1 ) then -- if automatic
    Player.shot_time_accumulator = Player.shot_time_accumulator + dt
    if ( Player.shot_time_accumulator > Player.shot_time ) then
      Player.shot_time_accumulator = Player.shot_time_accumulator - Player.shot_time
      Player.shoot()
    end
  end
  

  --Update Position
  Player.y = Player.y + Player.speed_y * dt
  
  --Hit Top or Bottom

  if Player.y < 0 then
    Player.y = 0
  elseif Player.y + Player.height * Player.scale > love.graphics.getHeight() then
    Player.y = love.graphics.getHeight() - Player.height * Player.scale
  end
  
  
  
  --[[
  if Player.speed_y > Player.max_speed then
    Player.speed_y = Player.max_speed
  end
  ]]--
  
  --Change Animation
  if Player.speed_y < 0 then
    Player.active_sprite = Player.sprites[3]
  elseif Player.speed_y > 0 then
    Player.active_sprite = Player.sprites[2]
  else
    Player.active_sprite = Player.sprites[1]
  end
  
  accel_speed = 10
  max_speed = 300
  
  accel_speed = 4
  max_speed = 150
  
  accel_speed = 8
  max_speed = 250
  
  accel_speed = 2 * SCALE_Y
  max_speed = 60 * SCALE_Y
  
  accel_speed = 6 * SCALE_Y
  max_speed = 80 * SCALE_Y
  
  --Increase Speed for next time
  if ( Player.accelerating == 1 ) then
    Player.speed_y = Player.speed_y - accel_speed
    if ( Player.speed_y < -max_speed ) then
      Player.speed_y = -max_speed
    end
  else
    Player.speed_y = Player.speed_y + accel_speed
    if ( Player.speed_y > max_speed ) then
      Player.speed_y = max_speed
    end
    
  end
  
  

end

function Player.draw()
  love.graphics.draw(Player.spritesheet,Player.active_sprite , Player.x, Player.y,0,SCALE_X,SCALE_Y)
end