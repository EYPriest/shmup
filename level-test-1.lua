LevelTest1 = {}

LevelTest1.waves = {}

function LevelTest1.load()
  
  --table.insert( terrains, Terrain( Vector(1200,0) ) )
  table.insert( terrains, LevelOneTerrain( Vector(1200,0) ) )
  
end


function LevelTest1.update(dt)
  --Create Asteroids
  asteroid_time_accumulator = asteroid_time_accumulator + dt
  if ( asteroid_time_accumulator > asteroid_spawn_time ) then
    asteroid_time_accumulator = asteroid_time_accumulator - asteroid_spawn_time
    table.insert( enemies_alive, AsteroidBlue( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
    --table.insert( asteroids, AsteroidBlue( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
  end
  
  --Create Enemy Ships
  enemy_ship_time_accumulator = enemy_ship_time_accumulator + dt
  if ( enemy_ship_time_accumulator > enemy_ship_spawn_time ) then
    enemy_ship_time_accumulator = enemy_ship_time_accumulator - enemy_ship_spawn_time
    table.insert( enemies_alive, EnemyShip( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
  end
  
  --Create Spin Ships
  --[[
  spin_ship_time_accumulator = spin_ship_time_accumulator + dt
  if ( spin_ship_time_accumulator > spin_ship_spawn_time ) then
    spin_ship_time_accumulator = spin_ship_time_accumulator - spin_ship_spawn_time
    spin_ship_spawn_time = love.math.random(4) / 2 + 1
    table.insert( enemies_alive, SpinShip( Vector(love.graphics.getWidth() + 1, love.math.random(love.graphics.getHeight()) ) ) )
  end
  --]]
  spin_ship_time_accumulator = spin_ship_time_accumulator + dt
  if ( spin_ship_time_accumulator > spin_ship_spawn_time ) then
    spin_ship_time_accumulator = spin_ship_time_accumulator - spin_ship_spawn_time
    table.insert( LevelTest1.waves, Wave(SpinShip,5) )
  end
  
  for i,w in ipairs( LevelTest1.waves ) do
    w:update(dt)
    if ( w.size <= 0 ) then
      table.remove(LevelTest1.waves,i)
    end
  end
  
end
