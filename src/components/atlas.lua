--[[
example to use the code
local Atlas = require("src.components.atlas")
local Sprite = require("src.components.sprite")

local atlas = Atlas("assets/bigeye.png","assets/bigeye.json")
local q= atlas:get("./jump_000")

p=Sprite("./running_020",atlas)
p.pos ={x=100,y=200}
--function p:draw()
  --love.graphics.draw(atlas.image,q,100,400)
--end
world:addTo("fgLayer",p)
]]

local JSON = require("lib.json")

Atlas={}

function Atlas:new(image,json)
  self.image = love.graphics.newImage(image)
  self.jsonString = love.filesystem.read(json)
  self.json = JSON.parse(tostring(self.jsonString))
  return self
end

function Atlas:get(sprite)
  local q =self.json[sprite].frame
  return q--love.graphics.newQuad(q.x, q.y, q.width, q.height,self.image:getDimensions())
end

local M =function(image,json)
  local atlas = {}

  for k,v in pairs(Atlas) do
    atlas[k] = v
  end

  return atlas:new(image,json)

end

return M
