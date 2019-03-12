
Bullet = Class{}


function Bullet:init( pos )
  self.pos = pos
  self.sprite = love.graphics.newImage("res/fbBulletWhite2.png")
  self.speed = 5
end

function Bullet:update(dt)
  self.pos.x = self.pos.x + self.speed
end

function Bullet:draw()
  love.graphics.draw( self.sprite, self.pos.x, self.pos.y )
  --print 'aaaa'
end
