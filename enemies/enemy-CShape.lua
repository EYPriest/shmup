
EnemyCShip = Class{ __includes = Enemy }

function EnemyCShip:init( pos )
  
  Enemy.init(self,pos)
  
  self.sprite = love.graphics.newImage("res/Enemy Ships/Hydorah-C-Shape.png")
  self.scale = 1
  
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  
  self.collider = { self.pos.x,self.pos.y,
          self.width * SCALE * self.scale,
          self.height * SCALE * self.scale }
  
  self.hp = 8
  --self.speed = 50
  --self.speed = 80 * SCALE
  self.speed = 40 * SCALE
  
  self.shot_accumulator = 0
  local shot_time_diff = 8
  self.shot_time_final = 80
  self.shot_time_2 = self.shot_time_final - shot_time_diff
  self.shot_time_1 = self.shot_time_final - shot_time_diff * 2
  
  
end

function EnemyCShip:update(dt)
  Enemy.update(self, dt)
  
  local fire_point = Enemy.getCenterPoint(self)
  
  self.shot_accumulator = self.shot_accumulator + 1
  if ( self.shot_accumulator == self.shot_time_1 ) then
    AddBullet( BulletPink(Vector(fire_point.x, fire_point.y)))
  elseif ( self.shot_accumulator == self.shot_time_2 ) then
    AddBullet( BulletPink(Vector(fire_point.x, fire_point.y)))
  elseif ( self.shot_accumulator >= self.shot_time_final ) then
    AddBullet( BulletPink(Vector(fire_point.x, fire_point.y)))
    self.shot_accumulator = self.shot_accumulator - self.shot_time_final
  end
end

return EnemyCShip