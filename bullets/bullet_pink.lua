
BulletPink = Class{ __includes = Bullet }

function BulletPink:init( center_point )
  
  self.sprite = love.graphics.newImage("res/Enemy Bullets/PinkShot.png")
  Bullet.init(self, center_point)
  
  --self.centerpoint = { self.pos.x + self.width/2, self.pos.y + self.height/2}
  
  local player_centerpoint = Player.getCenterPoint()
  --local my_centerpoint = self:getCenterPoint()
  --local my_centerpoint = { self.pos.x + self.width/2, self.pos.y + self.height/2}
  
  --local x_diff = my_centerpoint[1] - player_centerpoint.x
  --local y_diff = my_centerpoint[2] - player_centerpoint.y
  
  local x_diff = center_point.x - player_centerpoint.x
  local y_diff = center_point.y - player_centerpoint.y
  
  local theta = math.atan2( math.abs(y_diff), math.abs(x_diff) )
  
  local speed = 100 * SCALE * -1
  --local speed = 150 * SCALE * -1
  --local speed = 120 * SCALE * -1
  
  self.speed = {}
  self.speed.x = speed * math.cos(theta)
  self.speed.y = speed * math.sin(theta)
  
  if ( x_diff < 0 ) then
    self.speed.x = self.speed.x * -1
  end
  if ( y_diff < 0 ) then
    self.speed.y = self.speed.y * -1
  end
  
end
--[[
function BulletPink:update(dt)
  --self.pos.x = self.pos.x + self.speed * dt
  self.pos.x = self.pos.x + self.speed_x * dt
  self.pos.y = self.pos.y + self.speed_y * dt
  
  self.collider[1] = self.pos.x
  self.collider[2] = self.pos.y
end
--]]
--[[
function BulletPink:draw()
  --love.graphics.draw( self.sprite, self.pos.x, self.pos.y, )
  --love.graphics.draw( self.sprite, self.pos.x - self.width / 2, self.pos.y - self.height / 2, 0, self.scale*SCALE, self.scale*SCALE 
  love.graphics.draw( self.sprite, self.pos.x, self.pos.y, 0, self.scale*SCALE, self.scale*SCALE )
end
--]]
--[[
function BulletPink:getColliders()
  return self.collider
end
--]]
--[[
function BulletPink:getCenterPoint()
  --return { self.pos.x + self.width/2, self.pos.y + self.height/2}
  return self.centerpoint
end
--]]

return BulletPink