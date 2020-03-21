local CSprite = require("src.components.cSprite")
local V2 =require("lib.vector")

local m = function(world)
      --local HC = require("lib.HC")
      local world = world
      local HC = world.HC
      local pWorld = world.pWorld

      local gravity = V2(pWorld:getGravity())
      local g = gravity:len()

      local maxSpeed = 900 --max movement speed
      local w = 50 --collider width
      local h = 120 --collider height
      local r = 10 --body radius

      --[[
      the player consisit of a sprite--which is an newImage
      collider-------a rectangle
      body------box2d shape circle for movement as per physics
      ]]
      local player =CSprite("assets/pipa.png")
      player.isOnGround = false
      player.class ="Player"
      player.name = "pipa"
      player.origin ={x=.5,y=.9}
      player.scale = .2


      player.collider = HC:rectangle(0,0,w,h)
      player.collider.object = player
      player.iscolliding = false

      player.body = pWorld:newCircleCollider(100,200,r)
      player.t=V2(1,0)
      player.n=V2(0,-1)

      player.body:setRestitution(0)
      player.body:setCollisionClass("Player")

      function player:update(dt)
        --Raycast and check if player is on ground or not
         r1 =V2(player.pos.x,player.pos.y)
         r2 = V2(player.pos.x-player.n.x*20,player.pos.y-player.n.y*20)
        player.isOnGround = false
        pWorld:rayCast(r1.x,r1.y,r2.x,r2.y,
          function(fixture, x, y, xn, yn, fraction)
            player.isOnGround = true
            return 1
         end)

         if not player.isOnGround then
            pWorld:setGravity(0,g)
         end
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
          self:eventPoll()

      end
      function player:updateBody()
        --update player position
         self.pos = V2(self.body:getPosition())
         local r = math.deg(self.body:getAngle())
         --update player orientation
         local angle =(math.deg(self.n:angleTo(V2(1,0)))+90)
         if math.abs(angle - self.rot)>2 then
           self.rot = angle
         end

      end
      function player:updateCollider()
          --self.collider:rotate(.01,self.pos.x,self.pos.y)
          if self.collider then
            local angle = math.rad(self.rot)
            self.collider:moveTo(self.pos.x+(h/2-r)*math.sin(angle),self.pos.y-(h/2-r)*math.cos(angle))
            self.collider:setRotation(angle)
          end

      end
      function player:eventPoll()

          local v=V2(self.body:getLinearVelocity())
          local speed = v:len()

          if love.keyboard.isDown("a") and speed <maxSpeed then
              self.scaleX = -1
              self.body:applyLinearImpulse( -10*self.t.x, -10*self.t.y )
          end

          if love.keyboard.isDown("d") and speed < maxSpeed then
              self.scaleX = 1
              self.body:applyLinearImpulse( 10*self.t.x, 10*self.t.y)
          end
          if love.keyboard.isDown("w") and self.isOnGround  then
              self.body:applyLinearImpulse( 0, -200 )
          end
          if love.keyboard.isDown("s") then
              self.body:applyLinearImpulse( 0, 2 )
          end


          if (love.keyboard.isDown("a","s","d","w")) == false and self.isOnGround == true then
              self.body:setLinearVelocity(v.x*.2,v.y)

          end

      end

    
      --player.body:setPreSolve(function(me,other,contact)
        --if other.collision_class == "Ground" then print("on ground")end

      --end)

      function player:onCollisionStay(other)
          --print("stay in col")

      end
      function player:onCollisionEnter(other)
          --print("enter col snell")
      end
      function player:onCollisionExit(other)
          --print("exit col")
      end
      ----function for body collision
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
      function player:draw()
          love.graphics.draw(self.sprite,self.pos.x,self.pos.y,math.rad(self.rot),
          self.scaleX*self.scale,self.scale*self.scaleY,
          self.sprite:getWidth()* self.origin.x,
          self.sprite:getHeight()*self.origin.y)

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
