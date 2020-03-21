local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
local r,g,b = 100,100,200
local mf = love.graphics.newFont("assets/seasrn.ttf", 25);
--create an empty object
local scroller = {
  x=0.1*W,
  y=50,
  w=0.8*W,
  h=0.8*H,

  scrollSpeed = 20,
  itemX =20,
  itemY =50,
  items = {},
  selectedItem = {
    level=1
  }

}
---------------------------------Button Code -------------------------------------------

local b2 = require("src.entities.ui.button")

local button = b2(scroller.x+scroller.w*.5-100,scroller.y+scroller.h*.8,200,50,30,10)
button.text="LOAD LEVEL"
function button:onClick()
  --print(scroller.selectedItem.level)

end
local home = b2(scroller.x+scroller.w*.5-100,scroller.y+scroller.h*.05,200,50,60,10)
home.text = "HOME"
function home:onClick()
  game:switchTo("startScreen")
end
-------------------------------end of button code----------------------------------------------
-----------------------------ITEM 1---------------------------------------------------
local item1 = {
  x=scroller.x+scroller.itemX,
  y=scroller.y+scroller.itemY+80,
  xoff = 0,
  yoff = 0,
  red = 100,
  green = 100,
  blue = 100,
  w=200,
  h=200,
  iw =200,
  ih=150,
  name = "item1",
  level = 1,
  path="src.scenes.level0",
  draw = function(self)
    love.graphics.setColor(self.red, self.green, self.blue, 200)
    love.graphics.rectangle("line",self.x+self.xoff,self.y+self.yoff, self.w, self.h)
    love.graphics.setColor(255,255, 255, 255)
  end,
  update = function(self,dt)
    if love.mouse.isDown(1) then
      local x = love.mouse.getX()
      local y = love.mouse.getY()
      if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h and not self.clicked then
          self:onClick()
          self.clicked = true
      end
    end

    if not love.mouse.isDown(1) then
      self.clicked = false
    end
  end,
  onClick = function(self)
      print("item",self.level)
      scroller.selectedItem = self
      for _,v in pairs(scroller.items) do
        v.red =100
        v.green = 100
        v.blue =  100
      end

        self.red=255
        self.green=255
        self.blue = 255
  end
}
-----------------------ITEM 2-------------------
-----------------------------ITEM 2---------------------------------------------------
local item2 = {
  img = love.graphics.newImage("assets/snell.png"),
  quad = love.graphics.newQuad(0, 0, 200, 200, 100, 100),
  x=scroller.x+scroller.itemX+250,
  y=scroller.y+scroller.itemY+80,
  xoff = 0,
  yoff = 0,
  red = 100,
  green = 100,
  blue = 100,
  w=200,
  h=200,
  iw =200,
  ih=150,
  name = "item2",
  level = 2,
  path="src.scenes.demo_scene",
  draw = function(self)
    love.graphics.setColor(self.red, self.green, self.blue, 200)
    love.graphics.rectangle("line",self.x+self.xoff,self.y+self.yoff, self.w, self.h)
    love.graphics.draw(self.img,self.quad,self.x+self.xoff,self.y+self.yoff,0)--, self.w/self.img:getWidth(), self.h/self.img:getHeight())
    love.graphics.setColor(255,255, 255, 255)
  end,
  update = function(self,dt)
    if love.mouse.isDown(1) then
      local x = love.mouse.getX()
      local y = love.mouse.getY()
      if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h and not self.clicked then
          self:onClick()
          self.clicked = true
      end
    end

    if not love.mouse.isDown(1) then
      self.clicked = false
    end
  end,
  onClick = function(self)
      print("item",self.level)
      scroller.selectedItem = self
      for _,v in pairs(scroller.items) do
        v.red =100
        v.green = 100
        v.blue =  100
      end

        self.red=255
  end
}
-------------------------------------------------------------------end of item--------------------------
table.insert(scroller.items,item1)
table.insert(scroller.items,item2)

-----------------------

-----draw it
-----------------------------
function scroller:draw()
  -----------------------------------------
  button:draw()
  home:draw()
------------------items draw------------------
  if next(self.items) ~= nil then

      for k,item in pairs(self.items) do  --draw all items
        --items inside the rectangle
        if item.x>self.x-item.iw and item.x<self.x+self.w  and item.y>self.y and item.y<self.y+self.h  then---if items inside rectangle

            item.xoff = 0
            item.w=item.iw
            --rigth edge condition
            if item.x+item.w > self.x+self.w  and item.x < self.w+self.x then
              item.w = self.x+self.w - item.x
            end
            --left edge condition
            if item.x  < self.x and item.x+item.iw > self.x then

                item.w = item.w + item.x - self.x
                item.xoff = self.x-item.x
                --print(item.x,item.w,self.x)
            end


            item:draw()
        end
      end

  end
  --------------------------------------
  love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

end
-----------------------------
function scroller:update(dt)
  ----------------------------------
  button:update(dt)
  home:update(dt)
  ----------------update items---------------
  if next(self.items) ~= nil then
      for _,item in pairs(self.items) do item:update(dt) end

  end
  -------------------------------
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    ---------hover----and exit -----------------
    if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h  then
        self:onHover()
        ------------------------------
        self:onScroll()

    else
        self:onExit()
    end
--------------------Click---------------------------
    if love.mouse.isDown(1) then
      local x = love.mouse.getX()
      local y = love.mouse.getY()
      if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h and not self.clicked then
          self:onClick()
          self.clicked = true
      end
    end

    if not love.mouse.isDown(1) then
      self.clicked = false
    end
----------------------------------------------------

end
function scroller:onHover()
    --print("hover")
end

function scroller:onClick()
      --print("click")
end
function scroller:onScroll()
      function love.wheelmoved(x, y)
        -----------------------------------
            if y > 0 then

              -------------wheel up--------
              self:onScrollUp()
            end
            if y < 0 then
              --------wheel down ------------

              self:onScrollDown()
            end

      ----------------------------------
    end
end
--------------------------------
function scroller:onScrollUp()
  --print("scrollup")
  for _,v in pairs(self.items)do
      v.x = v.x+self.scrollSpeed
  end
  --self.itemX = self.itemX + self.scrollSpeed
end
---------------------------------
function scroller:onScrollDown()

  for _,v in pairs(self.items)do
      v.x = v.x-self.scrollSpeed
  end
  --self.itemX = self.itemX - self.scrollSpeed
end
-------------------------------
function scroller:onExit()
  --print("exit")
end
----------------------------

----------------------------
local M =function()
  scroller.home = home
  scroller.load = button
  return scroller
end

return M
