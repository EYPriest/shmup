
ShotLaser = Class{}

function ShotLaser:init( pos )
  self.pos = pos
  self.sprite = love.graphics.newImage("res/Weapons/LaserBlue.png")
  --self.speed = 5
  --self.speed = 1.25 * SCALE_X
  --self.speed = 3 * SCALE_X
  self.speed = 100 * SCALE * 4
  self.scale = 1
  
  self.damage = 8
  
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  
  self.collider = { self.pos.x,self.pos.y,
          self.width * SCALE * self.scale,
          self.height * SCALE * self.scale }
  
end

function ShotLaser:update(dt)
  self.pos.x = self.pos.x + self.speed * dt
  
  self.collider[1] = self.pos.x
end

function ShotLaser:draw()
  --love.graphics.draw( self.sprite, self.pos.x, self.pos.y, )
  love.graphics.draw( self.sprite, self.pos.x, self.pos.y, 0, self.scale*SCALE, self.scale*SCALE )
end

function ShotLaser:getColliders()
  --ret = {self.pos.x,self.pos.y,self.sprite:getWidth(),self.sprite:getHeight()}
  --return ret
  return self.collider
end

return ShotLaser