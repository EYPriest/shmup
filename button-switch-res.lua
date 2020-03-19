
ButtonSwitchRes = {}

function ButtonSwitchRes:load()
  
  ButtonSwitchRes.pos = {}
  ButtonSwitchRes.pos.x = 200 * SCALE
  ButtonSwitchRes.pos.y = 20
  
  ButtonSwitchRes.width = 32
  ButtonSwitchRes.height = 32
  
  ButtonSwitchRes.sprite_up = love.graphics.newImage("res/PinkButtonUp.png")
  ButtonSwitchRes.sprite_down = love.graphics.newImage("res/PinkButtonDown.png")
  
  ButtonSwitchRes.current_sprite = ButtonSwitchRes.sprite_up
  
  ButtonSwitchRes.pressing = false
  
end

function ButtonSwitchRes.update(dt)

end

function ButtonSwitchRes.draw()
  
  love.graphics.draw( ButtonSwitchRes.current_sprite, ButtonSwitchRes.pos.x, ButtonSwitchRes.pos.y )
  
end

function ButtonSwitchRes:mousepressed(x,y,button,istouch)
  if ( button == 1 ) then
    if ( x > ButtonSwitchRes.pos.x and x < ButtonSwitchRes.pos.x + ButtonSwitchRes.width and
         y >  ButtonSwitchRes.pos.y and y < ButtonSwitchRes.pos.y + ButtonSwitchRes.height) then
      ButtonSwitchRes.pressing = true
       ButtonSwitchRes.current_sprite = ButtonSwitchRes.sprite_down
    else
      ButtonSwitchRes.pressing = false
    end
  end
end

function ButtonSwitchRes:mousereleased(x,y,button,istouch)
  
  --TODO: decide if i want the person to have to keep their finger in place while pressing
  --       or if they possibly can slide their finger to other buttons
  
  if ( button == 1 ) then
    --if ( x > ButtonSwitchRes.pos.x and y >  ButtonSwitchRes.pos.y ) then
    if ( x > ButtonSwitchRes.pos.x and x < ButtonSwitchRes.pos.x + ButtonSwitchRes.width and
    y >  ButtonSwitchRes.pos.y and y < ButtonSwitchRes.pos.y + ButtonSwitchRes.height) then
      --ButtonSwitchRes.pressing = true
      current_level:change_size()
    else
      --Do Nothing
    end
  end
  ButtonSwitchRes.current_sprite = ButtonSwitchRes.sprite_up
end