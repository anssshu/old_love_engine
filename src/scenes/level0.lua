----------------------------------------------
local Sprite = require("src.components.sprite")
local Bbox = require ("src.entities.platforms.bbox")
local Box =  require ("src.entities.platforms.box_onesided")
local Poly =  require ("src.entities.platforms.polygon")
local Bg =  require ("src.entities.backgrounds.scrolling_bg")
--local Bg =  require ("src.entities.backgrounds.background")
local Pickup = require ("src.entities.pickups.pCirclePickup")
local Pickup2 = require ("src.entities.pickups.pCirclePickup")
local Player = require ("src.entities.player.physicsPlayer")
local V2 =  require("lib.vector")
local P = require("src.components.pCircleSprite")
local Enemy = require ("src.entities.characters.enemy")
local Hbar = require("src.entities.hud.healthBar")
local Life = require("src.entities.hud.life")
local Score = require("src.entities.hud.score")
local Hud = require("src.entities.hud.hud")
------------------------------------------------------
local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
local scene = {}


function scene:loadRes()
  local res ={
    ------images-------------
    bg= "assets/mountain.png",
    hud_life = "assets/heart.png",
    pickup = "assets/pickup.png",
    snell = "assets/snell.png"
  }
  return res
end

function scene:run(world)
      world:reset()
      ------------load music library-----------
      local res = self:loadRes()---create resources
      local pWorld = world.pWorld
            -----------------------------------------------
      pWorld:addCollisionClass('Player')
      pWorld:addCollisionClass('PCollider')
      pWorld:addCollisionClass('Ground')
      pWorld:addCollisionClass('CurvyGround')
      pWorld:addCollisionClass('BoxOnsided')
      pWorld:addCollisionClass('Pickup')
      pWorld:setGravity(0,2000)



      local bg = Bg(res.bg)
      bg.name = "bg"
      world:addTo("bgLayer",bg)

      local hud =Hud(res.hud_life,60,20)
      world:addTo("fgLayer",hud)


            --world:addTo("bgLayer",bg)
            --local bg ={}
            --function bg:draw()
              --love.graphics.setBackgroundColor(10, 124, 100, 255)
            --end


      local e = Enemy(world,res.snell,600,550)
      e.name ="e1"
      world:addTo("camLayer",e)

            --local plg = Poly(pWorld)--Poly(100,100,200,100,400,600)



      local bbox = Bbox(pWorld)
      for i=1,40 do
        local b = Box(pWorld,math.random(200, 20000),math.random(200, 450),100,20)
      end

      for i=1,40 do
          local b = Pickup(world,res.pickup,math.random(200, 19500),math.random(200, 450),"static",15)
          b.scale = .3
          b.name = "pick"..i
          world:addTo("camLayer",b)
      end
          --local b= Pick("assets/snell.png",600,400)
          --world:addTo("camLayer",b)




      local player = Player(world)
      world:addTo("camLayer",player)
          ---------------------------------------------------------
      --local animTest = require("src.entities.animation.testanim")
      --world:addTo("camLayer",animTest)

          ---------------------------------------------
      local cam = require("src.entities.gameCamera")
      world.camera = cam
      cam.shoot = player
          ---------------------------------------------
    end


return scene
