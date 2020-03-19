
BulletRed = Class{ __includes = Bullet }


function BulletRed:init( center_point, angle )
  --self.pos = pos
  self.sprite = love.graphics.newImage("res/Enemy Bullets/RedShot.png")
  Bullet.init(self, center_point)
  --[[
  self.scale = 1
  
  self.width = self.sprite:getWidth() * self.scale * SCALE
  self.height = self.sprite:getHeight() * self.scale * SCALE
  
  self.collider = { self.pos.x,self.pos.y,self.width,self.height }
  --]]
  
  local speed = 150
  speed = 50
  
  self.speed = {}
  self.speed.x = math.cos( angle ) * speed * SCALE
  self.speed.y = math.sin( angle ) * speed * SCALE * -1
  
end

--[[
function BulletRed:update(dt)
  self.pos.x = self.pos.x + self.speed.x * dt
  self.pos.y = self.pos.y + self.speed.y * dt
  
  self.collider[1] = self.pos.x
  self.collider[2] = self.pos.y
end
--]]


--[[
function BulletRed:draw()
  --love.graphics.draw( self.sprite, self.pos.x, self.pos.y, )
  love.graphics.draw( self.sprite, self.pos.x - self.width / 2, self.pos.y - self.height / 2, 0, self.scale*SCALE, self.scale*SCALE )
end
--]]
--[[
function BulletRed:getColliders()
  return self.collider
end
--]]
--[[
function BulletRed:getCenterPoint()
  return { self.pos.x + self.width/2, self.pos.y + self.height/2}
end
--]]