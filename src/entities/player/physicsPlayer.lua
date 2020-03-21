local Sprite = require("src.components.sprite")
local V2 =require("lib.vector")
local anim = require("src.entities.animation.playerAnimation")

--local anim = Anim("assets/myboy.png",150,100,100,160)
local m = function(world)
      --joystick
      local axis
      local value
      local button
      --local HC = require("lib.HC")
      ----world parameter
      local world = world
      local pWorld = world.pWorld
      local gravity = V2(pWorld:getGravity())
      local g = gravity:len()

---------------player parameter-----------------------------
      local maxSpeed = 900 --max movement speed
      local w = 50 --collider width
      local h = 90 --collider height
      local r = 10 --body radius

      --[[
      the player consisit of a sprite--which is an newImage
      pcollider-------a rectangle
      body------box2d shape circle for movement as per physics
      ]]
----------------------player sprite-----------------------------
      local player =Sprite("assets/pipa.png")
      player.anim = anim
      player.isOnGround = false
      player.class ="Player"
      player.name = "pipa"
      player.origin ={x=.5,y=.9}
      player.scale = .2
      player.health = 100
      player.life = 3
-----------------------player pcollider ------------------------
      player.pcollider = pWorld:newRectangleCollider(300,300,w,h)
      --player.pcollider:setType("kinematic")
      player.pcollider:setObject(player)
      player.pcollider:setType("dynamic")
      player.pcollider.object = player
      player.pcollider:setCollisionClass("PCollider",{ignores = {'Player'}})

      player.pcollider:setPreSolve(function(a,b,c)
            c:setEnabled(false)
        end)


-----------------------player body---------------------
      player.body = pWorld:newCircleCollider(100,200,r)
      player.body:setRestitution(0)
      player.body:setCollisionClass("Player",{ignores = {'Player'}})

      player.t=V2(1,0)--tangent
      player.n=V2(0,-1)--normal


      -------------body presolve collision-----------
      player.body:setPreSolve(function(me,other,contact)
          --collision with curvy ground
          if other.collision_class == "CurvyGround" then
            player.n = V2(contact:getNormal())
            player.t = player.n:rotated(math.rad(90))
            pWorld:setGravity(0,.2*g)
          else
            player.n =V2(0,-1)
            player.t = V2(1,0)
            pWorld:setGravity(0,g)
          end
        --if q >-.1 then contact:setEnabled(false)end
      end)
      --------------------body enter collision--------------
      --------------------pbody enter collision------------

--------------------------player update function----------------------------

      function player:update(dt)

          self.anim:update(dt)
          self.anim.x = self.pos.x -60
          self.anim.y = self.pos.y -150
          self:rayCast()
          -----update health
          if world:find("Hud") then world:find("Hud").health = self.health end

          ----update life
          if world:find("Hud") then world:find("Hud").life = self.life end
          if self.health < 10 and self.life > 1 then
            print("Player Died")
            self.health = 100
            self.life = self.life -1
          end
          if self.health < 10 and self.life == 1 then
            print("Game Over")
            world.Timer:after(.2,function()
              game:gameOver()
              return
            end)

          end
          ------------------------------
         if not player.isOnGround then
            pWorld:setGravity(0,g)
         end

         self:eventPoll()
         --print(player.isOnGround)

         --calculate normal and tangent when player hit ground
          --if self.body:enter("Ground") then
            --self.t = V2(1,0)
            --self.n = V2(0,-1)
          --end
          --calculate normal and tangent when player hit ground
           --if self.body:stay("Ground") then
             --self.t = V2(1,0)
             --self.n = V2(0,-1)
           --end

          --[[if self.body:exit("Ground") then

            self.t = {x=1,y=0}
            self.n={x=0,y=-1}
          end]]


      end
      ------------------------------------------------------------
      --function to update pcollider and sprite pos and angle
      function player:updateBody()

        --update player position
         self.pos = V2(self.body:getPosition())
         --local r = math.deg(self.body:getAngle())
         --update player orientation
         local angle =(math.deg(self.n:angleTo(V2(1,0)))+90)

         if math.abs(angle - self.rot)>2 then
           self.rot = angle
         end

         --update pcollider getPosition
         if self.pcollider then
           angle = math.rad(player.rot)
           if math.abs(angle)>2*math.pi then player.body:setAngle(0)end
           local x= player.pos.x
           local y =  player.pos.y
           local x0 = 0
           local y0 = h/2+20

           self.pcollider:setAngle(angle)
           --angle is the angle with horizontal or tangent of player
           self.pcollider:setPosition(x+y0*math.sin(angle)+x0,y+(y0-y0*math.cos(angle))-y0)


         end


      end
      --[[
      function player:updateCollider()
          --self.collider:rotate(.01,self.pos.x,self.pos.y)
          if self.collider then
            local angle = math.rad(self.rot)
            self.collider:moveTo(self.pos.x+(h/2-r)*math.sin(angle),self.pos.y-(h/2-r)*math.cos(angle))
            self.collider:setRotation(angle)
          end

      end]]
      function love.joystickaxis( j, ax, val )
        axis = ax
        value = val
      --  print(ax,val)
      end
      function love.joystickpressed(joystick,btn)
        button = btn
        print(btn)
      end
      function love.joystickreleased(joystick,btn)
        button = 100
        print("released",btn)
      end
      function player:eventPoll()
          local v=V2(self.body:getLinearVelocity())
          local speed = v:len()
          --print(axis,value)
          --print(love.keyboard.isDown("a") or ( axis==1 and value == -1)  and speed <maxSpeed )
          if ((love.keyboard.isDown("a") or ( axis==1 and value == -1))  and speed <maxSpeed ) then
              self.scaleX = -1
              self.body:applyLinearImpulse( -10*self.t.x, -10*self.t.y )
              if self.isOnGround then self.anim:play("run_l") end
              
          end

          if love.keyboard.isDown("d") or ( axis==1 and value == 1) and speed < maxSpeed then
              self.scaleX = 1
              self.body:applyLinearImpulse( 10*self.t.x, 10*self.t.y)
              if self.isOnGround then self.anim:play("run_r") end
          end
          if (love.keyboard.isDown("w") or button == 1) and self.isOnGround  then
              self.body:applyLinearImpulse( 0, -200 )
              game:playSound("jump")
              if self.scaleX == 1 then self.anim:play("jump_r") else self.anim:play("jump_l") end
          end
          if love.keyboard.isDown("s") or ( axis==2 and value == 1) then
              self.body:applyLinearImpulse( 0, 2 )
          end


          if (love.keyboard.isDown("a","s","d","w") == false or value==0) and self.isOnGround == true then
              self.body:setLinearVelocity(v.x*.2,v.y)
              print("rest")
              if self.scaleX == 1 then self.anim:play("idle_r") else self.anim:play("idle_l") end
          end

      end



      --player.body:setPreSolve(function(me,other,contact)
        --if other.collision_class == "Ground" then print("on ground")end

      --end)
      function player:rayCast()
        --Raycast and check if player is on ground or not
         r1 =V2(player.pos.x,player.pos.y)
         r2 = V2(player.pos.x-player.n.x*20,player.pos.y-player.n.y*20)
         player.isOnGround = false
         pWorld:rayCast(r1.x,r1.y,r2.x,r2.y,
          function(fixture, x, y, xn, yn, fraction)
            player.isOnGround = true
            return 1
         end)
      end

      ----function for body collision

      function player:draw()
        --[[
          love.graphics.draw(self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
          self.scaleX*self.scale,self.scale*self.scaleY,
          self.sprite:getWidth()* self.origin.x,
          self.sprite:getHeight()*self.origin.y)
]]
          self.anim:draw()
        if (self.debug) then
          love.graphics.setColor(255,0,0)
          self.collider:draw("line")
          love.graphics.line(r1.x,r1.y,r2.x,r2.y)
          love.graphics.setColor(255,255,255)
        end

      end
      return player
end

return m
