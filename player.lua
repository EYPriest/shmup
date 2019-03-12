
Player = {}
Player.x = 100
Player.y = 100
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

Player.width = 18
Player.height = 4

Player.shot_time_accumulator = 0
Player.shot_time = 0.5

function Player.jump()
  Player.speed_y = Player.speed_boost
end


function Player:keypressed(key)
  if key == "space" then
    --Player.current_acceleration = -Player.default_acceleration
    
    --Player.speed_y = Player.speed_boost
    Player.jump()
    
    --Player.gravity = 0
    --Player.speed_y = -Player.default_speed * 2
  end
end

function Player:mousepressed(x,y,button,istouch)
  Player.jump()
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
end

function Player.load()
  --Player.image = love.graphics.newImage("res/SimpleShip1.png")
  
  --Player.image_ship_neutral
  
  Player.spritesheet = love.graphics.newImage("res/ShipSheet1.png")
  Player.sprites[1] = love.graphics.newQuad(0,0,18,4,Player.spritesheet:getDimensions())
  Player.sprites[2] = love.graphics.newQuad(0,6,18,8,Player.spritesheet:getDimensions())
  Player.sprites[3] = love.graphics.newQuad(0,16,18,8,Player.spritesheet:getDimensions())
  
  Player.active_sprite = Player.sprites[1]
end

function Player.shoot()
  
  table.insert( bullets, Bullet(
        Vector(Player.x + Player.width - 3,
        Player.y + Player.height / 2 - 4) ) )
  
end


function Player.update(dt)
  
  --[[
  Player.shot_time_accumulator = Player.shot_time_accumulator + dt
  if ( Player.shot_time_accumulator > Player.shot_time ) then
    Player.shot_time_accumulator = Player.shot_time_accumulator - Player.shot_time
    table.insert( bullets, Bullet(
        Vector(Player.x + Player.image:getWidth() - 3,
        Player.y + Player.image:getHeight() / 2 - 4) ) )
  end
  ]]--
  Player.shot_time_accumulator = Player.shot_time_accumulator + dt
  if ( Player.shot_time_accumulator > Player.shot_time ) then
    Player.shot_time_accumulator = Player.shot_time_accumulator - Player.shot_time
    Player.shoot()
  end
  
  --Player.speed_y = Player.speed_y + Player.current_acceleration
  
  --[[
  if Player.speed_y > Player.max_speed then
    Player.speed_y = Player.max_speed
  elseif Player.speed_y < -Player.max_speed then
    --Player.speed_y = -Player.max_speed
  end
  ]]--
  
  Player.y = Player.y + Player.speed_y * dt
  
  --Hit Top or Bottom
  --[[
  if Player.y < 0 then
    Player.y = 0
  elseif Player.y > love.graphics.getHeight() - Player.image:getHeight() then
    Player.y = love.graphics.getHeight() - Player.image:getHeight()
  end
  ]]--
  if Player.y < 0 then
    Player.y = 0
  elseif Player.y > love.graphics.getHeight() then
    Player.y = love.graphics.getHeight()
  end
  
  --Increase Speed
  Player.speed_y = Player.speed_y + Player.gravity
  --[[
  if Player.speed_y > Player.max_speed then
    Player.speed_y = Player.max_speed
  end
  ]]--
  if Player.speed_y < 0 then
    Player.active_sprite = Player.sprites[3]
  elseif Player.speed_y > 0 then
    Player.active_sprite = Player.sprites[2]
  else
    Player.active_sprite = Player.sprites[1]
  end
  

end

function Player.draw()
  love.graphics.draw(Player.spritesheet,Player.active_sprite , Player.x, Player.y,0,4,4)
end