return {
  health = 60,
  x=130,
  y=35,
  width = 200,
  height = 20,
  w=200,
  update = function(self,dt)

      if self.health >0 then
        self.w = self.width*self.health/100
      else
        self.w = 0
      end
  end,
  draw = function (self)
    ---draw the back ground bar
    love.graphics.setColor(255, 0, 0, 155)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 255)

    ---draw the health bar
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.height)
    love.graphics.setColor(255, 255, 255, 255)
  end
}
