
WeaponPointDefence = Class{}

function WeaponPointDefence:init()
  
  --self.pos = pos
  

  
  --self.sprite = love.graphics.newImage("res/Weapons/LaserBlue.png")
  --self.speed = 5
  --self.speed = 1.25 * SCALE_X
  --self.speed = 3 * SCALE_X
  --self.speed = 100 * SCALE * 4
  --self.scale = 1
  
  self.damage = 20
  
  --self.width = self.sprite:getWidth()
  --self.height = self.sprite:getHeight()
  
  self.current_laser = nil
  
  self.shot_time_accumulator = 0
  self.shot_time = 0.2

  
end

function WeaponPointDefence:update(dt)
  
  if ( self.current_laser ~= nil ) then
    local state = self.current_laser:update(dt)
    if ( state == 0 ) then
      self.current_laser = nil
      --TODO: is it realy best to keep creating lasers?? or maybe i can just reuse a laser.
      -- maybe i might want multiple lasers? is this class necessary?
      -- idk figure this out later
    end
  end
  
  --local pos = Vector(Player.pos.x + Player.width - 3, Player.pos.y + Player.height * Player.scaleY / 2 - 4)
  
  self.shot_time_accumulator = self.shot_time_accumulator + dt
  if ( self.shot_time_accumulator > self.shot_time ) then
    self.shot_time_accumulator = self.shot_time_accumulator - self.shot_time

    --See if an enemy is close. If so, shoot it.
    local player_position = Player.getCenterPoint()
    local current_distance = nil
    local shortest_distance = nil
    local closest_enemy = nil
    local closest_enemy_table_position = nil
    for i,e in ipairs( enemies_alive ) do
      local e_center_point = e:getCenterPoint()
      current_distance = WeaponPointDefence:find_distance( player_position.x, player_position.y, e_center_point.x, e_center_point.y )
      if ( shortest_distance == nil ) then
        shortest_distance = current_distance
        closest_enemy = e
        closest_enemy_table_position = i
      elseif ( current_distance < shortest_distance ) then
        shortest_distance = current_distance
        closest_enemy = e
        closest_enemy_table_position = i
      end
    end
    
    if ( shortest_distance ~= nil and shortest_distance < 100 * SCALE ) then
      --local target = closest_enemy:getCenterPoint()
      --local position = Player.getCenterPoint()
      self.current_laser = ShotPointLaser( closest_enemy )
      e_hp = closest_enemy:hit( self.damage )
      if ( e_hp <= 0 ) then
            --enemies need to do a death animation, so they can't completely die here
            table.insert(enemies_dying,closest_enemy)
            table.remove(enemies_alive,closest_enemy_table_position) 
          end
    end
  end
  

  
  --self.pos.x = self.pos.x + self.speed * dt
  
  --self.collider[1] = self.pos.x
end

function WeaponPointDefence:draw()
  --love.graphics.draw( self.sprite, self.pos.x, self.pos.y, )
  --love.graphics.draw( self.sprite, self.pos.x, self.pos.y, 0, self.scale*SCALE, self.scale*SCALE )
  
  --[[
  if ( self.closest_enemy ~= nil ) then
    love.graphics.line( self.pos.x, self.pos.y, self.closest_enemy.pos.x, self.closest_enemy.pos.y )
  end
  --]]
  
  --[[
  if ( self.closest_enemy ~= nil ) then
    love.graphics.line( self.pos.x, self.pos.y, self.closest_enemy.pos.x, self.closest_enemy.pos.y )
  end
  --]]
  if ( self.current_laser ~= nil ) then
    self.current_laser:draw()
  end
  
end


function WeaponPointDefence:getColliders()
  --ret = {self.pos.x,self.pos.y,self.sprite:getWidth(),self.sprite:getHeight()}
  --return ret
  return self.collider
end


function WeaponPointDefence:find_distance(xorigin, yorigin, xdestination, ydestination)
  
  if xorigin > xdestination then
    xdistance = xorigin - xdestination
  elseif xorigin < xdestination then
    xdistance = xdestination - xorigin
  end
  
  if yorigin > ydestination then
    ydistance = yorigin - ydestination
  elseif yorigin < ydestination then
    ydistance = ydestination - yorigin
  end

  distance = math.sqrt(xdistance ^ 2 + ydistance ^ 2)

  return distance
end

return WeaponPointDefence