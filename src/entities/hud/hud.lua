local mainFont = love.graphics.newFont("assets/seasrn.ttf", 30);
local LFont = love.graphics.newFont("assets/seasrn.ttf", 25);
local font = love.graphics.newImageFont( 'assets/font_example.png',
' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',2 )


local w =love.graphics.getWidth()
local h = love.graphics.getHeight()

----------------------pause button ----------code
local Button = require("src.entities.ui.flipImageButton")
local pause = Button("assets/play.png","assets/pause.png",.02*w,20,35,35)
pause.name = "pause_button"
function pause:onClick()
  game:togglePasue()
end
-----------------------------------------------------------
---------------------code for menu buttons -----------------------

local ImgButton = require("src.entities.ui.flipImageButton")
local mute = ImgButton("assets/mute.png","assets/unmute.png",.01*w,.9*h,50,50)
mute.name = "hud_mute"
----initialisation of mute button
if game.musicPlayer.mute then
  mute.i = 1
end

function mute:onClick()
  if self.i == 2 then
    game.musicPlayer.mute = true
    love.filesystem.write("f",tostring(game.musicPlayer.volume).." 1")
  else
    game.musicPlayer.mute = false
    love.filesystem.write("f",tostring(game.musicPlayer.volume).." 0")
  end
end
---------------------------------end of mute button


local B2 = require("src.entities.ui.button")
local b1 = B2(400,200,200,50,60,10)
local b2 = B2(400,270,200,50,60,10)
local b3 = B2(400,340,200,50,40,10)
local b4 = B2(400,410,200,50,70,10)



b1.name = "s_play"
b2.name = "s_HOME"
b3.name = "s_SETTINGS"
b4.name = "s_QUIT"

b1.text = "PLAY"
b2.text = "HOME"
b3.text = "SETTINGS"
b4.text = "QUIT"

local panel = {
  b1 = b1,
  b2 = b2,
  b3 = b3,
  b4 = b4
}
--  world:addTo("fgLayer",ib)

-------start---------
function b1:onClick()

    --game:play()
    game:resume()
end

---------home button------
function b2:onClick()
  --game:resume()
  game:gotoStartScreen()
  game:resume()
end
----------settings-------
function b3:onClick()
  world:switchTo("settingsScreen")
  game.musicPlayer.audio:stop()
  game:resume()
end
---------------quit-------
function b4:onClick()
  print("b4")
  game:quit()
end
-----------------------end of panel -------------------------------
local M=  {

  init = function(self,filename,x,y)
    self.name = "Hud"
    self.class = "Hud"

    self.life = 3
    self.health = 80
    self.level = 1
    self.score = 0

    self.x=x or 20
    self.y=y or 20

    self.hbarW = 200 --health bar width
    self.bhbarW = 150 --back ground hbar width
    self.hbarH = 20  ---health bar height

    self.scaleX = 1
    self.scaleY = 1
    self.scale = .6


    self.sprite = love.graphics.newImage(filename)----life image
    self.w = self.sprite:getWidth()*self.scale
    self.h = self.sprite:getHeight()*self.scale
    return self
  end,

  update = function(self)
    mute:update(dt)
    pause:update(dt)---update code for pause buttons
    ------------panel update -----------------
    if game._pause then-----when game is paused then only update
      for k,v in pairs(panel) do
        v:update()
      end
      mute:update(dt)
    end
    --------------------------
    if self.health >0 then
      self.hbarW = self.bhbarW*self.health/100
    else
      self.hbarW = 0
    end

  end,

  draw = function(self)

      pause:draw()----pause button code
      -------draw panel when game is paused------
      if game._pause then---
        for k,v in pairs(panel) do
          v:draw()
        end
        love.graphics.setColor(155, 0, 0, 255)
        love.graphics.circle("fill", 0, h, 100, 50)
        mute:draw() --draw mute button
      end
    ----draw the life----------------
--[[
        love.graphics.setColor(155,0,0,155)
        love.graphics.rectangle("fill", self.x-5, self.y-5,290,50)

        love.graphics.setColor(0,0,0,255)
        love.graphics.rectangle("line", self.x-5, self.y-5,290,50)
]]
        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(self.sprite,self.x,self.y,0,self.scale*self.scaleX,self.scale*self.scaleY)
        --love.graphics.setColor(0,0,0,255)
        love.graphics.setFont(LFont);
        love.graphics.print("x"..self.life,self.x+50,self.y)

    --------------Draw the healthbar----------------
        ---------backgraound bar ---------------
        love.graphics.setColor(255, 0, 0, 155)
        love.graphics.rectangle("fill", self.x+110, self.y+5, self.bhbarW, self.hbarH)


        --------forebround bar -----------------
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.rectangle("fill", self.x+110, self.y+5, self.hbarW, self.hbarH)

        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.rectangle("line", self.x+110, self.y+5, self.bhbarW, self.hbarH)


    ---------------------Draw Level-------------------------------
        love.graphics.setColor(155,0,0,155)
        love.graphics.rectangle("fill", self.x+w/2-95, self.y-6, 140, 40)
        love.graphics.setColor(255,155,0,255)
        love.graphics.print("LEVEL:"..self.level,self.x+w/2-80,self.y-6)

        love.graphics.setColor(0,0,0,255)
        love.graphics.rectangle("line", self.x+w/2-95, self.y-6, 140, 40)

        -------------------Draw Score-----------------------------
            love.graphics.setColor(255,255,255,255)
            love.graphics.setFont(font);
            love.graphics.print("SCORE: "..self.score,self.x+w-300,self.y+20)
            love.graphics.print("HI SCORE: "..self.score,self.x+w-300,self.y)

        love.graphics.setColor(255,255,255,255)

  end

}


-------------module exporter
local hud = function(filename,x,y)
  return M:init(filename,x,y)
end

return hud
