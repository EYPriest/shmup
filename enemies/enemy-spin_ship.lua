SpinShip = Class{ __includes = Enemy }

--TODO:Remove this
SpinShip.name = "SpinShip"

function SpinShip:init(pos)
  
  Enemy.init(self,pos)
  
  self.sprites = {}
  
  self.spritesheet = love.graphics.newImage("res/Enemy Ships/RedShip2-Sheet.png")
  local ssWidth = 21
  self.sprites[1] = love.graphics.newQuad(0 * ssWidth,0,21,24,self.spritesheet:getDimensions())
  self.sprites[2] = love.graphics.newQuad(1 * ssWidth,0,21,24,self.spritesheet:getDimensions())
  self.sprites[3] = love.graphics.newQuad(2 * ssWidth,0,21,24,self.spritesheet:getDimensions())
  self.sprites[4] = love.graphics.newQuad(3 * ssWidth,0,21,24,self.spritesheet:getDimensions())
  self.sprites[5] = love.graphics.newQuad(4 * ssWidth,0,21,24,self.spritesheet:getDimensions())
  self.sprites[6] = love.graphics.newQuad(5 * ssWidth,0,21,24,self.spritesheet:getDimensions())
  self.sprites[7] = love.graphics.newQuad(6 * ssWidth,0,21,24,self.spritesheet:getDimensions())
  self.sprites[8] = love.graphics.newQuad(7 * ssWidth,0,21,24,self.spritesheet:getDimensions())
  self.spriteChangeAccumulator = 0
  self.spriteChangeRate = 0.15
  self.active_quad_number = 1
  self.active_quad = self.sprites[self.active_quad_number]
 
  self.width = 21
  self.height = 24
  
  --self.scale = 0.8
  self.scale = 1
  
  self.collider = { self.pos.x,self.pos.y,
        self.width * SCALE * self.scale,
        self.height * SCALE * self.scale }
  
  
  self.hp = 8
  --self.rotation = math.rad(270)
  
  self.shot_accumulator = 0
  self.shot_time = 60
  
  self.movement_accumulator = 0
  
  --self.speed = 50
  self.speed = 50 * SCALE
end

function SpinShip:update(dt)
  Enemy.update(self, dt)
  
  --TODO: change vertical range
  self.movement_accumulator = self.movement_accumulator + dt * 5
  self.pos.y = self.pos.y + math.sin(self.movement_accumulator) * 2 * 4 * dt * 60
  
  self.spriteChangeAccumulator = self.spriteChangeAccumulator + dt
  if ( self.spriteChangeAccumulator >= self.spriteChangeRate ) then
    self.spriteChangeAccumulator = self.spriteChangeAccumulator - self.spriteChangeRate
    self.active_quad_number = self.active_quad_number + 1
    if ( self.active_quad_number > #self.sprites ) then
      self.active_quad_number = 1
    end
    self.active_quad = self.sprites[self.active_quad_number]
  end
  
end
--[[
function SpinShip:draw()
  --Enemy.draw(self)
  love.graphics.draw(self.spritesheet,self.active_quad , self.pos.x, self.pos.y,0,SCALE_X * self.scale,SCALE_Y * self.scale)
end

function SpinShip:getColliders()
  return Enemy.getColliders(self)
end

function SpinShip:hit()
  return Enemy.hit(self)
end
--]]
return SpinShip