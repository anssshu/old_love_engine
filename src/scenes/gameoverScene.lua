local Bg =  require ("src.entities.backgrounds.background")
local Sprite = require("src.components.sprite")
local scene = {}
local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
function scene:run(world)
  world:reset()

  local bg = Bg("assets/mountain.png")
  bg.name = "go_bg"
  world:addTo("bgLayer",bg)

  local go = Sprite("assets/GAMEOVER.png")
  go.name = "go_gameOver"
  go.pos ={x=500,y=200}
  go.scale =2
  world:addTo("bgLayer",go)


  local B2 = require("src.entities.ui.button")




  local b2 = B2(400,270,200,50,5,10)
  local m = B2(400,340,200,50,60,10)
  local b4 = B2(400,410,200,50,70,10)




  b2.text = "RESTART LEVEL"
  m.text = "HOME"
  b4.text = "QUIT"

  b2.name = "go_rs"
  b4.name = "go_quit"
  m.name = "go_home"

  world:addTo("fgLayer",b2)
  world:addTo("fgLayer",m)
  world:addTo("fgLayer",b4)



  ---------restart------
  function b2:onClick()
    game:restart()
  end
  ----------go back to start screen-------
  function m:onClick()
    game:gotoStartScreen()
  end
  ---------------quit-------
  function b4:onClick()
    game:quit()
  end





  local cam = require("src.entities.gameCamera")
  world.camera = cam
    --cam.shoot = player
    love.timer.sleep(.1)
end


return scene
