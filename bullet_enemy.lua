
BulletEnemy = Class{}


function BulletEnemy:init( pos )
  self.pos = pos
  self.sprite = love.graphics.newImage("res/fbBulletYellow2.png")
  --self.speed = 5
  --self.speed = 1.25 * SCALE_X
  --self.speed = 1 * SCALE_X * -1
  self.speed = 75 * SCALE_X * -1
  self.scale = 1
  
  self.width = self.sprite:getWidth() * self.scale * SCALE_X
  self.height = self.sprite:getHeight() * self.scale * SCALE_Y
end

function BulletEnemy:update(dt)
  self.pos.x = self.pos.x + self.speed * dt
end

function BulletEnemy:draw()
  --love.graphics.draw( self.sprite, self.pos.x, self.pos.y, )
  love.graphics.draw( self.sprite, self.pos.x - self.width / 2, self.pos.y - self.height / 2, 0, self.scale*SCALE_X, self.scale*SCALE_Y )
end

function BulletEnemy:getColliders()
  ret = {self.pos.x,self.pos.y,self.sprite:getWidth(),self.sprite:getHeight()}
  return ret
end