
BulletEnemy = Class{ __includes = Bullet }

function BulletEnemy:init( center_point )
  
  self.sprite = love.graphics.newImage("res/Enemy Bullets/fbBulletYellow2.png")
  Bullet.init(self, center_point)
  
  --[[
  self.scale = 1
  
  self.width = self.sprite:getWidth() * self.scale * SCALE
  self.height = self.sprite:getHeight() * self.scale * SCALE
  
  self.collider = { self.pos.x,self.pos.y,
        self.width * SCALE * self.scale,
        self.height * SCALE * self.scale }
        --]]
  
  self.speed.x = 150 * SCALE * -1

end
--[[
function BulletEnemy:update(dt)
  self.pos.x = self.pos.x + self.speed.x * dt
  
  self.collider[1] = self.pos.x
end

function BulletEnemy:draw()
  --love.graphics.draw( self.sprite, self.pos.x, self.pos.y, )
  love.graphics.draw( self.sprite, self.pos.x - self.width / 2, self.pos.y - self.height / 2, 0, self.scale*SCALE, self.scale*SCALE )
end

function BulletEnemy:getColliders()
  return self.collider
end
--]]

return BulletEnemy