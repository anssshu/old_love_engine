local sprite = require("src.components.sprite")
local Bg =  require ("src.entities.backgrounds.background")
local scene = {}
local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
function scene:run(world)
  world:reset()

  --local bg = Bg("assets/mountain.png")
  --bg.name = "s_bg"
  --world:addTo("bgLayer",bg)

  local bg = {}
  function bg:draw()
    love.graphics.setBackgroundColor(0,0, 0, 255)
    love.graphics.rectangle("line", 50, 50, 900, 500)
    love.graphics.rectangle("line",390, 185, 220, 220)
  end
  world:addTo("bgLayer",bg)
----------------------------music control----------------------------------
  local rect = {name = "rect"}
  function rect:draw()
      love.graphics.setColor(155, 0, 0, 255)
      love.graphics.rectangle("fill",400,270,200,50)
      love.graphics.setColor(0, 0, 0, 255)
      love.graphics.rectangle("line",400,270,200,50)
  end

  world:addTo("fgLayer",rect)

  local Slider = require("src.entities.ui.slider")
  local ImgButton = require("src.entities.ui.flipImageButton")

  local x,y = 400,270

  local slider = Slider(x+55,y+15,140,20)
  slider.mx =slider.x+game.musicPlayer.volume*slider.w*.95--initilize slider position
  slider.name = "slider"
  local mute = ImgButton("assets/mute.png","assets/unmute.png",x,y,50,50)
  mute.name = "mute"

  function slider:onClick()
      --print("clicked")
      love.filesystem.write("f",tostring(self.value).." "..tostring(mute.i))--write volume and mute setting to file
      game.musicPlayer.volume = self.value
      love.audio.setVolume(self.value)

  end


  -----------set volume of game-----------
  function slider:onChange()
    love.audio.setVolume(self.value)
    game.musicPlayer.volume = self.value

    if game.musicPlayer.mute then --set the mute logo
        mute.i = 1
    end
  end

  function mute:onClick()

      if self.i == 2 then
        game.musicPlayer.mute = true
        love.filesystem.write("f",tostring(slider.value).." 1")
      else
        game.musicPlayer.mute = false
        love.filesystem.write("f",tostring(slider.value).." 0")
      end

  end





  world:addTo("fgLayer",slider)
  world:addTo("fgLayer",mute)


------------------------end of music control--------------------------------------------

----------------------home button ----------------------
  local B2 = require("src.entities.ui.button")

  local b3 = B2(400,200,200,50,60,10)
  b3.text = "HOME"
  b3.name = "s_menu"
  world:addTo("fgLayer",b3)

  -----------go  back to start screen
  function b3:onClick()
    world:switchTo("startScreen")
  end
----------------------home button ----------------------
-----------------------quit button------------------------



local b4 = B2(400,340,200,50,60,10)
b4.text = "QUIT"
b4.name = "s_quit"
world:addTo("fgLayer",b4)

-----------go  back to start screen
function b4:onClick()
  game:quit()
end

---------------------------------------------------------
  local cam = require("src.entities.gameCamera")
  world.camera = cam
    --cam.shoot = player
    love.timer.sleep(.1) --delay it
end


return scene
