
local module = function(pWorld,filename,p,q,type,points)

      local obj ={}

      function obj:new()
        self.debug = true
        self.name = "physicsSprite"
        self.sprite = love.graphics.newImage(filename)
        self.origin = {x=0,y=0}
        self.pos = {x = p or 0,y = q or 0}
        self.rot = 0
        self.scaleX = 1
        self.scaleY = 1
        self.scale = 1
        self.type = type or "static"

        local points = points or {0,0,50,100,100,0}

        --for k,v in pairs(points)do
          --if k%2 == 0 then points[k]=v+q else points[k] = v+p end
        --end


        --poly line made with tiled


        self.body = pWorld:newChainCollider(pWorld,points)
        self.body:setPosition(self.pos.x,self.pos.y)
        self.body:setType(self.type)
        self.body:setObject(self)
        self.body.object = self

        return self
      end

      function obj:updateBody()

        if self.body then
            local p,q =self.body:getPosition()
            --update sprite position
            self.pos = {x=p,y=q}
            --update sprite rotation
            self.rot = math.deg(self.body:getAngle())

        end

      end

      function obj:update(dt)
        --self:updateBody()
      end

      function obj:draw()

        love.graphics.draw(
        self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
        self.scale*self.scaleX,self.scale*self.scaleY,
        self.sprite:getWidth()* self.origin.x,
        self.sprite:getHeight()*self.origin.y
        )

      end

      return obj:new()
end
return module
