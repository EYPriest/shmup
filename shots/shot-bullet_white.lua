
ShotBulletWhite = Class{}

function ShotBulletWhite:init( pos )
  self.pos = pos
  
  self.sprite = love.graphics.newImage("res/fbBulletWhite2.png")
  self.scale = 0.4
  
  self.width = self.sprite:getWidth() * self.scale * SCALE
  self.height = self.sprite:getHeight() * self.scale * SCALE
  
  self.collider = { self.pos.x,self.pos.y,self.width,self.height }
  
  self.speed = 200 * SCALE * 4
  self.damage = 2

end

function ShotBulletWhite:update(dt)
  self.pos.x = self.pos.x + self.speed * dt
  self.collider[1] = self.pos.x
  self.collider[2] = self.pos.y
end

function ShotBulletWhite:draw()
  love.graphics.draw( self.sprite, self.pos.x, self.pos.y, 0, self.scale*SCALE, self.scale*SCALE )
end

function ShotBulletWhite:getColliders()
  return self.collider
end

return ShotBulletWhite