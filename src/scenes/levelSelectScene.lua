local H = love.graphics.getHeight()
local W = love.graphics.getWidth()


local scene = {}

function scene:run(world)
  world:reset()
---------------------------------------------------
  local cam = require("src.entities.gameCamera")
  cam:setWindow(100,50,805,502)
  world.camera = cam

------------------------------background-------------------------------
  local bg = {}
  function bg:draw()
    love.graphics.setBackgroundColor(0,0, 0, 255)
  --  love.graphics.rectangle("line", 50, 50, 900, 500)
  --  love.graphics.rectangle("line",390, 185, 220, 220)
  end
  world:addTo("bgLayer",bg)
-------------------------------------Scroller-------------------------------------------
  local LevelSelect = require("src.entities.ui.levelSelect")
  local scroller = LevelSelect()
    -----------------Items attached to scroller ---------------------------
  local Item = require("src.entities.ui.levelItem")
  -------connect scenes as levels 
  local i1 = Item("assets/pipa.png","src/scenes/level0",100,200,200,200,scroller)
  local i2 = Item("assets/snell.png","src/scenes/demo_scene",350,200,200,200,scroller)
  local i3 = Item("assets/piju.png","src/scenes/level0",600,200,200,200,scroller)
  -------------------------------------------------------------------end of item--------------------------
  scroller.items ={}
  table.insert(scroller.items,i1)
  table.insert(scroller.items,i2)
  table.insert(scroller.items,i3)


  world:addTo("camLayer",scroller)
---------------------------------------------------------------
  -----code for buttons
  local b2 = require("src.entities.ui.button")

  local load = b2(400,460,200,50,30,10)
  load.text="LOAD LEVEL"
  load.name = "load"
  function load:onClick()
    print(scroller.selectedItem.level)
    game.world:loadScene(scroller.selectedItem.path,"mainScreen")
    game:restart()

  end
  local home = b2(400,70,200,50,60,10)
  home.name = "home"
  home.text = "HOME"
  function home:onClick()
    game:switchTo("startScreen")
  end

  world:addTo("fgLayer",load)
  world:addTo("fgLayer",home)
-----------------------------------------------------


    --cam.shoot = player
    love.timer.sleep(.1)
end


return scene
