local sprite = require("src.components.sprite")

local module= function(world,filename)
    local obj = sprite(filename)
    local w= love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local x0 = obj.w - w
    local y0 = obj.h - h
    ---initilisation function
    function obj:new(filename)

        self.origin = {x=0,y=0}
        self.pos = {x=0,y=0-y0}


        --self.scale = 0.4
        return self
    end

    --update function
    function obj:update(dt)
      local p,q = world.camera:getPosition()
      if self.w > p+w/2 then self.pos.x =  - p+w/2 end
      if q-h/2 > -y0 then self.pos.y =  -q+h/2-y0 end
    end

    function obj:draw()

        love.graphics.setColor(255, 255, 255, 255)

            love.graphics.draw(
                  self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
                  self.scale*self.scaleX,self.scale*self.scaleY,
                  self.sprite:getWidth()* self.origin.x,
                  self.sprite:getHeight()*self.origin.y
                )


        love.graphics.setColor(255, 255, 255, 255)
    end

    return obj:new(filename)

end---end of module

return module
