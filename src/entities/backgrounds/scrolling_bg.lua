local sprite = require("src.components.sprite")

local module= function(filename)
    local obj = sprite(filename)
    local w= love.graphics.getWidth()
    local h = love.graphics.getHeight()
    ---initilisation function
    function obj:new(filename)
        self.origin = {x=0,y=0}
        self.pos={x=0,y=0}
        self.scaleX = w/self.w
        self.scaleY = h/self.h
        self.speed = 0
        self.Xmirror = false
        --self.scale = 0.4
        return self
    end

    --update function
    function obj:update(dt)
      if self.Xmirror then
          if self.speed<0 then
            self.pos.x = self.pos.x + self.speed
            if self.pos.x < -2*w then self.pos.x = 0 end
          end
          if self.speed>0 then
            self.pos.x = self.pos.x + self.speed
            if self.pos.x > 2*w then self.pos.x = 0 end
          end
          -------for unmirrored background scrolling
        else
          if self.speed<0 then
            self.pos.x = self.pos.x + self.speed
            if self.pos.x < -w then self.pos.x = 0 end
          end
          if self.speed>0 then
            self.pos.x = self.pos.x + self.speed
            if self.pos.x > w then self.pos.x = 0 end
          end
      end
    end

    function obj:draw()
        love.graphics.setColor(255, 255, 255, 255)

          if self.Xmirror then
                if self.speed<0 then
                  self:backwardScroll()
                end

                if self.speed>0 then
                  self:forwardScroll()
                end
          else

                if self.speed<0 then
                  self:bScroll()
                end

                if self.speed>0 then
                  self:fScroll()
                end


          end

          if self.speed == 0 then

            love.graphics.draw(
                  self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
                  self.scale*self.scaleX,self.scale*self.scaleY,
                  self.sprite:getWidth()* self.origin.x,
                  self.sprite:getHeight()*self.origin.y
                )
          end

        love.graphics.setColor(255, 255, 255, 255)
    end
    --for back scroll while xmirrored
    function obj:backwardScroll()

        love.graphics.draw(
              self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
              self.scale*self.scaleX,self.scale*self.scaleY,
              self.sprite:getWidth()* self.origin.x,
              self.sprite:getHeight()*self.origin.y
            )

        love.graphics.draw(
            self.sprite,self.pos.x+2*w,self.pos.y,math.rad(self.rot),
            -1*self.scaleX,self.scale*self.scaleY,
            self.sprite:getWidth()* self.origin.x,
            self.sprite:getHeight()*self.origin.y
          )

        love.graphics.draw(
          self.sprite,self.pos.x+2*w,self.pos.y,math.rad(self.rot),
          self.scale*self.scaleX,self.scale*self.scaleY,
          self.sprite:getWidth()* self.origin.x,
          self.sprite:getHeight()*self.origin.y
        )
    end
    --for fwd scroll while xmirrored
    function obj:forwardScroll()

        love.graphics.draw(
              self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
              self.scale*self.scaleX,self.scale*self.scaleY,
              self.sprite:getWidth()* self.origin.x,
              self.sprite:getHeight()*self.origin.y
            )

        love.graphics.draw(
            self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
            -1*self.scaleX,self.scale*self.scaleY,
            self.sprite:getWidth()* self.origin.x,
            self.sprite:getHeight()*self.origin.y
          )

        love.graphics.draw(
          self.sprite,self.pos.x-2*w,self.pos.y,math.rad(self.rot),
          self.scale*self.scaleX,self.scale*self.scaleY,
          self.sprite:getWidth()* self.origin.x,
          self.sprite:getHeight()*self.origin.y
        )
    end

    function obj:bScroll()
      love.graphics.draw(
            self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
            self.scale*self.scaleX,self.scale*self.scaleY,
            self.sprite:getWidth()* self.origin.x,
            self.sprite:getHeight()*self.origin.y
          )

      love.graphics.draw(
          self.sprite,self.pos.x+w,self.pos.y,math.rad(self.rot),
          1*self.scaleX,self.scale*self.scaleY,
          self.sprite:getWidth()* self.origin.x,
          self.sprite:getHeight()*self.origin.y
        )
    end

    function obj:fScroll()
      love.graphics.draw(
            self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
            self.scale*self.scaleX,self.scale*self.scaleY,
            self.sprite:getWidth()* self.origin.x,
            self.sprite:getHeight()*self.origin.y
          )

      love.graphics.draw(
          self.sprite,self.pos.x-w,self.pos.y,math.rad(self.rot),
          1*self.scaleX,self.scale*self.scaleY,
          self.sprite:getWidth()* self.origin.x,
          self.sprite:getHeight()*self.origin.y
        )
    end
    return obj:new(filename)
end

return module
