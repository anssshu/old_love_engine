local module= function(filename,atlas)
    local sprite = {}


    ---initilisation function
    function sprite:new(filename,atlas)
        self.atlas = atlas or nil
        if self.atlas ~= nil then
          self.sprite = self.atlas.image
          self.q = self.atlas:get(filename)
          self.quad = love.graphics.newQuad(self.q.x, self.q.y, self.q.width, self.q.height,self.sprite:getDimensions())
        else
          self.sprite = love.graphics.newImage(filename)
        end
        --self.sprite = atlas.image or love.graphics.newImage(filename)
        --self.quad = quad or nil
        self.origin = {x=0.5,y=0.5}
        self.pos = {x=0,y=0}
        self.rot = 0
        self.scaleX = 1
        self.scaleY = 1
        self.scale = 1
        self.w = self.sprite:getWidth()
        self.h =  self.sprite:getHeight()
        return self
    end
    --draw function
    function sprite:draw()
      if  self.atlas == nil then
        love.graphics.draw(
        self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
        self.scale*self.scaleX,self.scale*self.scaleY,
        self.sprite:getWidth()* self.origin.x,
        self.sprite:getHeight()*self.origin.y
      )
      end
      if self.atlas ~= nil then
        --love.graphics.draw(
        --self.sprite,self.quad,self.pos.x,self.pos.y,math.rad(self.rot),
        --self.scale*self.scaleX,self.scale*self.scaleY,
        --self.sprite:getWidth()* self.origin.x,
        --self.sprite:getHeight()*self.origin.y
      --)
      love.graphics.draw(self.sprite,self.quad,self.pos.x,self.pos.y,math.rad(self.rot),
      self.scale*self.scaleX,self.scale*self.scaleY,
      self.q.width* self.origin.x,self.q.height*self.origin.y
    )
      end
    end
    --update function
    function sprite:update(dt)

    end
    return sprite:new(filename,atlas)
end

return module
