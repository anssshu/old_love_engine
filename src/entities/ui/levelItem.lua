local item = {}

function item:new(filename,path,x,y,w,h)

  self.img = love.graphics.newImage(filename)
  self.x= x or 100
  self.y= y or 200

  self.red = 100
  self.green = 100
  self.blue = 100
  self.w= w or 200
  self.h= h or 200

  self.name = "item1"
  self.level = 1
  self.path= path or "src.scenes.level0"
  return self
end

function item:draw()
    love.graphics.setColor(self.red, self.green, self.blue, 255)
    love.graphics.rectangle("line",self.x,self.y, self.w, self.h)
    love.graphics.draw(self.img,self.x,self.y,0, self.w/self.img:getWidth(), self.h/self.img:getHeight())
    love.graphics.setColor(255,255, 255, 255)
end

function item:update(dt)
    if love.mouse.isDown(1) then
      local x = love.mouse.getX()
      local y = love.mouse.getY()
      ----100 extra shift for cam layer
      if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h and not self.clicked then
          self:onClick()
          self.clicked = true
      end
    end

    if not love.mouse.isDown(1) then
      self.clicked = false
    end
  end

  function item:onClick()
      --print("item",self.level)
      self.scroller.selectedItem = self
      for _,v in pairs(self.scroller.items) do
        v.red =100
        v.green = 100
        v.blue =  100
      end

        self.red=255
        self.green=255
        self.blue = 255
  end

  local M =function(filename,path,x,y,w,h,scroller)
    item.scroller = scroller
    item:new(filename,path,x,y,w,h)
    local obj = {}
    for k,v in pairs(item) do obj[k] = v end
    return obj
  end

  return M
