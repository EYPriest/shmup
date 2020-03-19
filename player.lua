
Player = {}

--TODO: clean up unused variables like speed_boost and gravity

--Player.x = 100
--Player.y = 100
Player.pos = {}
Player.pos.x = 20 * SCALE
Player.pos.y = 20 * SCALE

Player.width = 18
Player.height = 8

Player.center_point = {}
Player.center_point.x = Player.pos.x + Player.width/2
Player.center_point.y = Player.pos.y + Player.height/2

Player.collider = {Player.pos.x,Player.pos.y,
          Player.width * SCALE, Player.height * SCALE}

--Player.default_speed = 300
Player.speed_y = 0
Player.speed_boost = -280 --TODO: What is this number?

--Player.default_acceleration = 40
--Player.current_acceleration = Player.default_acceleration
Player.gravity = 10 --TODO: Also what is this number?
--Player.max_speed = 180
--Player.max_speed = 220000
--TODO: add vectors
Player.image = nil

Player.sprites = {}
Player.spritesheet = nil
Player.active_quad = nil

--Player.scale = SCALE_GLOBAL
Player.scaleX = SCALE
Player.scaleY = SCALE

Player.hitFlash = 0
Player.hit_flash_time = 36



--Player.centerpoint = { Player.x + Player.width/2, Player.y + Player.height/2}

--Player.level_height = (470 - 263) * SCALE_Y
--Player.level_height = 64 * 4 * SCALE
Player.level_height = 64 * 3 * SCALE


--camera_offset_y < (love.graphics.getHeight() - Player.level_height)
--camera_offset_y = Player.level_height / 2 + Player.height / 2

Player.weapon_primary = WeaponLaser()
Player.weapon_secondary = WeaponPointDefence()

--TODO DELETE
Player.shot_mode = 1 -- 1=automatic, 2=on_press

Player.accelerating = 0
Player.acceleration = 6 * SCALE
Player.max_speed = 80 * SCALE
Player.acceleration = 8 * SCALE
Player.max_speed = 80 * SCALE

Player.acceleration = 10 * SCALE
Player.max_speed = 100 * SCALE

Player.acceleration = 8.5 * SCALE * 2
--Player.max_speed = 85 * SCALE
Player.max_speed = 100 * SCALE

--Player.acceleration = 6 * SCALE
--Player.max_speed = 60 * SCALE

Player.hp_max = 6
Player.hp_max = 60
Player.hp = Player.hp_max

Player.SPRITE_STRAIGHT = 1
Player.SPRITE_DOWN = 2
Player.SPRITE_UP = 1


--[[
function Player.jump()
  Player.speed_y = Player.speed_boost
  if ( Player.shot_mode == 2 ) then -- if on press
    Player.shoot()
  end
end
--]]



function Player:keypressed(key)
  --[[
  if key == "space" then

    Player.jump()

  end
  --]]
  
  if key == 'a' then
    Player.accelerating = 1
  end
  
end

function Player:mousepressed(x,y,button,istouch)
  --TODO: decide on controls
  if ( button == 1 ) then
    Player.accelerating = 1
  else
    --Player.jump()
  end

end

function Player:mousereleased(x,y,button,istouch)
  
  --TODO: decide on controls
  if ( button == 1 ) then
    Player.accelerating = 0
  else
    --nothing
  end
  
end


function Player:keyreleased(key)
  if key == "space" then
    
  end
  
  if key == 'a' then
    Player.accelerating = 0
  end
  
end

function Player.load()
  
  Player.spritesheet = love.graphics.newImage("res/ShipSheet1.png")
  Player.sprites[Player.SPRITE_STRAIGHT] = love.graphics.newQuad(0,0,18,4,Player.spritesheet:getDimensions())
  Player.sprites[Player.SPRITE_DOWN] = love.graphics.newQuad(0,6,18,8,Player.spritesheet:getDimensions())
  Player.sprites[Player.SPRITE_UP] = love.graphics.newQuad(0,16,18,8,Player.spritesheet:getDimensions())
  
  Player.active_quad = Player.sprites[1]
end

function Player.shoot()
  
  --[[
  table.insert( bullets_from_player, ShotBulletWhite(
        Vector(Player.x + Player.width - 3,
        Player.y + Player.height * Player.scaleY / 2 - 4) ) )
        --]]
  table.insert( bullets_from_player, Laser(
        Vector(Player.pos.x + Player.width - 3,
        Player.pos.y + Player.height * Player.scaleY / 2 - 4) ) )
  
  table.insert( bullets_from_player, PointDLaser(
        Vector(Player.pos.x + Player.width - 3,
        Player.pos.y + Player.height * Player.scaleY / 2 - 4) ) )
  
end


function Player.update(dt)
  
  --Air resistance test
  --[[
  local speed_percent = math.abs( (Player.speed_y + 1) / Player.max_speed )
  local accel_modifier = (1 - speed_percent) * 2
  --print ( speed_percent )
  print ( accel_modifier )
  --]]
  --print ( Player.max_speed )
  --print ( Player.speed_y )
  
  --[[
  local accel_modifier = 1
  if ( math.abs(Player.speed_y) < 80 ) then
    accel_modifier = 2
  elseif ( math.abs(Player.speed_y) > 160 ) then
    accel_modifier = 0.5
  end
  
  local accel_modifier = 1
  --]]
  
  --local wind = Player.speed_y
  
  
  
  --THis work but it sucks lol
  --[[
  local wind_push = 0
  local speed_percent = 1
  if ( Player.speed_y == 0 ) then
    wind_push = 0
  else
    speed_percent = (Player.speed_y) / Player.max_speed
    wind_push = speed_percent * Player.acceleration * 2
  end
  
  --local speed_percent = math.abs( (Player.speed_y) / Player.max_speed )
  
  --Increase Speed based on input
  if ( Player.accelerating == 1 ) then
    --Player.speed_y = Player.speed_y - Player.acceleration * accel_modifier
    Player.speed_y = Player.speed_y - Player.acceleration - wind_push
    if ( Player.speed_y < -Player.max_speed ) then
      --Player.speed_y = -Player.max_speed
    end
  else
    --Player.speed_y = Player.speed_y + Player.acceleration * accel_modifier
    Player.speed_y = Player.speed_y + Player.acceleration - wind_push
    if ( Player.speed_y > Player.max_speed ) then
      --Player.speed_y = Player.max_speed
    end
  end
  --]]
  
  --Feels real nice
  --[[
  local accel_modifier = 0.7
  if ( math.abs(Player.speed_y) < 80 ) then
    accel_modifier = 0.3
  elseif ( math.abs(Player.speed_y) > 160 ) then
    accel_modifier = 1.3
  end
  --]]
  
  -- For testing
  local accel_modifier = 0.8
  if ( math.abs(Player.speed_y) < 120 ) then
    accel_modifier = 0.3
  elseif ( math.abs(Player.speed_y) > 200 ) then
    accel_modifier = 1.4
  end
  
  --local accel_modifier = 1
  
    --Increase Speed based on input
  if ( Player.accelerating == 1 ) then
    Player.speed_y = Player.speed_y - Player.acceleration * accel_modifier
    --Player.speed_y = Player.speed_y - Player.acceleration - wind_push
    if ( Player.speed_y < -Player.max_speed ) then
      Player.speed_y = -Player.max_speed
    end
  else
    Player.speed_y = Player.speed_y + Player.acceleration * accel_modifier
    --Player.speed_y = Player.speed_y + Player.acceleration - wind_push
    if ( Player.speed_y > Player.max_speed ) then
      Player.speed_y = Player.max_speed
    end
  end
  
  
  
  --Update Position
  
  --When between scroll points, move the player. past that move the camera, but only btw level bounds
  --When moving Camera and Move Player, both cancel each other out visually most of the time.
  
  
  --TODO: remove magic numbers 
    -- ask the stage for it's height
  
  
  --Player.scroll_point_1 = love.graphics.getHeight() / 3
  --Player.scroll_point_2 = love.graphics.getHeight() * 2 / 3
  
  Player.scroll_point_1 = love.graphics.getHeight() * 2/5
  Player.scroll_point_2 = love.graphics.getHeight() * 3/5
  
  if ( Player.pos.y <= Player.scroll_point_1 - camera_offset_y and Player.speed_y < 0
    or Player.pos.y >= Player.scroll_point_2 - camera_offset_y and Player.speed_y > 0) then
    camera_offset_y = camera_offset_y - Player.speed_y * dt
    if ( camera_offset_y > 0 ) then -- Camera can't scroll past edge.
      camera_offset_y = 0
    elseif ( camera_offset_y < (love.graphics.getHeight() - Player.level_height) ) then
    camera_offset_y = (love.graphics.getHeight() - Player.level_height)
    end
  end
  
  Player.pos.y = Player.pos.y + Player.speed_y * dt
  
  Player.collider[2] = Player.pos.y
  
  --Change Animation
  if Player.speed_y < 0 then
    Player.active_quad = Player.sprites[Player.SPRITE_UP]
  elseif Player.speed_y > 0 then
    Player.active_quad = Player.sprites[Player.SPRITE_DOWN]
  else
    Player.active_quad = Player.sprites[Player.SPRITE_STRAIGHT]
  end
  
  
  --Hit Top or Bottom

  --TODO: if at the top or bottom, accelerate towards 0 speed,
          -- so that you don't Stick to the top or bottom
          -- and maybe not have instant 0 speed, but really who cares
  
  if Player.pos.y < 0 then
    Player.pos.y = 0
    Player.speed_y = 0
  elseif Player.pos.y + Player.height * Player.scaleY > Player.level_height then
    Player.pos.y = Player.level_height - Player.height * Player.scaleY
    Player.speed_y = 0
  end
  
  
  -- Shoot
  --TODO: instead of shooting, just update the weapon
  --[[
  if ( Player.shot_mode == 1 ) then -- if automatic
    Player.shot_time_accumulator = Player.shot_time_accumulator + dt
    if ( Player.shot_time_accumulator > Player.shot_time ) then
      Player.shot_time_accumulator = Player.shot_time_accumulator - Player.shot_time
      Player.shoot()
    end
  end
  --]]
  
  
  Player.weapon_primary:update(dt)
  --Player.weapon_secondary:update(dt)

end

function Player.draw()
  
  if ( Player.hitFlash > 0 ) then
    if ( Player.hitFlash <= 4 or Player.hitFlash > 8 and Player.hitFlash <= 12
        or Player.hitFlash > 16 and Player.hitFlash <= 20
        or Player.hitFlash > 24 and Player.hitFlash <= 28
        or Player.hitFlash > 32) then
      
      --love.graphics.draw(Player.spritesheet,Player.active_quad , Player.x, Player.y,0,SCALE_X,SCALE_Y)
      
    else
      love.graphics.setShader(shaderWhiteTint)
      shaderWhiteTint:send("WhiteFactor", 0.5)
      love.graphics.draw(Player.spritesheet,Player.active_quad , Player.pos.x, Player.pos.y,0,SCALE,SCALE)
      love.graphics.setShader()
    end
    

    Player.hitFlash = Player.hitFlash - 1
  else
    --love.graphics.draw(Player.spritesheet,Player.active_quad , Player.x, Player.y,0,SCALE_X,SCALE_Y)
    --love.graphics.draw(Player.spritesheet,Player.active_quad , Player.pos.x, Player.pos.y,1,SCALE,SCALE,Player.width/2,Player.height/2)
    --love.graphics.draw(Player.spritesheet,Player.active_quad , Player.pos.x + Player.width/2, Player.pos.y + Player.height/2,0,SCALE,SCALE,Player.width/2,Player.height/2)
    --love.graphics.draw(Player.spritesheet,Player.active_quad , Player.pos.x + Player.width/2, Player.pos.y + Player.height/2,0,SCALE,SCALE)
    --love.graphics.draw(Player.spritesheet,Player.active_quad , Player.pos.x, Player.pos.y,0,SCALE,SCALE)
    
    
    
    love.graphics.draw(Player.spritesheet,Player.active_quad , Player.pos.x, Player.pos.y,0,SCALE,SCALE)
    --love.graphics.draw(Player.spritesheet,Player.active_quad , Player.pos.x + Player.width/2, Player.pos.y + Player.height/2,0,SCALE,SCALE)
  end
  
  
  --Player.weapon_primary:draw()
  Player.weapon_secondary:draw()
  
end

function Player:getColliders()
  --[[
  ret = {Player.pos.x,Player.pos.y,
          Player.width * SCALE,
          Player.height * SCALE}
  return ret
  --]]
  return self.collider

end

function Player.takeHit()
  if Player.hitFlash <= 0 then
    Player.hitFlash = Player.hit_flash_time
    Player.hp = Player.hp - 1
  end  
  
  return Player.hp
end

function Player.getCenterPoint()
  Player.center_point.x = Player.pos.x + Player.width/2 * SCALE
  Player.center_point.y = Player.pos.y + Player.height/2 * SCALE
  return Player.center_point
end

return Player