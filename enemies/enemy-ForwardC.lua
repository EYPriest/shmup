
EnemyCForward = Class{ __includes = Enemy }

function EnemyCForward:init( pos )
  
  Enemy.init(self,pos)
  
  self.sprite = love.graphics.newImage("res/Enemy Ships/CForwardShip.png")
  self.scale = 1
  
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  
  self.collider = { self.pos.x,self.pos.y,
          self.width * SCALE * self.scale,
          self.height * SCALE * self.scale }
  
  self.hp = 8
  self.speed = 40 * SCALE
  
  self.shot_accumulator = 0
  self.shot_time = 120
  
end

function EnemyCForward:update(dt)
  
  Enemy.update(self, dt)
  
  self.shot_accumulator = self.shot_accumulator + 1
  if ( self.shot_accumulator == self.shot_time ) then
    AddBullet( BulletBigLaser(self))
    self.shot_accumulator = self.shot_accumulator - self.shot_time
  end
    
end

return EnemyCForward