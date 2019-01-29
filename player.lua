
Player = {}
Player.x = 100
Player.y = 100
--Player.default_speed = 300
Player.speed_y = 0
Player.speed_boost = -280
--Player.default_acceleration = 40
--Player.current_acceleration = Player.default_acceleration
Player.gravity = 10
Player.max_speed = 180
--TODO: add vectors
Player.image = nil

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
end


function Player:keyreleased(key)
  if key == "space" then
    --Player.gravity = 10
    --Player.current_acceleration = Player.default_acceleration
    --Player.speed_y = Player.default_speed
  end
end

function Player.load()
  Player.image = love.graphics.newImage("res/SimpleShip1.png")
end

function Player.update(dt)
  
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
  if Player.y < 0 then
    Player.y = 0
  elseif Player.y > love.graphics.getHeight() - Player.image:getHeight() then
    Player.y = love.graphics.getHeight() - Player.image:getHeight()
  end
  
  
  Player.speed_y = Player.speed_y + Player.gravity
  if Player.speed_y > Player.max_speed then
    Player.speed_y = Player.max_speed
  end
  
  
end

function Player.draw()
  love.graphics.draw(Player.image, Player.x, Player.y)
end