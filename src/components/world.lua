---every object should have a name and camer's name should be camera
local wf = require("lib.windfield")
local HC = require("lib.HC")
local Timer = require("lib.hump.timer")
local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
--local gui = require("lib.Gspot")
---------------------------------------------
local world = {

    objects={},
    layers={
      bgLayer = {},
      fgLayer={},
      camLayer={}
    },

    --audioLib={},
    debug=true,
    camera = require("lib.gamera").new(0,0,2000,2000),
    pWorld = wf.newWorld(0, 512, true),
    HC = HC.new(),
    Timer = Timer.new(),
    screens ={
        mainScreen ={},
        gameoverScreen={},
        settingsScreen = {},
        startScreen = {},
        levelScreen = {}
      },
    level = 1,
    currentScreen = "startScreen"
    --gui = gui
}

world.camera.name = "camera"
--------------------create layers------------
--world.layers.bgLayer = {}
--world.layers.fgLayer={}
--world.layers.camLayer={}

function world:reset()
    --[[
    for k,v in pairs(self.objects) do
        self.objects[k] = nil
    end

    for k,v in pairs(self.layers.bgLayer) do
        self.layers.bgLayer[k] = nil
    end

    for k,v in pairs(self.layers.camLayer) do
        self.layers.camLayer[k] = nil
    end
    for k,v in pairs(self.layers.fgLayer) do
        self.layers.fgLayer[k] = nil
    end
]]
      self.objects ={}
      self.layers={

        bgLayer = {},
        fgLayer={},
        camLayer={}
      }

      --self.audioLib ={}
      self.HC:resetHash()
      self.pWorld:destroy()
      self.pWorld = wf.newWorld(0, 512, true)
      self.Timer:clear()

      --for k,v in pairs(self.gui.elements)do
      --  table.remove(self.gui.elements,k)
      --end
      self.camera:setWindow(0,0,W,H)
      self.camera.shoot = {
          pos = {
            x=W/2,
            y=H/2
          }
      }
      --self.scene = {}------dont reset the scene
end

--add objects to different layers
function world:addTo(layer,obj)
  if obj.name == nil then obj.name = "default" end
  --add to layer
  table.insert(self.layers[layer],obj)
  --add to objectList
  self.objects[obj.name] = obj
end
---seaarch objects
function world:find(name)
  return self.objects[name]
end
-----------remove objects from the world----------
function world:remove(obj)
  --remove the collider

  --remove from object list
  self.objects[obj.name]= nil
  --remove from layer
  for k,layer in pairs(self.layers)do
    for k2,object in pairs(layer)do
        if object.name == obj.name then
            layer[k2] = nil
        end
    end
  end
  --remove the object from the physics pWorld
  if obj.body  then
    obj.body:destroy()
    obj.body = nil
  end
  if obj.pcollider  then
    obj.pcollider:destroy()
    obj.pcollider = nil
  end
  --remove shape from HC world
  if obj.collider  then
    world.HC:remove(obj.collider)
    obj.collider = nil
   end
end
------------draw the world---------------
function world:draw()
    --draw the bgLayer

    for k,v in pairs(self.layers.bgLayer) do
        if v.draw ~= nil then v:draw() end
    end
    -----------------------
------draw the camera Layer
    self.camera:draw(function()
        -------draw all the objects in camLayer
        for k,v in pairs(self.layers.camLayer) do

           if v.name ~= "camera" then
              if v.draw ~= nil then v:draw() end
           end

        end
        -----------------then debugdraw physics world
        if self.debug and self.pWorld then self.pWorld:draw() end
    end
  )
  -------------------------------------
---------draw the foregraoung layer
    for k,v in pairs(self.layers.fgLayer) do
        if v.draw ~= nil then v:draw() end
    end
    --self.gui:draw()
------------------------------------
end
----------------update the world -----------
function world:update(dt)

    if self.pWorld then self.pWorld:update(dt)end
    if self.camera.update ~= nil then
      self.camera:update(dt)
    end

    for k,v in pairs(self.objects) do
        if  v.update ~= nil then v:update(dt) end
        --HC collider handling
        if v.collider ~= nil then
            v:handleCollision()
            v:updateCollider()
        end
        --wf component handlig
        if v.body ~= nil and v.updateBody ~= nil then
            v:updateBody()
        end
    end
    --update timer
    self.Timer:update(dt)
    --self.gui:update(dt)
end
function world:loadScene(scenepath,screen)
  ---------kill previous scene-------
  if self.screens[screen] then
    self.screens[screen] = require(scenepath)
  end
  --love.timer.sleep(2)
end
function world:switchTo(screen)
  if next(self.screens[screen]) ~= nil then
      self.screens[screen]:run(self)
      self.currentScreen = screen
  end
end
function world:print()
  local  i =0
  for k,v in pairs(self.objects) do
    print(v.name)
    i=i+1
  end
  print("Total Objects:"..i)
end
---------------------------
return world
