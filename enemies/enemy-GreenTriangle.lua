
EnemyGreenTriangle = Class{ __includes = Enemy }

function EnemyGreenTriangle:init( pos )
  
  Enemy.init(self,pos)
  
  --self.sprite = love.graphics.newImage("res/giga-wing-1-1.png")
  self.sprite = love.graphics.newImage("res/Enemy Ships/GreenTriangle3.png")
  
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  
  self.scale = 0.8
  self.hp = 8
  
  self.collider = { self.pos.x,self.pos.y,
          self.width * SCALE * self.scale,
          self.height * SCALE * self.scale }
  
  self.shot_accumulator = 0
  self.shot_time_final = 80
  
  self.speed = 30 * SCALE
end

--[[
function EnemyGreenTriangle:update(dt)
  Enemy.update(self, dt)
end
--]]

return EnemyGreenTriangle