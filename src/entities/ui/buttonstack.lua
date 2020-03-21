local B2 = require("src.entities.ui.button")



local b1 = B2(400,200,200,50,60,10)
local b2 = B2(400,270,200,50,0,10)
local b3 = B2(400,340,200,50,60,10)
local b4 = B2(400,410,200,50,70,10)



b1.name = "START"
b2.name = "RESTART LEVEL"
b3.name = "MENU"
b4.name = "QUIT"


world:addTo("fgLayer",b1)
world:addTo("fgLayer",b2)
world:addTo("fgLayer",b3)
world:addTo("fgLayer",b4)

-------start---------
function b1:callback()
  print("b1")
  world.scenes.mainScene:run(world)
end

---------restart------
function b2:callback()
  print("b2")
  world.scenes.mainScene:run(world)
end
----------menu-------
function b3:callback()
  print("b3")
end
---------------quit-------
function b4:callback()
  print("b4")
  os.exit()
end
