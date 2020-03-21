local anim8 = require 'lib.anim8.anim8'

local Anim = function(filename,x,y,w,h)

    local obj ={}

    obj.image = love.graphics.newImage(filename)
    local g = anim8.newGrid(w, h, obj.image:getWidth(), obj.image:getHeight())
    obj.anim = {
      run_r = anim8.newAnimation(g(1,'1-50',1,1), .015),
      run_l = anim8.newAnimation(g(1,'1-50'), .015):flipH(),

      idle_l = anim8.newAnimation(g(1,'14-14'), .2):flipH(),
      idle_r = anim8.newAnimation(g(1,'14-14'), .2),

      jump_l = anim8.newAnimation(g(1,1), .2):flipH(),
      jump_r = anim8.newAnimation(g(1,1), .2),


    }
    obj.currentAnim = "idle_r"

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
