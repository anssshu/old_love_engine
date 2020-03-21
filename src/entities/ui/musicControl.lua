local Slider = require("src.entities.ui.slider")
local ImgButton = require("src.entities.ui.flipImageButton")

local x,y = 400,300

local slider = Slider(x+60,y+13,140,20)
slider.name = "slider"
local imgB = ImgButton("assets/mute.png","assets/unmute.png",x,y,50,50)
imgB.name = "mute"

world:addTo("fgLayer",slider)
world:addTo("fgLayer",imgB)
