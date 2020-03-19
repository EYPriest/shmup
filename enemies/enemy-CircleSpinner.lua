
EnemyCircleSpinner = Class{ __includes = Enemy }

function EnemyCircleSpinner:init( pos )
  
  Enemy.init(self,pos)
  
  --self.sprite = love.graphics.newImage("res/giga-wing-1-1.png")
  self.sprite = love.graphics.newImage("res/Enemy Ships/Hydorah-CircleSpinner.png")
  
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  
  --self.scale = 0.5
  self.scale = 1
  self.hp = 8
  -- self.rotation = math.rad(270)
  
  self.collider = { self.pos.x,self.pos.y,
          self.width * SCALE * self.scale,
          self.height * SCALE * self.scale }
        
  
  self.centerpoint = { self.pos.x + self.width/2, self.pos.y + self.height/2}
  
  self.shot_accumulator = 0
  --local shot_time_diff = 8
  self.shot_time = 80
  --self.shot_time_2 = self.shot_time_final - shot_time_diff
  --self.shot_time_1 = self.shot_time_final - shot_time_diff * 2
  
  --self.speed = 50
  --self.speed = 80 * SCALE
  self.speed = 40 * SCALE * 2
end

function EnemyCircleSpinner:update(dt)
  Enemy.update(self, dt)
  
  -- First move forward
  -- Also move toward player
  --[[
  self.centerpoint = { self.pos.x + self.width/2, self.pos.y + self.height/2}
  
  local player_centerpoint = Player.getCenterPoint()
  local my_centerpoint = self:getCenterPoint()
  
  local x_diff = my_centerpoint[1] - player_centerpoint[1]
  local y_diff = my_centerpoint[2] - player_centerpoint[2]
  
  local theta = math.atan2( math.abs(y_diff), math.abs(x_diff) )
  
  --local speed = 150 * SCALE * -1
  
  local speed_x = self.speed * math.cos(theta)
  local speed_y = self.speed * math.sin(theta)
  
  if ( x_diff > 0 ) then
    speed_x = speed_x * -1
  end
  if ( y_diff > 0 ) then
    speed_y = speed_y * -1
  end
  --]]
  
  --self.pos.x = self.pos.x + speed_x * dt
  
  --self.centerpoint = self:getCenterPoint()
  
  --local player_location = Player.getCenterPoint()
  --local y_diff = (self.pos.y + self.height/2) - player_y_location.y
  
  local y_diff = (self.pos.y + self.height/2) - Player.getCenterPoint().y
  
  --print ( self.pos.x )
  local direction = 1
  if ( y_diff > 0 ) then
    direction = -1
  end
  self.pos.y = self.pos.y + self.speed * dt * direction / 4
  
  self.shot_accumulator = self.shot_accumulator + 1
  if ( self.shot_accumulator >= self.shot_time ) then
    self.shot_accumulator = self.shot_accumulator - self.shot_time
    AddBullet( BulletPink(Vector(self.pos.x + self.sprite:getWidth() /2 * self.scale * SCALE, self.pos.y + self.sprite:getHeight() / 2 * self.scale * SCALE)))
  end
end

--[[
function EnemyCircleSpinner:getCenterPoint()
  return { self.pos.x + self.width/2, self.pos.y + self.height/2}
end
--]]

return EnemyCircleSpinner