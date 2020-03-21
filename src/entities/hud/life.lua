local mainFont = love.graphics.newFont("assets/arizona.ttf", 35);


local M=  {

  init = function(self,filename,x,y)
    self.sprite = love.graphics.newImage(filename)
    self.life = 3
    self.x=x or 0
    self.y=y or 0
    self.scaleX = 1
    self.scaleY = 1
    self.scale = .2
    self.w = self.sprite:getWidth()*self.scale
    self.h = self.sprite:getHeight()*self.scale
    return self
  end,

  update = function(self)

  end,

  draw = function(self)
    love.graphics.draw(self.sprite,self.x,self.y,0,self.scale*self.scaleX,self.scale*self.scaleY)
    love.graphics.setColor(255,255,255,255)
    love.graphics.setFont(mainFont);
    love.graphics.print("X"..self.life,self.x+50,self.y)
    love.graphics.setColor(255,255,255,255)
  end

}

-------------module exporter
local f = function(filename,x,y)
  return M:init(filename,x,y)
end

return f
