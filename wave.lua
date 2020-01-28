
Wave = Class{}

function Wave:init( enemy_type, n )
  --type? location? size? etc
  
  self.enemy_type = enemy_type --Enemy
  self.size = n
  
  --self.spawn_time = love.math.random(4) / 2 + 1
  self.spawn_time = 0.4
  self.current_spawn_time = self.spawn_time
  self.spawn_accumulator = 0
  
  --print ("enemy_type: " .. enemy_type.name )
  --print ("n: " .. n )
  
end

function Wave:update(dt)
  
  self.spawn_accumulator = self.spawn_accumulator + dt
  if ( self.spawn_accumulator > self.current_spawn_time ) then
    self.spawn_accumulator = self.spawn_accumulator - self.current_spawn_time
    self.current_spawn_time = self.spawn_time
    table.insert( enemies_alive, self.enemy_type( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
    self.size = self.size - 1
  end
  
end

return Wave