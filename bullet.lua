
Bullet = Class{}


function Bullet:init( pos )
  self.pos = pos
  self.sprite = love.graphics.newImage("res/fbBulletWhite2.png")
  --self.speed = 5
  --self.speed = 1.25 * SCALE_X
  self.speed = 3 * SCALE_X
  self.scale = 0.4
  
end

function Bullet:update(dt)
  self.pos.x = self.pos.x + self.speed
end

function Bullet:draw()
  --love.graphics.draw( self.sprite, self.pos.x, self.pos.y, )
  love.graphics.draw( self.sprite, self.pos.x, self.pos.y, 0, self.scale*SCALE_X, self.scale*SCALE_Y )
end

function Bullet:getColliders()
  ret = {self.pos.x,self.pos.y,self.sprite:getWidth(),self.sprite:getHeight()}
  return ret
end