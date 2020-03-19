
ShotPointLaser = Class{}

function ShotPointLaser:init( target_enemy )
  
  --self.pos = pos
  self.target = target_enemy
  
  self.time_accumulator = 0
  self.time_alive = 0.05
  
  --[[
  local distance = nil
  local shortest_distance = nil
  local closest_enemy = nil
  for i,e in ipairs( enemies_alive ) do
    distance = PointDLaser:find_distance( pos.x, pos.y, e.pos.x, e.pos.y )
    if ( shortest_distance == nil ) then
      shortest_distance = distance
      self.closest_enemy = e
    elseif ( distance < shortest_distance ) then
      shortest_distance = distance
      self.closest_enemy = e
    end
  end
  
  --if ( shortest_distance < 
  self.target = closest_enemy.pos
  
  --self.sprite = love.graphics.newImage("res/Weapons/LaserBlue.png")
  --self.speed = 5
  --self.speed = 1.25 * SCALE_X
  --self.speed = 3 * SCALE_X
  --self.speed = 100 * SCALE * 4
  --self.scale = 1
  
  self.damage = 8
  
  --self.width = self.sprite:getWidth()
  --self.height = self.sprite:getHeight()
  

  self.collider = { self.pos.x,self.pos.y, 0, 0 }
  --]]

  
end

function ShotPointLaser:update(dt)
  
  self.time_accumulator = self.time_accumulator + dt
  if ( self.time_accumulator > self.time_alive ) then
    return 0 --Done
  else
    return 1 --Still around
  end

  
  --self.pos.x = self.pos.x + self.speed * dt
  
  --self.collider[1] = self.pos.x
end

function ShotPointLaser:draw()

  --love.graphics.line( self.pos.x, self.pos.y, self.target.x, self.target.y
  local player_centerpoint = Player.getCenterPoint()
  local target_centerpoint = self.target:getCenterPoint()
  
  love.graphics.setColor(1,0,0.7,1)
  love.graphics.scale(SCALE,SCALE)
  love.graphics.line( player_centerpoint.x / SCALE, player_centerpoint.y / SCALE,
    target_centerpoint.x / SCALE, target_centerpoint.y / SCALE )
  
  --[[
  love.graphics.line( player_centerpoint.x+1, player_centerpoint.y,
    target_centerpoint.x+1, target_centerpoint.y )
  love.graphics.line( player_centerpoint.x, player_centerpoint.y+1,
    target_centerpoint.x, target_centerpoint.y+1 )
  love.graphics.line( player_centerpoint.x+1, player_centerpoint.y+1,
    target_centerpoint.x+1, target_centerpoint.y+1 )
    --]]
  
  love.graphics.setColor(1,1,1,1)
  
end


return ShotPointLaser