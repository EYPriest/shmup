
Bullet = Class{}

lg = love.graphics

function Bullet:init( center_point )
  self.center_point = center_point
  
  self.scale = 1
  
  self.width = self.sprite:getWidth() * self.scale * SCALE
  self.height = self.sprite:getHeight() * self.scale * SCALE
  
  self.pos = { x = center_point.x - self.width/2, y = center_point.y - self.height/2 }
  
  self.collider = { self.pos.x,self.pos.y,self.width,self.height }
  
  self.speed = { x = 0, y = 0 }
  
  self.rotation_rad = 0
  
end

function Bullet:update(dt)
  
  --TODO: do i want to update center_point and then derive position?
  -- or some other way.
  -- it's likely that hitboxes will occasionally be 1 pixel off no matter what I do.
  
  self.center_point.x = self.center_point.x + self.speed.x * dt
  self.center_point.y = self.center_point.y + self.speed.y * dt
  
  self.pos.x = self.center_point.x - self.width/2
  self.pos.y = self.center_point.y - self.height/2
  
  --self.pos.x = self.pos.x + self.speed.x * dt
  --self.pos.y = self.pos.y + self.speed.y * dt
  
  self.collider[1] = self.pos.x
  self.collider[2] = self.pos.y
end

function Bullet:draw()
  --local rot_deg = 45
  --local rotation_rad = math.rad(self.rotation_deg)
  --lg.draw( self.sprite, self.pos.x, self.pos.y, 0, self.scale*SCALE, self.scale*SCALE )
  --lg.draw( self.sprite, self.pos.x, self.pos.y, self.rotation_rad, self.scale*SCALE, self.scale*SCALE )
  --lg.draw( self.sprite, self.pos.x, self.pos.y, self.rotation_rad, self.scale*SCALE, self.scale*SCALE,  self.pos.x - self.center_point.x, self.pos.y - self.center_point.y)
  --lg.draw( self.sprite, self.pos.x, self.pos.y, self.rotation_rad, self.scale*SCALE, self.scale*SCALE,  self.width / -2, self.height / -2)
  --lg.draw( self.sprite, self.pos.x, self.pos.y, self.rotation_rad, self.scale*SCALE, self.scale*SCALE,  0, 0)
  --lg.draw( self.sprite, self.pos.x, self.pos.y, self.rotation_rad, self.scale*SCALE, self.scale*SCALE,  self.width / 2, self.height / 2)
  --lg.draw( self.sprite, self.pos.x, self.pos.y, self.rotation_rad, self.scale*SCALE, self.scale*SCALE,  (self.width / 2) / SCALE, (self.height / 2) / SCALE)
  lg.draw( self.sprite, self.pos.x + (self.width / 2), self.pos.y + (self.height / 2), self.rotation_rad, self.scale*SCALE, self.scale*SCALE,  (self.width / 2) / SCALE, (self.height / 2) / SCALE)
  
  --love.graphics.setColor(1,0,0,0.2)
  --lg.circle("fill",self.center_point.x,self.center_point.y,self.width / 2)
  --love.graphics.setColor(1,1,1,1)
end

function Bullet:getColliders()
  return self.collider
end
--[[
function BulletPink:getCenterPoint()
  --return { self.pos.x + self.width/2, self.pos.y + self.height/2}
  return self.centerpoint
end
--]]