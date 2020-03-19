
LevelOneTerrain = Class{ __includes = Terrain }

function LevelOneTerrain:init( pos )
  
  Terrain.init(self,pos)
  
    self.spritesheet = love.graphics.newImage("res/R-Type-Terrain.png")
  --local ssWidth = 2608
  
  --So far width isn't used
  -- and height i'm using for the screen scroll
  --TODO: determine height of level within Level Class, not in terrain
  
  --self.width = (2546 - 6) * SCALE_GLOBAL
  --self.height = (470 - 263) * SCALE_GLOBAL
  --TODO: Do I need these?
  self.width = (2546 - 6) * SCALE
  self.height = (470 - 263) * SCALE
  
  
  --470 -264
  self.sprites[1] = love.graphics.newQuad(7,264,self.width,self.height,self.spritesheet:getDimensions())
  
  self.active_quad_number = 1
  self.active_quad = self.sprites[self.active_quad_number]
  
  --self.scale = SCALE_GLOBAL
  
  --self.width = 2608
  --self.height = 200
  
  --[[
  self.collision_quads = {}
  self.collision_quads[1] = love.graphics.newQuad(7,264,2546-7+1,270-264+1)
  self.collision_quads[2] = love.graphics.newQuad(7,463,2546-7+1,470-463+1)
  self.collision_quads[3] = love.graphics.newQuad(127,264,198-127+1,342-264+1)
  self.collision_quads[4] = love.graphics.newQuad(127,391,198-127+1,470-391+1)
  self.collision_quads[5] = love.graphics.newQuad(343,264,390-343+1,287-264+1)
  self.collision_quads[6] = love.graphics.newQuad(391,431,438-391+1,470-431+1)
  self.collision_quads[7] = love.graphics.newQuad(567,264,758-567+1,286-264+1)
  self.collision_quads[8] = love.graphics.newQuad(567,447,758-567+1,470-447+1)
  --]]
  
  --[[
  self.collision_boxes = {}
  self.collision_boxes[1] = {7,264,2540,5}
  self.collision_boxes[2] = {7,463,2540,8}
  self.collision_boxes[3] = {127,264,198-127+1,342-264+1}
  self.collision_boxes[4] = {127,391,198-127+1,470-391+1}
  self.collision_boxes[5] = {343,264,390-343+1,287-264+1}
  self.collision_boxes[6] = {391,431,438-391+1,470-431+1}
  self.collision_boxes[7] = {567,264,758-567+1,286-264+1}
  self.collision_boxes[8] = {567,447,758-567+1,470-447+1}
  --]]
  local scaleX = SCALE
  local scaleY = SCALE
  
  self.collision_boxes = {}
  self.collision_boxes[1] = {0 * scaleX,0 * scaleY,2540 * scaleX,7 * scaleY}
  self.collision_boxes[2] = {0 * scaleX,199 * scaleY,2540 * scaleX,8 * scaleY}
  self.collision_boxes[3] = {120 * scaleX,0 * scaleY,72 * scaleX,79 * scaleY}
  self.collision_boxes[4] = {120 * scaleX,127 * scaleY,72 * scaleX,79 * scaleY}
  self.collision_boxes[5] = {336 * scaleX,0 * scaleY,48 * scaleX,23 * scaleY}
  self.collision_boxes[6] = {384 * scaleX,167 * scaleY,48 * scaleX,40 * scaleY}
  
  --TODO: make get colliders function that returns x,y as position added to these numbers
  
end