  effect = love.graphics.newShader [[
  extern number time;
  vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
  {
    return vec4((1.0+sin(time))/2.0, abs(cos(time)), abs(sin(time)), 1.0);
  }
  ]]
  
  shaderWhiteTint = love.graphics.newShader[[
  extern float WhiteFactor;
  vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
  {
      vec4 outputcolor = Texel(tex, texcoord) * vcolor;
      outputcolor.rgb += vec3(WhiteFactor);
      return outputcolor;
  }
  ]]

--[[
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
  --]]