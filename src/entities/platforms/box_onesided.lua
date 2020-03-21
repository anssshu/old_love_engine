

local onesided = function(pWorld,x,y,w,h)
      local pWorld = pWorld
      local platform ={
        x= x or 100,
        y=y or 400,
        width = w or 200,
        height = h or 20
      }
      platform.body = pWorld:newRectangleCollider(
                        platform.x,platform.y,
                        platform.width,platform.height
                      )
      platform.body:setType("static")
      platform.body:setCollisionClass("BoxOnsided")

      platform.body:setPreSolve(function(me,other,contact)
        local p,q
        p,q=contact:getNormal()
        if q >-.1 then contact:setEnabled(false)end
      end)
      
      return platform

  end

return onesided
