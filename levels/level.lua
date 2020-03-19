
Level = Class{}

function Level:init()
  
  
  
  
end

function Level:update(dt)
  
  --Move Backgrounds
  for i,b in ipairs( self.backgrounds ) do
    b.pos_x = b.pos_x - b.speed_x
    if ( b.pos_x < b.image:getWidth() * -1 * SCALE * b.scale ) then
      b.pos_x = 0
    end
  end
  
  --Move Foregrounds
  if ( self.foregrounds ~= nil ) then
    for i,b in ipairs( self.foregrounds ) do
      b.pos_x = b.pos_x - b.speed_x
      if ( b.pos_x < b.image:getWidth() * -1 * SCALE * b.scale ) then
        b.pos_x = 0
      end
    end
  end
  
  --self.foreground.pos_x = self.foreground.pos_x - self.foreground.speed_x
  
  --Update Waves
  for i,w in ipairs( self.waves ) do
    w:update(dt)
    if ( w.size <= 0 ) then
      table.remove(self.waves,i)
    end
  end
  
end

function Level:draw()
  
  --love.graphics.setColor(1,0.3,0.3,0.5)
  for i,b in ipairs( self.backgrounds ) do
    love.graphics.draw(b.image,b.pos_x,0,0,SCALE * b.scale,SCALE * b.scale)
    love.graphics.draw(b.image,b.pos_x + b.image:getWidth() * SCALE * b.scale ,0,0,SCALE *b.scale,SCALE * b.scale)
  end
  --love.graphics.setColor(1,1,1,1)
  
end

function Level:drawForeground()
  
  if ( self.foregrounds ~= nil ) then
    for i,b in ipairs( self.foregrounds ) do
      love.graphics.draw(b.image,b.pos_x,0,0,SCALE * b.scale,SCALE * b.scale)
      love.graphics.draw(b.image,b.pos_x + b.image:getWidth() * SCALE * b.scale ,0,0,SCALE *b.scale,SCALE * b.scale)
    end
  end
  
end

return Level