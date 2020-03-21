andross = require "andross"
andross.backend = require "andross.love"
dragonBones = require "andross.dragonbones"


local attachmentMgr = andross.backend.AtlasAttachmentManager("assets/pinku_tex.png")
local skel, anims, skin = dragonBones.import(love.filesystem.read("assets/pinku_ske.json"), attachmentMgr)

animMgr = andross.AnimationManager(skel, anims, skin)
animMgr:play("running")


function love.update(dt)
    animMgr:update(dt)
end

function love.draw()
    local lg = love.graphics
    lg.push()
        lg.translate(lg.getWidth()/2, lg.getHeight()/2)
        local scale = 0.5
        lg.scale(scale, scale)

        animMgr:render()
    lg.pop()
end
