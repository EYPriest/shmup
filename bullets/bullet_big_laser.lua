
BulletBigLaser = Class{}

function BulletBigLaser:init( enemy_ship )
  self.enemy_ship = enemy_ship
  --self.top_right_pos = { enemy_ship.pos.x + 1, enemy_ship.pos.y - 4 }
  
  self.sprite = love.graphics.newImage("res/Enemy Bullets/BigLaser-Orange.png")
  self.scale = 1
  
  self.width = self.sprite:getWidth() * self.scale * SCALE
  self.height = self.sprite:getHeight() * self.scale * SCALE
  
  local top_right_pos = { self.enemy_ship.pos.x + 1 * SCALE, self.enemy_ship.pos.y + 4 * SCALE }
  local pos = { top_right_pos[1] - self.width, top_right_pos[2] }
  
  self.collider = { pos[1],pos[2],self.width,self.height }
  
  --TODO: this is a hack, because main removes bullets that move too far
  self.pos = { x = 50, y = 50}
  
  self.damage = 2
  
  self.life_span = 4
  self.life_left = self.life_span
  self.life_decay = 4

end

function BulletBigLaser:update(dt)
  
  --TODO: figure out if these local tables are getting garbage collected
  -- and slowing things down or if they just get lost from the stack change
  local top_right_pos = { self.enemy_ship.pos.x + 1 * SCALE, self.enemy_ship.pos.y + 4 * SCALE }
  local pos = { top_right_pos[1] - self.width, top_right_pos[2] }
  
  self.collider[1] = pos[1]
  self.collider[2] = pos[2]
  
  self.life_left = self.life_left - self.life_decay * dt
  if ( self.life_left < 1 ) then
    return STATE_DEAD
  end
end

function BulletBigLaser:draw()
  
  local top_right_pos = { self.enemy_ship.pos.x + 1 * SCALE, self.enemy_ship.pos.y + 4 * SCALE }
  local pos = { top_right_pos[1] - self.width, top_right_pos[2] }
  
  local opacity = self.life_left / self.life_span
  love.graphics.setColor(1,1,1,opacity)
  love.graphics.draw( self.sprite, pos[1], pos[2],0,self.scale*SCALE,self.scale*SCALE )
  love.graphics.setColor(1,1,1,1)
end

function BulletBigLaser:getColliders()
  return self.collider
end