local Sprite = require("src.components.pCircleSprite")

local module= function(world,filename,x,y,type,r)
    local obj = Sprite(world.pWorld,filename,x,y,"kinematic",r)
    ---initilisation function
    function obj:new()
        self.name = "enemy"
        self.speed = 2
        self.span =100
        self.m_speed = 2
        self.p0 = {x=self.pos.x,y=self.pos.y}
        return self
    end


    --update function
    function obj:update(dt)
      if self.body then
              ------------enemy motion----------------
              if self.pos.x>self.p0.x +self.span then
                self.speed = -1*self.m_speed
                self.scaleX = -1
              end
              if self.pos.x<self.p0.x - self.span then
                self.speed = 1*self.m_speed
                self.scaleX = 1
              end
              self.body:setLinearVelocity(self.speed*100,0)
        ----------------enemy player interaction-------------
              if self.body:enter("Player") then
                local data = self.body:getEnterCollisionData("Player")
                print("player jumped on my head")

--[[
                self.update = nil
                self.body:setType("dynamic")
                self.body:setMass(1)
                self.body:setRestitution(.8)
                self.body:applyLinearImpulse(-1600,-1500)
                world.Timer:after(4,function()
                  world:remove(world:find(obj.name))
                end)
                  return

]]
              end
              if self.body:enter("PCollider") then
                  local data = self.body:getEnterCollisionData("PCollider")
                  local x,y = data.contact:getNormal()
                  if y ~= -1 then
                    ----hurt player
                    data.collider.object.body:applyLinearImpulse(-100*self.scaleX,-400)
                    print(self.name,":I bite player",data.contact:getNormal())
                     local player = data.collider.object
                     player.health = player.health -10
                    return
                  end
          end
      end
---------------------------end of enemy player interaction--------------
    end
    return obj:new()
end

return module
