
EnemyBird = Class{ __includes = Enemy }

function EnemyBird:init( pos )
  
  Enemy.init(self,pos)
  
  --self.sprite = love.graphics.newImage("res/giga-wing-1-1.png")
  self.sprite = love.graphics.newImage("res/Enemy Ships/Hydorah-Bird-Red.png")
  
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  
  --self.scale = 0.5
  self.scale = 1
  --self.hp = 8
  self.hp = 16
  --self.hp = 30
  -- self.rotation = math.rad(270)
  
  self.collider = { self.pos.x,self.pos.y,
          self.width * SCALE * self.scale,
          self.height * SCALE * self.scale }
  
  self.shot_accumulator = 0
  --self.shot_time_final = 80
  self.shot_time_final = 140
  
  --self.speed = 50
  --self.speed = 80 * SCALE
  --self.speed = 30 * SCALE
  self.speed = 10 * SCALE
end

function EnemyBird:update(dt)
  Enemy.update(self, dt)
  
  self.shot_accumulator = self.shot_accumulator + 1
  if ( self.shot_accumulator == self.shot_time_final ) then
    --AddBullet( self, BulletRed(Vector(self.pos.x + self.sprite:getWidth() /2 * self.scale * SCALE, self.pos.y + self.sprite:getHeight() / 2 * self.scale * SCALE)))
    local pos = Vector(self.pos.x + self.sprite:getWidth() /2 * self.scale * SCALE, self.pos.y + self.sprite:getHeight() / 2 * self.scale * SCALE)
    AddBullet( BulletRed( Vector(pos.x,pos.y), 5 * math.pi / 6 ))
    AddBullet( BulletRed( Vector(pos.x,pos.y), 11 * math.pi / 12 ))
    AddBullet( BulletRed( Vector(pos.x,pos.y), math.pi ))
    AddBullet( BulletRed( Vector(pos.x,pos.y), 13 * math.pi / 12 ))
    AddBullet( BulletRed( Vector(pos.x,pos.y), 7 * math.pi / 6 ))
  self.shot_accumulator = self.shot_accumulator - self.shot_time_final
  end
end

return EnemyBird