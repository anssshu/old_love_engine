local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
local Bg =  require ("src.entities.backgrounds.background")

local scene = {}

function scene:run(world)
  world:reset()

  -------------test-------------
  --require("src.components.anim")
  --require("lib.andross.dragon")

  --local Atlas = require("src.components.atlas")
  --local Sprite = require("src.components.sprite")
  --local atlas = Atlas("assets/bigeye.png","assets/bigeye.json")
  --local q= atlas:get("./jump_000")

  --p=Sprite("./running_020",atlas)
  --p.pos ={x=100,y=200}
  --function p:draw()
    --love.graphics.draw(atlas.image,q,100,400)
  --end
  --world:addTo("fgLayer",p)

---------------------------




  local bg = {}
  function bg:draw()
    love.graphics.setBackgroundColor(50,50, 50, 255)
    love.graphics.rectangle("line", 50, 50, 900, 500)
    love.graphics.setColor(0,0, 0, 255)
    love.graphics.rectangle("fill",390, 185, 220, 290)
    love.graphics.setColor(50,50, 50, 255)
    love.graphics.rectangle("line",390, 185, 220, 290)
    love.graphics.setColor(255,255, 255, 255)

  end
  world:addTo("bgLayer",bg)

  --local Anim = require("src.entities.animation.anim")
  --local anim = Anim("assets/boy.png",450,20,100,160)
--  anim:play("run_r")
  --world:addTo("bgLayer",anim)



  local anim2 = require("src.entities.animation.playerAnimation")
  --local anim2 = Anim2("assets/myboy.png",450,20,100,160)
  anim2.name = "anim2"
  anim2.x=450
  anim2.y=20
  world:addTo("bgLayer",anim2)

  --local bg = Bg("assets/mountain.png")
--  bg.name = "s_bg"
--  world:addTo("bgLayer",bg)


--love.graphics.setBackgroundColor(0, 0, 0, 255)

  local B2 = require("src.entities.ui.button")
  --local IB = require("src.entities.ui.flipImageButton")
  --local ib = IB("assets/play.png","assets/pause.png",100,100,100,100)

  local b1 = B2(400,200,200,50,60,10)
  local b2 = B2(400,270,200,50,20,10)
  local b3 = B2(400,340,200,50,40,10)
  local b4 = B2(400,410,200,50,70,10)



  b1.name = "s_play"
  b2.name = "s_LOAD_LEVEL"
  b3.name = "s_SETTINGS"
  b4.name = "s_QUIT"

  b1.text = "PLAY"
  b2.text = "LOAD_LEVEL"
  b3.text = "SETTINGS"
  b4.text = "QUIT"



  world:addTo("fgLayer",b1)
  world:addTo("fgLayer",b2)
  world:addTo("fgLayer",b3)
  world:addTo("fgLayer",b4)

  --  world:addTo("fgLayer",ib)

  -------start---------
  function b1:onClick()
      game:play()
  end

  ---------load level------
  function b2:onClick()
    game:switchTo("levelScreen")
  end
  ----------settings-------
  function b3:onClick()
  world:switchTo("settingsScreen")
  end
  ---------------quit-------
  function b4:onClick()
    print("b4")
    game:quit()
  end










  local cam = require("src.entities.gameCamera")
  world.camera = cam
    --cam.shoot = player
    love.timer.sleep(.1)
end


return scene
