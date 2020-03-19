
WeaponLaser = Class{}

function WeaponLaser:init()
  
  --[[
  Player.shot_time_accumulator = 0
Player.shot_time = 0.5
--Player.shot_time = 0.5
--Player.shot_time = 0.1
Player.shot_time = 0.1
--Player.shot_time = 0.01
Player.shot_time = 0.4


--]]
  
  self.shot_time_accumulator = 0
  self.shot_time = 0.4
  
end

function WeaponLaser:update(dt)
  
  self.shot_time_accumulator = self.shot_time_accumulator + dt
  if ( self.shot_time_accumulator > self.shot_time ) then
    self.shot_time_accumulator = self.shot_time_accumulator - self.shot_time
    table.insert( bullets_from_player, ShotLaser(
      Vector(Player.pos.x + Player.width - 3,
      Player.pos.y + Player.height * Player.scaleY / 2 - 4) ) )
  end
  
end

--[[
function WeaponLaser:draw()
  
end
--]]
