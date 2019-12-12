
Bullet = Class{}


function Bullet:init( pos )
  self.pos = pos
  self.sprite = love.graphics.newImage("res/fbBulletWhite2.png")
  --self.speed = 5
  --self.speed = 1.25 * scale_x
  self.speed = 3 * scale_x
  self.scale = 0.4
end

function Bullet:update(dt)
  self.pos.x = self.pos.x + self.speed
end

function Bullet:draw()
  --love.graphics.draw( self.sprite, self.pos.x, self.pos.y, )
  love.graphics.draw( self.sprite, self.pos.x, self.pos.y, 0, self.scale*scale_x, self.scale*scale_y )
  --print 'aaaa'
end

function Bullet:getColliders()
  ret = {self.pos.x,self.pos.y,self.sprite:getWidth(),self.sprite:getHeight()}
  return ret
end