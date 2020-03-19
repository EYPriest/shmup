
Asteroid = Class{}


function Asteroid:init( pos )
  self.pos = pos
  self.spritesheet = nil
  --self.quads = {}
  --self.current_quad = 1
  self.frames = {}
  self.active_frame = nil
  self.current_frame = 1
  
  self.animation_time_accumulator = 0
  self.animation_time = 0.4
  
  self.spritesheet = love.graphics.newImage("res/Enemy Ships/asteroids-sheet.png")
  --table.insert(self.quads, love.graphics.newQuad(766,603,954-766,783-603,self.spritesheet:getDimensions()))
  --table.insert(self.quads, love.graphics.newQuad(1080,607,1276-1080,770-607,self.spritesheet:getDimensions()))
  --table.insert(self.quads, love.graphics.newQuad(755,865,945-755,1031-865,self.spritesheet:getDimensions()))
  --table.insert(self.quads, love.graphics.newQuad(1072,855,1261-1072,1027-855,self.spritesheet:getDimensions()))
  
  self.frames[1] = love.graphics.newQuad(766,603,954-766,783-603,self.spritesheet:getDimensions())
  self.frames[2] = love.graphics.newQuad(1080,607,1276-1080,770-607,self.spritesheet:getDimensions())
  self.frames[3] = love.graphics.newQuad(755,865,945-755,1031-865,self.spritesheet:getDimensions())
  self.frames[4] = love.graphics.newQuad(1072,855,1261-1072,1027-855,self.spritesheet:getDimensions())

  self.active_frame = self.frames[self.current_frame]
  
end

--[[
function Asteroid:load()
  
end
--]]

function Asteroid:update(dt)
  
  self.pos.x = self.pos.x - 1
  
  self.animation_time_accumulator = self.animation_time_accumulator + dt
  if self.animation_time_accumulator > self.animation_time then
    self.animation_time_accumulator = self.animation_time_accumulator - self.animation_time
    self.current_frame = self.current_frame + 1
    if self.current_frame > #self.frames then
      self.current_frame = 1
    end
  end
  self.active_frame = self.frames[self.current_frame]
  
end

function Asteroid:draw()
  --love.graphics.draw(Asteroid.image,0,0,0,0.5,0.5)
  --love.graphics.draw(self.spritesheet,self.quads[self.current_quad],self.pos.x,self.pos.y,0,0.5,0.5)
  love.graphics.draw(self.spritesheet,self.active_frame,self.pos.x,self.pos.y,0,0.5,0.5)
end
