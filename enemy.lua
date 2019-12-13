Enemy = Class{}

Enemy.test = 4557

function Enemy:init(pos)
  
  
  
end

function Enemy:update(dt)
  print ( "Enemy Updating")
  
  self.pos.x = self.pos.x - 25 * dt * SCALE_X
  
end

function Enemy:draw()
  
end

function Enemy:getColliders()
  
end

function Enemy:hit()
  
end
