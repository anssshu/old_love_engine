--[[
the world consist of bgLayer
camLayer
and fg Layer

]]
local world = require ("src.entities.world")
local pWorld = world.pWorld
local sprite = require("src.components.sprite")


player ={
  pos={x=400,y=300},
  body = pWorld:newCircleCollider(300,300,50)
}

player.body:setRestitution(1)
function player:update(dt)

end
function player:updateBodyPos()
  local x,y
    x,y = self.body:getPosition()
  self.pos ={x=x,y=y}

end

world:addTo("camLayer",player)

local ground = pWorld:newRectangleCollider(0, 550, 600, 50)
ground:setType('static')

local cam = require("src.entities.gameCamera")
world.camera = cam
cam.shoot = player


return world
