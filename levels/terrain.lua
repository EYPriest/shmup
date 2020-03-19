
Terrain = Class{ __includes = Enemy }

function Terrain:init( pos )
  
  Enemy.init(self,pos)
  
  
  
end

function Terrain:update(dt)
  
  --Enemy:update(dt)
  self.pos.x = self.pos.x - dt * 60 * SCALE
  
end


function Terrain:hit()
  
  --Do Nothing
  
end

return Terrain