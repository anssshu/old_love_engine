--[[
the world consist of bgLayer
camLayer
and fg Layer

]]local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
local world = require ("src.components.world")

local scene = {}

function scene:run(world)
  world:reset()
  local pWorld = world.pWorld
  local sprite = require("src.components.sprite")

  ---add a background
  local bg = sprite("assets/background.png")
  bg.name = "background"--for easy removal and addition to game world
  bg.origin = {x=0,y=0}
  world:addTo("camLayer",bg)


  ----add a player
  --first create an atlas from sprite sheetpacker json file and image file
  local Atlas = require("src.components.atlas")
  local atlas = Atlas("assets/bigeye.png","assets/bigeye.json")
  --then create the sprite from the atlas

  local player=sprite("./running_010",atlas)

  --local player = sprite("assets/snell.png")
  player.name = "snell"
  player.pos={x=200,y=400}


  function player:update(dt)
    if love.keyboard.isDown("a") then
         self.pos.x = self.pos.x -1
     end

     if love.keyboard.isDown("d") then
         self.pos.x = self.pos.x + 1
     end
     if love.keyboard.isDown("w") then
        self.pos.y = self.pos.y - 1
     end
     if love.keyboard.isDown("s") then
         self.pos.y = self.pos.y + 1
     end
  end

  world:addTo("camLayer",player)

  ---add a camera
  local cam = require("src.entities.gameCamera")
  world.camera = cam
  cam.shoot = player



end


return scene
