EnemyShip = Class{ __includes = Enemy }

function EnemyShip:init( pos )
  
  self.sprite = love.graphics.newImage("res/giga-wing-1-1.png")

  self.pos = pos
  
  self.scale = 0.5
  self.hp = 10
  
  print ( "init EnemyShip" )
  print ( "self.test : " .. self.test )

  --self.rotation = 1.5708
  --self.rotation = math.pi * 3 / 4
  self.rotation = math.rad(270)
  
  self.STATE_ALIVE = STATE_ALIVE
  self.STATE_DYING = STATE_DYING
  self.STATE_DEAD = STATE_DEAD
  self.state = self.STATE_ALIVE
  
end

function EnemyShip:update(dt)
  
  Enemy:update()
  
  self.pos.x = self.pos.x - 25 * dt * SCALE_X
  
end

function EnemyShip:draw()
  
  love.graphics.draw( self.sprite, self.pos.x, self.pos.y,self.rotation,SCALE_X * self.scale,SCALE_Y * self.scale )
  
end

function EnemyShip:getColliders()
  ret = {self.pos.x,self.pos.y,self.sprite:getWidth() * SCALE_X * self.scale,self.sprite:getHeight() * SCALE_Y * self.scale}
  return ret
end

function EnemyShip:hit()

  return self.hp
end


