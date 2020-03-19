Enemy = Class{}

local lg = love.graphics

function Enemy:init(pos)
  
    self.pos = pos
    
    self.sprite = nil
    self.sprites = {}
    self.active_quad = nil
    
    self.scale = 1
    self.hitFlash = 0
    self.hit_flash_time = 4
    self.dyingCounter = 0
    self.dyingCounterTimeLength = 30
    self.hp = nil
    self.rotation = 0
    self.speed = 25 * SCALE
    
    self.width = nil
    self.height = nil
    
    self.center_point = {}
    self.center_point.x = nil
    self.center_point.y = nil
    
    self.collider = {}
    
    self.STATE_ALIVE = STATE_ALIVE
    self.STATE_DYING = STATE_DYING
    self.STATE_DEAD = STATE_DEAD
    self.state = self.STATE_ALIVE
  
end

function Enemy:update(dt)
  
  --TODO: maybe multiply by SCALE here instead of subclass??
  
  --self.pos.x = self.pos.x - self.speed * dt * SCALE_X
  self.pos.x = self.pos.x - self.speed * dt
  
  self.collider[1] = self.pos.x
  self.collider[2] = self.pos.y

  if ( self.state == self.STATE_DYING ) then
    self.dyingCounter = self.dyingCounter - 1
    if ( self.dyingCounter <= 0 ) then
      self.state = self.STATE_DEAD
    end
  end

end

function Enemy:drawShip()
  
  if ( self.sprite ~= nil ) then
    lg.draw( self.sprite, self.pos.x, self.pos.y,0,SCALE * self.scale,SCALE * self.scale )
  elseif ( #self.sprites > 0 ) then
    lg.draw(self.spritesheet,self.active_quad , self.pos.x, self.pos.y,0,SCALE * self.scale,SCALE * self.scale)
  else
    --TODO: Something
    print( "ERROR: Enemy:drawShip(): no sprite to draw" )
  end
  
end


function Enemy:draw()
  
  if ( self.hitFlash > 0 and self.state == self.STATE_ALIVE ) then
    -- HitFlash
    lg.setShader(shaderWhiteTint)
    shaderWhiteTint:send("WhiteFactor", 0.5)
    --love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,SCALE_X *     self.scale,SCALE_Y * self.scale )
    Enemy.drawShip(self)
    lg.setShader()

    self.hitFlash = self.hitFlash - 1
    
  elseif ( self.state == self.STATE_DYING ) then
    -- Dying Red Tint
    local colour_ratio = 1 / self.dyingCounterTimeLength * self.dyingCounter 
    lg.setColor(1,colour_ratio,colour_ratio,colour_ratio)
    --love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,SCALE_X * self.scale,SCALE_Y * self.scale )
    Enemy.drawShip(self)
    lg.setColor(1,1,1,1)
    
  else
    -- Normal Draw
    Enemy.drawShip(self)
  end
  
end

function Enemy:getColliders()
  return self.collider
end

function Enemy:hit( damage )
  self.hitFlash = self.hit_flash_time
  self.hp = self.hp - damage
  if ( (self.hp <= 0) and (self.state == self.STATE_ALIVE) ) then --TODO only run this code if alive. remove from collisions entirely if dead
    --self.state = self.STATE_DYING
    --self.dyingCounter = self.dyingCounterTimeLength
    self:die()
  end
  return self.hp
end

--TODO: this is mainly just for testing collision with the player
--TODO: decide on if i want enemies to take damage or die or whatever
function Enemy:die()
  self.state = self.STATE_DYING
  self.dyingCounter = self.dyingCounterTimeLength
end

function Enemy:getCenterPoint()
  --TODO: calculate centerpoint in the update function maybe?? same as collider??
  self.center_point.x = self.pos.x + self.width/2 * SCALE * self.scale
  self.center_point.y = self.pos.y + self.height/2 * SCALE * self.scale
  return self.center_point
end
  
return Enemy
