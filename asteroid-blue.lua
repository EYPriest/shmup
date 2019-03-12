
AsteroidBlue = Class{}


function AsteroidBlue:init( pos )
  
  self.sprite = love.graphics.newImage("res/Asteroid-Blue2.png")
  
  self.pos = pos

end

--[[
function Asteroid:load()
  
end
--]]

function AsteroidBlue:update(dt)
  
  self.pos.x = self.pos.x - 1
  --local current_quad = self.quads[self.current_quad]
  
  --if ( self.pos.x < 0 - 100 ) then
    --table.remove( asteroids, self )
  --end
  
  
  --print( "dt: " .. dt )
  
end

function AsteroidBlue:draw()
  --love.graphics.draw(Asteroid.image,0,0,0,0.5,0.5)
  --love.graphics.setColorMask(true,false,true,false)
  love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,4,4 )
  --love.graphics.setColorMask(true,true,true,true)
end
