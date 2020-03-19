
AsteroidBlue = Class{ __includes = Enemy }

function AsteroidBlue:init( pos )
  
  Enemy.init(self,pos)

  self.sprite = love.graphics.newImage("res/Enemy Ships/Asteroid-Blue2.png")
  
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  
  self.collider = { self.pos.x,self.pos.y,
          self.width * SCALE * self.scale,
          self.height * SCALE * self.scale }
  
  --self.scale = 1.5
  self.scale = 1
  self.hp = 8

end
--[[
function AsteroidBlue:update(dt)
  Enemy.update(self,dt)
end

function AsteroidBlue:draw()
  Enemy.draw(self)
end

function AsteroidBlue:getColliders()
  return Enemy.getColliders(self)
end

function AsteroidBlue:hit()
  return Enemy.hit(self)
end
--]]
return AsteroidBlue