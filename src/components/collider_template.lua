local ColSprite = require("src.components.collisionSprite")

local module= function(filename)
    local obj = ColSprite(filename)
    ---initilisation function
    function obj:new(filename)

        return self
    end
    function sprite:onCollisionStay(other)
        --print("stay in col")

    end
    function sprite:onCollisionEnter(other)
        --print("enter col snell")
    end
    function sprite:onCollisionExit(other)
        --print("exit col")
    end
    --update function
    function obj:update(dt)

    end
    return obj:new(filename)
end

return module
