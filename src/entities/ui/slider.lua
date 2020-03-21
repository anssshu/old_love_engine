local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
local r,g,b = 100,100,200

local module = function(x,y,w,h,tx,ty)
      local b2 = {}
      function b2:new()
        self.class = "ui"
        self.w= w or 200
        self.h= h or 50
        self.name = "start"

        self.x= x or W/2-self.w/2
        self.y= y or H/2-self.h/2
        self.tx = tx or 0
        self.ty = ty or 0
        self.r = 100
        self.g = 140
        self.b = 100
        self.clicked = false

        -----pos of moving rectagle
        self.value = 0.5

        self.mx =self.x+self.value*self.w*.95
        self.my = self.y



        return self

      end

      function b2:draw()
        --love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setColor(55, 0, 0, 255)
        ---draw the fixed rectangle
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        ----draw the moving rectaangle
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle("fill", self.mx, self.my, self.w/20, self.h)

        love.graphics.setColor(255, 255, 255, 255)
      end

      function b2:update(dt)
        ---------------check mouse over rectangel----------------
        local x = love.mouse.getX()
        local y = love.mouse.getY()
        if x>self.x and x<self.x+self.w*0.95 and y>self.y and y<self.y+self.h  then
            ------mouse over rectaangle
            self.mx = x
        else
            ---mouse out of rectangle
        end
        -----calculate slider value
        self.value = (self.mx - self.x)/(0.93*self.w)
        self.value = math.floor(self.value*100)/100
        if self.value >1 then self.value = 1 end
        --print(self.value)
        self:onChange()
      --------------------check mouse clicked over rectagle------------------
              if love.mouse.isDown(1) then
                local x = love.mouse.getX()
                local y = love.mouse.getY()
                if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h and not self.clicked then
                    self:onClick()
                    self.clicked = true
                end
              end
      -----------------------------------------------------
            if not love.mouse.isDown(1) then
                self.clicked = false
            end

      end

      function b2:onClick()
          --print("clicked")
          --love.filesystem.write("f",tostring(self.value))--write volume setting to file
          --game.musicPlayer.volume = self.value
          --love.audio.setVolume(self.value)
          --world.scenes.mainScene:run(world)
      end
      -----------set volume of game-----------
      function b2:onChange()
        --love.audio.setVolume(self.value)
        --game.musicPlayer.volume = self.value
      end
      return b2:new()
end

return module
---------------------------
