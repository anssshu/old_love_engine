local Sprite = require("src.components.pRectSprite")
local module= function(world,filename,x,y,type,w,h)

    local obj = Sprite(world.pWorld,filename,x,y,type,w,h)
    ---initilisation function

    function obj:new()
        self.name = "rect"
        self.body:setCollisionClass("Pickup")

        ---self.body:setPreSolve(function(me,other,contact)
            ---contact:setEnabled(false)
        --end)


        --world:addTo("camLayer",self)

        return self
    end



    function obj:update(dt)

      if self.body:enter("Player") then
          print(self.name)
          --world:remove(self)
          --local data = self.body:getEnterCollisionData('Player')

          self.body:setType("dynamic")
          self.body:setRestitution(.81)
          self.body:setMass(.5)
          self.body:applyLinearImpulse(300,-100)
            world.Timer:after(2,function()
              print("Timer is ticking")
                world:remove(self)
            end)

          --data.collider:setType("dynamic")
      end

    end
    return obj:new()
end

return module
