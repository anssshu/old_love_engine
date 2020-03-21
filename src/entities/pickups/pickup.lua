local ColSprite = require("src.components.cSprite")
local world = require ("src.entities.world")
local module = function(filename,x,y)
    local p = x or 0
    local q = y or 0
    local obj = ColSprite(filename,p,q)
    obj.name = "pickup"
    obj.class="Pickup"

    function obj:new(filename)
        self.pos ={x=p,y=q}
        return self
    end
    function obj:onCollisionStay(other)
        --print("stay in col")

    end
    function obj:onCollisionEnter(other)
        --print("enter col snell")
        --play sound
        --inncrease score
        --delete object

        world:remove(self)
        print(self.name)
        if other.object.class == "Player" then
          world:remove(self)
          print(self.name)
        end

        --if other.object.class == "Pickup" then
        --  world:remove(self)
          --print(self.name)
        --end
    end
    function obj:onCollisionExit(other)
        --print("exit col")
    end
    --function obj:updateCollider()

    --end
    --update function
    function obj:update(dt)

    end
    return obj:new(filename)
end

return module
