--local HC = require("lib.HC")
local world = require ("src.entities.world")
local HC = world.HC
local module= function(filename,p,q)
    local sprite = {}
    local p = p or 0
    local q = q or 0
    ---initilisation function
    function sprite:new(filename)
        self.name = "collisionSprite"
        self.debug = true
        self.sprite = love.graphics.newImage(filename)
        self.origin = {x=0.5,y=0.5}
        self.pos = {x=p ,y= q }
        self.rot = 0
        self.scaleX=1
        self.scaleY=1
        self.scale  =1

        self.collider = HC:rectangle(self.pos.x,self.pos.y,self.sprite:getWidth(),self.sprite:getHeight())
        self.collider.object = self
        self.iscolliding = false

        self.collider:moveTo(self.pos.x,self.pos.y)
        self.collider:setRotation(math.rad(self.rot))

        return self
    end
    --draw function
    function sprite:draw()
        love.graphics.draw(self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
    self.scaleX*self.scale,self.scale*self.scaleY,self.sprite:getWidth()* self.origin.x,self.sprite:getHeight()*self.origin.y)
      if (self.debug) then
        love.graphics.setColor(255,0,0)
        self.collider:draw("line")
        love.graphics.setColor(255,255,255)
      end
    end

    function sprite:handleCollision()

        local col = HC:collisions(self.collider)
        --print(self.name)
        local last_other ={}--last collidind shape
        for other,vector in pairs(col) do
                last_other = other
        end
        if (next(col)==nil) then ----if there is no collision
            if self.iscolliding == true then --if object was previously colliding
                --print("col exit")
                self:onCollisionExit(last_other)
            end
            self.iscolliding = false
            --print("no col")
        else ----if there is collision
            if self.iscolliding == false then --if object was previously not colliding
                --print("col enter")

                self:onCollisionEnter(last_other)

            end
            self.iscolliding = true
            --print("col stay")

            self:onCollisionStay(last_other)

        end


    end
    function sprite:updateCollider()
      if self.collider then
        self.collider:moveTo(self.pos.x,self.pos.y)
        self.collider:setRotation(math.rad(self.rot))
      end
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
    function sprite:update(dt)

    end

    return sprite:new(filename)
end

return module
