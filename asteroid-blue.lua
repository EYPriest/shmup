
AsteroidBlue = Class{}




function AsteroidBlue:init( pos )
  
  shaderWhiteTint = love.graphics.newShader[[
  extern float WhiteFactor = 0.2;

  vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
  {
      vec4 outputcolor = Texel(tex, texcoord) * vcolor;
      outputcolor.rgb += vec3(WhiteFactor);
      return outputcolor;
  }
  ]]

  shaderSolidWhiteTest = love.graphics.newShader[[

  vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_cords ) {
    vec4 pixel = Texel(texture, texture_coords ); // current pixel
    //return pixel * color;
    if ( pixel.x > 0 || pixel.y > 0 || pixel.z > 0 ) {
      return vec4(1.0,1.0,1.0,1.0);
    } else {
      return pixel;
    }
    //return vec4(1.0,0.0,0.0,1.0);
  }

  ]]


  
  self.sprite = love.graphics.newImage("res/Asteroid-Blue2.png")
  
  self.pos = pos
  
  self.scale = 2
  self.hitFlash = 0
  self.dyingCounter = 0
  
  self.hp = 10

  self.STATE_ALIVE = 1
  self.STATE_DYING = 2
  self.STATE_DEAD = 3
  self.state = self.STATE_ALIVE

end

--[[
function Asteroid:load()
  
end
--]]

function AsteroidBlue:update(dt)
  
  self.pos.x = self.pos.x - 25 * dt * scale_x
  
  print("state: "..self.state)
  if ( self.state == self.STATE_DYING ) then
    self.dyingCounter = self.dyingCounter - 1
    print("dyingCounter: "..self.dyingCounter)
  end
  
  
end

function AsteroidBlue:draw()
  
  --game version 11.2
  --phone version 0.10.2


  
  --love.graphics.draw(self.image,0,0,0,0.5,0.5)
  --love.graphics.setColorMask(true,false,true,false)
  if ( self.hitFlash > 0 and self.state == self.STATE_ALIVE ) then
    --original_color = love.graphics.getColor()
    --love.graphics.setColor(1,0,0,1)
    love.graphics.setShader(shaderWhiteTint)
    shaderWhiteTint:send("WhiteFactor", 0.2)
    love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,scale_x * self.scale,scale_y * self.scale )
    love.graphics.setShader()
    --love.graphics.setColorMask(true,true,true,true)
    --love.graphics.setColor(1,1,1,1)
    --love.graphics.setColor(original_color)
    self.hitFlash = self.hitFlash - 1
  
  elseif ( self.state == self.STATE_DYING ) then
    colour_ratio = 1 / 20 * self.dyingCounter 
    love.graphics.setColor(1,colour_ratio,colour_ratio,colour_ratio)
    love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,scale_x * self.scale,scale_y * self.scale )
    love.graphics.setColor(1,1,1,1)

  else

    --love.graphics.setShader(shaderWhiteTint)
    --shaderWhiteTint:send("WhiteFactor", 0.5)
    --shader:send("WhiteFactor", blinking and 1 or 0)

    love.graphics.draw( self.sprite, self.pos.x, self.pos.y,0,scale_x * self.scale,scale_y * self.scale )


    --love.graphics.setShader()
    
  end

end

function AsteroidBlue:getColliders()
  ret = {self.pos.x,self.pos.y,self.sprite:getWidth() * scale_x * self.scale,self.sprite:getHeight() * scale_y * self.scale}
  return ret
end

function AsteroidBlue:hit()
  self.hitFlash = 4
  self.hp = self.hp - 1
  if ( (self.hp <= 0) and (self.state == self.STATE_ALIVE) ) then --TODO only run this code if alive. remove from collisions entirely if dead
    self.state = self.STATE_DYING
    self.dyingCounter = 20
  end
  
  return self.hp
end


