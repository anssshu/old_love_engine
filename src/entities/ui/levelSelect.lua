
local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
local r,g,b = 100,100,200


--create an empty object
local scroller = {
  x=100,
  y=50,
  w=0.8*W,
  h=0.8*H,

  scrollSpeed = 20,

  items = {},
  selectedItem = {
    level=1,
    path = "src.scenes.level0",
  }

}



-----------------------

-----draw it
-----------------------------
function scroller:draw()
  -----------------------------------------

------------------items draw------------------
  if next(self.items) ~= nil then

      for k,item in pairs(self.items) do  --draw all items
        --items inside the rectangle
        if item.x>self.x-item.w and item.x<self.x+self.w  and item.y>self.y and item.y<self.y+self.h  then---if items inside rectangle


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

  return scroller
end

return M
