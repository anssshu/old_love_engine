
local module = function(pWorld,filename,x,y,type,w,h)

      local obj ={}

      function obj:new()
        self.name = "physicsSprite"
        self.sprite = love.graphics.newImage(filename)
        self.origin = {x=0.5,y=0.5}
        self.pos = {x = x or 0,y = y or 0}
        self.rot = 0
        self.scaleX = 1
        self.scaleY = 1
        self.scale = 1
        self.type = type or "static"
        self.w = w or   self.sprite:getWidth()
        self.h = h or self.sprite:getHeight()
        self.body = pWorld:newRectangleCollider(self.pos.x,self.pos.y,self.w,self.h)

        self.body:setObject(self)
        self.body:setType(self.type)
        self.body.object = self

        self.body:setPosition(self.pos.x,self.pos.y)

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
