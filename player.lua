
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
Player.active_quad = nil

--Player.scale = SCALE_GLOBAL
Player.scaleX = SCALE_X
Player.scaleY = SCALE_Y

Player.hitFlash = 0
Player.hit_flash_time = 36

Player.width = 18
Player.height = 8

Player.shot_time_accumulator = 0
Player.shot_time = 0.5
--Player.shot_time = 0.5
--Player.shot_time = 0.1
Player.shot_time = 0.1
Player.shot_time = 0.01

Player.shot_mode = 1 -- 1=automatic, 2=on_press

Player.accelerating = 0

Player.hp_max = 4
Player.hp = Player.hp_max


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
  
  --print( "Mouse Released")
  
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
  
  Player.active_quad = Player.sprites[1]
end

function Player.shoot()
  
  table.insert( bullets_from_player, Bullet(
        Vector(Player.x + Player.width - 3,
        Player.y + Player.height * Player.scaleY / 2 - 4) ) )
  
end


function Player.update(dt)
  

  if ( Player.shot_mode == 1 ) then -- if automatic
    Player.shot_time_accumulator = Player.shot_time_accumulator + dt
    if ( Player.shot_time_accumulator > Player.shot_time ) then
      Player.shot_time_accumulator = Player.shot_time_accumulator - Player.shot_time
      Player.shoot()
    end
  end

  Player.scroll_point_1 = love.graphics.getHeight() / 3
  Player.scroll_point_2 = love.graphics.getHeight() * 2 / 3
  
  --print(love.graphics.getHeight())
  --print("Player.scroll_point_1: " .. Player.scroll_point_1)
  --print("Player.scroll_point_2: " .. Player.scroll_point_2)
  
  
  
  --Update Position
  --TODO: remove magic numbers 
  --TODO: and actually figure out WHY the numbers are what they are lol.
  --level_height = 264 * SCALE_GLOBAL
  --level_height = 264
  --level_height = 470 - 264
  --level_height = (470 - 263) * SCALE_GLOBAL
  level_height = (470 - 263) * SCALE_Y
  
  --print("love.graphics.getHeight() - level_height) * -1: " .. (love.graphics.getHeight() - level_height) * -1)
  
  if ( Player.y <= Player.scroll_point_1 - camera_offset_y and Player.speed_y < 0
    or Player.y >= Player.scroll_point_2 - camera_offset_y and Player.speed_y > 0) then
    camera_offset_y = camera_offset_y - Player.speed_y * dt
    if ( camera_offset_y > 0 ) then
      camera_offset_y = 0
    elseif ( camera_offset_y < (love.graphics.getHeight() - level_height) ) then
    --elseif ( camera_offset_y < (love.graphics.getHeight() - level_height) * -1 ) then
    --camera_offset_y = ((love.graphics.getHeight() - level_height) * -1 )
    camera_offset_y = (love.graphics.getHeight() - level_height)
      --print( "camera_offset_y:" ..camera_offset_y )
    end
  end
  
  --[[
  if ( Player.y <= Player.scroll_point_1 and  camera_offset_y <= 0 
    or Player.y >= Player.scroll_point_2 and camera_offset_y >= (love.graphics.getHeight() - level_height) * -1
    ) then
    camera_offset_y = camera_offset_y - Player.speed_y * dt
    if ( camera_offset_y > 0 ) then
      camera_offset_y = 0
    elseif ( camera_offset_y < (love.graphics.getHeight() - level_height) * -1 ) then
      camera_offset_y = (love.graphics.getHeight() - level_height) * -1 )
    end
  end
  --]]
  
  Player.y = Player.y + Player.speed_y * dt
  
  --[[
  if ( Player.y <= Player.scroll_point_2 and Player.y >= Player.scroll_point_1 ) then
    camera_offset_y = camera_offset_y - Player.speed_y * dt
  end
  
  --camera_offset_y = camera_offset_y - Player.speed_y * dt
  if ( camera_offset_y >= 0 ) then
    camera_offset_y = 0
  elseif ( camera_offset_y <= love.graphics.getHeight() - level_height +254 ) then
    camera_offset_y = love.graphics.getHeight() - level_height +254
  end
  Player.y = Player.y + Player.speed_y * dt
  --]]
  
  --[[
  if ( Player.y <= scroll_pos and camera_offset_y >= -scroll_pos 
    or Player.y >= love.graphics.getHeight() - scroll_pos and camera_offset_y <= scroll_pos) then
    camera_offset_y = camera_offset_y + Player.speed_y * dt
  else
    Player.y = Player.y + Player.speed_y * dt
  end
  --]]
  
  --Player.y = Player.y + Player.speed_y * dt
  --camera_offset_y = camera_offset_y + Player.speed_y * dt
  --love.graphics.translate(0,Player.speed_y * dt * -1)
  
  
  
  --Hit Top or Bottom

  --TODO: if at the top or bottom, accelerate towards 0 speed,
          -- so that you don't Stick to the top or bottom
  --TODO:Get rid of those magic numbers
  
  --[[
  if Player.y < 0 then
    Player.y = 0
  elseif Player.y + Player.height * Player.scale > love.graphics.getHeight() + 154 then
    Player.y = love.graphics.getHeight() - Player.height * Player.scale + 154
  end
  --]]
  if Player.y < 0 then
    Player.y = 0
  elseif Player.y + Player.height * Player.scaleY > level_height then
    Player.y = level_height - Player.height * Player.scaleY
  end
  
  --[[
  if Player.speed_y > Player.max_speed then
    Player.speed_y = Player.max_speed
  end
  ]]--
  
  --Change Animation
  if Player.speed_y < 0 then
    Player.active_quad = Player.sprites[3]
  elseif Player.speed_y > 0 then
    Player.active_quad = Player.sprites[2]
  else
    Player.active_quad = Player.sprites[1]
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
  
    --print( Player.hitFlash )
  
  --print( math.fmod(Player.hitFlash,2) )
  
  if ( Player.hitFlash > 0 ) then
    if ( Player.hitFlash <= 4 or Player.hitFlash > 8 and Player.hitFlash <= 12
        or Player.hitFlash > 16 and Player.hitFlash <= 20
        or Player.hitFlash > 24 and Player.hitFlash <= 28
        or Player.hitFlash > 32) then
      
      --love.graphics.draw(Player.spritesheet,Player.active_quad , Player.x, Player.y,0,SCALE_X,SCALE_Y)
      
    else
      love.graphics.setShader(shaderWhiteTint)
      shaderWhiteTint:send("WhiteFactor", 0.5)
      love.graphics.draw(Player.spritesheet,Player.active_quad , Player.x, Player.y,0,SCALE_X,SCALE_Y)
      love.graphics.setShader()
    end
    

    Player.hitFlash = Player.hitFlash - 1
  else
    --love.graphics.draw(Player.spritesheet,Player.active_quad , Player.x, Player.y,0,SCALE_X,SCALE_Y)
    love.graphics.draw(Player.spritesheet,Player.active_quad , Player.x, Player.y,0,SCALE_X,SCALE_Y)
  end
  
  
  
end

function Player:getColliders()
  ret = {Player.x,Player.y,
          Player.width * SCALE_X,
          Player.height * SCALE_Y}
  return ret

end

function Player.takeHit()
  if Player.hitFlash <= 0 then
    Player.hitFlash = Player.hit_flash_time
    Player.hp = Player.hp - 1
  end  
  
  return Player.hp
end

return Player