
local sprite = require("src.components.sprite")

local scene = {}

function scene:run(world)
  world:reset()
  local cam = require("src.entities.gameCamera")
  world.camera = cam
    --cam.shoot = player
end


return scene
