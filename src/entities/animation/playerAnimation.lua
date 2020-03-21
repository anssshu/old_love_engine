--[[

sprite sheet made with fuse layer sript of gimp
]]

local Anim = require("src.components.anim")

local a = Anim("assets/myboy.png",150,100,100,160)

a.anim = {
  run_r = a.newAnimation(a.g('10-1',"5-1"), .015),
  run_l = a.newAnimation(a.g('1-10',"1-5"), .015):flipH(),

  idle_l = a.newAnimation(a.g(4,4), .2):flipH(),
  idle_r = a.newAnimation(a.g(4,4), .2),

  jump_l = a.newAnimation(a.g(1,1), .2):flipH(),
  jump_r = a.newAnimation(a.g(1,1), .2),


}
a.currentAnim = "run_r"
return a
--[[
local anim8 = require 'lib.anim8.anim8'

local Anim = function(filename,x,y,w,h)

    local obj ={}

    obj.image = love.graphics.newImage(filename)
    local g = anim8.newGrid(w, h, obj.image:getWidth(), obj.image:getHeight())
    obj.anim = {
      run_r = anim8.newAnimation(g('10-1',"5-1"), .015),
      run_l = anim8.newAnimation(g('1-10',"1-5"), .02):flipH(),

      idle_l = anim8.newAnimation(g(4,4), .2):flipH(),
      idle_r = anim8.newAnimation(g(4,4), .2),

      jump_l = anim8.newAnimation(g(1,1), .2):flipH(),
      jump_r = anim8.newAnimation(g(1,1), .2),


    }
    obj.currentAnim = "run_r"

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
]]
