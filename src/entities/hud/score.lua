local mainFont = love.graphics.newFont("assets/arizona.ttf", 35);

local w = love.graphics.getWidth()
local M=  {

  init = function(self,x,y)

    self.score = 0
    self.x= x or w -200
    self.y= y or 20
    self.level = 1
    return self
  end,

  update = function(self)

  end,

  draw = function(self)
    love.graphics.setColor(255,255,255,255)
    love.graphics.setFont(mainFont);
    love.graphics.print("Score:"..self.score,self.x,self.y)
    love.graphics.print("LEVEL:"..self.level,w/2-100,self.y)
    love.graphics.setColor(255,255,255,255)
  end

}

-------------module exporter
local f = function(filename,x,y)
  return M:init(filename,x,y)
end

return f
