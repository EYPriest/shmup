
EnemyShip = Class{ __includes = Enemy }

function EnemyShip:init( pos )
  
  Enemy.init(self,pos)
  
  --self.sprite = love.graphics.newImage("res/giga-wing-1-1.png")
  self.sprite = love.graphics.newImage("res/giga-wing-1-Left.png")
  
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  
  self.scale = 0.5
  --self.scale = 1
  self.hp = 8
  self.rotation = math.rad(270)
  
  self.shot_accumulator = 0
  self.shot_time = 60
  
  --self.speed = 50
  self.speed = 50 * SCALE_X
end

function EnemyShip:update(dt)
  Enemy.update(self, dt)
  
  self.shot_accumulator = self.shot_accumulator + 1
  if ( self.shot_accumulator >= self.shot_time ) then
    self.shot_accumulator = self.shot_accumulator - self.shot_time
    --AddBullet( BulletEnemy( self.pos ))
    --AddBullet( self, BulletEnemy( Vector(55,55) ))
    --AddBullet( self, BulletEnemy( Vector(self.pos.x, self.pos.y) ))
    --AddBullet( self, BulletEnemy( Vector(self.pos.x + self.sprite:getWidth()/2 * self.scale, self.pos.y + self.sprite:getHeight()/2 * self.scale)))
    AddBullet( self, BulletEnemy( Vector(self.pos.x + self.sprite:getWidth() /2 * self.scale * SCALE_X, self.pos.y + self.sprite:getHeight() / 2 * self.scale * SCALE_Y)))
  end
  
end
--[[
function EnemyShip:draw()
  Enemy.draw(self)
end

function EnemyShip:getColliders()
  return Enemy.getColliders(self)
end

function EnemyShip:hit()
  return Enemy.hit(self)
end
--]]
return EnemyShip