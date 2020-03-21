--[[

sprite sheet made with fuse layer sript of gimp

]]

local anim8 = require 'lib.anim8.anim8'

local Anim = function(filename,x,y,w,h)

    local obj ={}

    obj.image = love.graphics.newImage(filename)
    obj.g = anim8.newGrid(w, h, obj.image:getWidth(), obj.image:getHeight())
    obj.newAnimation = anim8.newAnimation
    obj.anim = {
      default = obj.newAnimation(obj.g(1,1), .2)
    }
    obj.currentAnim = "default"

    obj.x = x or 100
    obj.y = y or 100
    function obj:play(name)
        self.currentAnim = name
    end
    function obj:update(dt)
        self.anim[self.currentAnim]:update(dt)
    end

    function obj:draw()
        self.anim[self.currentAnim]:draw(self.image, self.x, self.y,0,1,1)
    end

    return obj

end

return Anim
