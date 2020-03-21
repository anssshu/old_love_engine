local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
local r,g,b = 100,100,200
local mf = love.graphics.newFont("assets/seasrn.ttf", 25);
local module = function(f1,f2,x,y,w,h)
      local b2 = {}
      function b2:new()
        self.class = "ui"
        self.im = {love.graphics.newImage(f1),love.graphics.newImage(f2)}
        self.i = 2
        self.sprite = self.im[self.i]
        self.w= w or 200
        self.h= h or 50
        self.name = "start"
        self.text = "button"
        self.x= x or W/2-self.w/2
        self.y= y or H/2-self.h/2
        self.sx = self.w/self.sprite:getWidth() or 1
        self.sy = self.h/self.sprite:getHeight() or 1
        self.r = 100
        self.g = 140
        self.b = 100
        self.clicked = false

        return self

      end

      function b2:draw()
        self.sprite = self.im[self.i]
        self.sx = self.w/self.sprite:getWidth()
        self.sy = self.h/self.sprite:getHeight()
        --love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setColor(self.r, self.g, self.b, 255)
        love.graphics.draw(self.im[self.i], self.x, self.y,0, self.sx, self.sy)
        --love.graphics.setColor(0, 0, 0, 255)
        --love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
        love.graphics.setColor(255, 255, 255, 255)


      end

      function b2:update(dt)

        ---------------check mouse over rectangel----------------
        local x = love.mouse.getX()
        local y = love.mouse.getY()
        if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h  then
            self.r,self.g,self.b = 100,100,100
        else
            self.r,self.g,self.b = 255,255,255
        end

      --------------------check mouse clicked over rectagle------------------
              if love.mouse.isDown(1) then
                local x = love.mouse.getX()
                local y = love.mouse.getY()
                if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h and not self.clicked then
                    self:onClick()
                    if self.i == 1 then self.i = 2 else self.i = 1 end
                    self.clicked = true
                end
              end
      -----------------------------------------------------
            if not love.mouse.isDown(1) then
                self.clicked = false
            end

      end

      function b2:onClick()
          print("clicked")
          --world.scenes.mainScene:run(world)
      end
      return b2:new()
end

return module
---------------------------
