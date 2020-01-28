Enemy = Class{}

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
    self.speed = 25 * SCALE_X
    
    self.width = nil
    self.height = nil
    
    self.STATE_ALIVE = STATE_ALIVE
    self.STATE_DYING = STATE_DYING
    self.STATE_DEAD = STATE_DEAD
    self.state = self.STATE_ALIVE
  
end

function Enemy:update(dt)
  
  --self.pos.x = self.pos.x - self.speed * dt * SCALE_X
  self.pos.x = self.pos.x - self.speed * dt

  if ( self.state == self.STATE_DYING ) then
    self.dyingCounter = self.dyingCounter - 1
    if ( self.dyingCounter <= 0 ) then
      self.state = self.STATE_DEAD
    end
  end

end

function Enemy:drawShip()
  
  if ( self.sprite ~= nil ) then
    love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,SCALE_X *     self.scale,SCALE_Y * self.scale )
  elseif ( #self.sprites > 0 ) then
    love.graphics.draw(self.spritesheet,self.active_quad , self.pos.x, self.pos.y,0,SCALE_X * self.scale,SCALE_Y * self.scale)
  else
    --TODO: Something
    print( "ERROR: Enemy:drawShip(): no sprite to draw" )
  end
  
end


function Enemy:draw()
  
  if ( self.hitFlash > 0 and self.state == self.STATE_ALIVE ) then
    -- HitFlash
    love.graphics.setShader(shaderWhiteTint)
    shaderWhiteTint:send("WhiteFactor", 0.5)
    --love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,SCALE_X *     self.scale,SCALE_Y * self.scale )
    Enemy.drawShip(self)
    love.graphics.setShader()

    self.hitFlash = self.hitFlash - 1
    
  elseif ( self.state == self.STATE_DYING ) then
    -- Dying Red Tint
    colour_ratio = 1 / self.dyingCounterTimeLength * self.dyingCounter 
    love.graphics.setColor(1,colour_ratio,colour_ratio,colour_ratio)
    --love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,SCALE_X * self.scale,SCALE_Y * self.scale )
    Enemy.drawShip(self)
    love.graphics.setColor(1,1,1,1)
    
  else
    -- Normal Draw
    --love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,SCALE_X * self.scale,SCALE_Y * self.scale )
    Enemy.drawShip(self)
  end
  
end

function Enemy:getColliders()
  ret = {self.pos.x,self.pos.y,
          self.width * SCALE_X * self.scale,
          self.height * SCALE_Y * self.scale}
  return ret
end

function Enemy:hit()
  self.hitFlash = self.hit_flash_time
  self.hp = self.hp - 1
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
  
return Enemy
