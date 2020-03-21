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


        --self.scale = 0.4
        return self
    end

    --update function
    function obj:update(dt)

    end

    function obj:draw()

        love.graphics.setColor(55, 55, 155, 255)

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
