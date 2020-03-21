
local cam = function ()
    camera = {}
    camera.target = {}
    camera.target.pos = {x=0,y=0}
    camera.pos = {x=0,y=0}
    camera.rotation=0
    camera.set = function()
        love.graphics.push()
        love.graphics.translate(-camera.pos.x+love.graphics.getWidth()/2-camera.target.center.x,
        -camera.pos.y+love.graphics.getHeight()/2-camera.target.center.y)
        love.graphics.rotate(camera.rotation)
    end
    camera.unset = function()
        love.graphics.pop()
    end
    camera.draw = function()
    end
    camera.update = function (dt)
         camera.pos =camera.target.pos
    end
    return camera
end

return cam