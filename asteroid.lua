
Asteroid = {}
Asteroid.pos = Vector(0,0)
Asteroid.spritesheet = nil
Asteroid.quads = {}
Asteroid.current_quad = 1
local time_accumulator = 0
local animation_time = 0.4

function Asteroid.load()
  Asteroid.spritesheet = love.graphics.newImage("res/asteroids-sheet.png")
  table.insert(Asteroid.quads, love.graphics.newQuad(
    766,603,954-766,783-603,Asteroid.spritesheet:getWidth(),Asteroid.spritesheet:getHeight()))
  table.insert(Asteroid.quads, love.graphics.newQuad(
    1080,607,1276-1080,770-607,Asteroid.spritesheet:getWidth(),Asteroid.spritesheet:getHeight()))
  table.insert(Asteroid.quads, love.graphics.newQuad(
    755,865,945-755,1031-865,Asteroid.spritesheet:getWidth(),Asteroid.spritesheet:getHeight()))
  table.insert(Asteroid.quads, love.graphics.newQuad(
    1072,855,1261-1072,1027-855,Asteroid.spritesheet:getWidth(),Asteroid.spritesheet:getHeight()))

  
  
end

function Asteroid.update(dt)
  --print( "dt: " .. dt )
  time_accumulator = time_accumulator + dt
  if time_accumulator > animation_time then
    time_accumulator = time_accumulator - animation_time
    Asteroid.current_quad = Asteroid.current_quad + 1
    if Asteroid.current_quad > #Asteroid.quads then
      Asteroid.current_quad = 1
    end
  end
  
end

function Asteroid.draw()
  --love.graphics.draw(Asteroid.image,0,0,0,0.5,0.5)
  love.graphics.draw(Asteroid.spritesheet,Asteroid.quads[Asteroid.current_quad], 
    Asteroid.pos.x,Asteroid.pos.y,0,0.5,0.5)
end
