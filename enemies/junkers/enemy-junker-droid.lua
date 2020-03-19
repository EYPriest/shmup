
EnemyJunkerDroid = Class{ __includes = Enemy }

--EnemyJunkerDroid.sprite = love.graphics.newImage("res/Enemy Ships/Junker-Droid.png")
EnemyJunkerDroid.sprite = love.graphics.newImage("res/Enemy Ships/Junker-Droid3.png")
EnemyJunkerDroid.width = EnemyJunkerDroid.sprite:getWidth()
EnemyJunkerDroid.height = EnemyJunkerDroid.sprite:getHeight()

--[[
function EnemyJunkerDroid.load()
  EnemyJunkerDroid.sprite = love.graphics.newImage("res/Enemy Ships/Junker-Droid.png")
  EnemyJunkerDroid.width = EnemyJunkerDroid.sprite:getWidth()
  EnemyJunkerDroid.height = EnemyJunkerDroid.sprite:getHeight()
  print ( "loaded" )
end
--]]

function EnemyJunkerDroid:init( pos )
  
  Enemy.init(self,pos)
  
  --self.sprite = love.graphics.newImage("res/Enemy Ships/Junker-Droid.png")
  self.sprite = EnemyJunkerDroid.sprite
  
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  
  self.hp = 8
  
  --bounding box
  self.collider = { self.pos.x,self.pos.y,
          self.width * SCALE * self.scale,
          self.height * SCALE * self.scale }
  
  self.shot_accumulator = 0
  self.shot_time_final = 80
  
  self.speed = 30 * SCALE
end

function EnemyJunkerDroid:update(dt)
  Enemy.update(self, dt)
  
  self.shot_accumulator = self.shot_accumulator + 1
  if ( self.shot_accumulator == self.shot_time_final ) then
    local fire_point = Enemy.getCenterPoint(self)
    --AddBullet( BulletPink(Vector(fire_point.x, fire_point.y)))
    AddBullet( BulletLaserSmall(Vector(fire_point.x, fire_point.y)))
    self.shot_accumulator = self.shot_accumulator - self.shot_time_final
  end

end

return EnemyJunkerDroid