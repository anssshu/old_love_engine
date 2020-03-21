local C = require("lib.gamera")--import library
local H = love.graphics.getHeight()
local W = love.graphics.getWidth()

local cam = C.new(0,0,20000,600)
cam.name = "camera"
cam.shoot = {
    pos ={x=W/2,y=H/2}
}
function cam:update(dt)----this function will be updated by the update system
    local x,y
    x,y = self:getPosition()
    self:setPosition(lerp(x,self.shoot.pos.x,1),lerp(y,self.shoot.pos.y,1))
    --print('')
end
function lerp(a,b,r)
  return a*(1-r)+b*r
end
return cam
