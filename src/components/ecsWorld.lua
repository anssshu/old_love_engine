local ecs = require("lib.tiny")--import library
-----------------------------------------------

---create a cameraLayer draw system for camera target
local cameraLayerDrawSystem = ecs.processingSystem({cameraLayerDrawSystem=""})
cameraLayerDrawSystem.filter = ecs.requireAll("draw","cameraLayer")--create a filter for the entities
function cameraLayerDrawSystem:process(e,dt)
    e:draw()
end
----------------------------------------------------
---create a foregroundLayer draw system for objects not effected by camera
local foregroundLayerDrawSystem = ecs.processingSystem({foregroundLayerDrawSystem=""})
foregroundLayerDrawSystem.filter = ecs.requireAll("draw","foregroundLayer")--create a filter for the entities
function foregroundLayerDrawSystem:process(e,dt)
    e:draw()
end
----------------------------------------------------
---create a backgroundLayer draw system for objects not effected by camera
local backgroundLayerDrawSystem = ecs.processingSystem({backgroundLayerDrawSystem=""})
backgroundLayerDrawSystem.filter = ecs.requireAll("draw","backgroundLayer")--create a filter for the entities
function backgroundLayerDrawSystem:process(e,dt)
    e:draw()
end
----------------------------------------------------
--create an update syetem
local updateSystem = ecs.processingSystem({updateSystem=""})
updateSystem.filter = ecs.requireAll("update")--create a filter for the entities
function updateSystem:process(e,dt)
    e:update(dt)
end

---create  a sysytem for handling collision (HC)
local collisionLayerUpdateSystem = ecs.processingSystem({collisionLayerUpdateSystem=""})
collisionLayerUpdateSystem.filter = ecs.requireAll("collider")--create a filter for the entities
function collisionLayerUpdateSystem:process(e,dt)
  e:handleCollision()
  e:updateCollider()
end
--------create a world and add system and entities to it-------




local world = ecs.world()
world.camera = require("lib.gamera").new(0,0,2000,2000)--default camera

world:add(cameraLayerDrawSystem,backgroundLayerDrawSystem,
            foregroundLayerDrawSystem,updateSystem,collisionLayerUpdateSystem)

--world:add(bg,fan,snell,piju,cam)


--------------physics world---------------------
wf = require 'lib.windfield'
local pWorld  = wf.newWorld(0, 0, true)
pWorld:setGravity(0, 512)
world.debug = true
world.pWorld = pWorld
-----------------------------------
--collision pWorld

---------------------------
function world:draw()
    --draw the background layer
    self:update(dt,ecs.requireAll("backgroundLayerDrawSystem"))
    ---draw the camera layer
    self.camera:draw(function()
        self:update(dt,ecs.requireAll("cameraLayerDrawSystem"))
        if self.debug then
          self.pWorld:draw()
        end
    end)
    ---draw the foreground layer
    self:update(dt,ecs.requireAll("foregroundLayerDrawSystem"))
end

function world:updateW(dt)
    self:update(dt,ecs.requireAll("updateSystem"))  --update the update system
    self.pWorld:update(dt)--physics world update
    self:update(dt,ecs.requireAll("collisionLayerUpdateSystem"))--update the collision handler
end

return world
