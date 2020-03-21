local m =function(pWorld)

  local bbox = {
      x = 10,
      y = 10,
      w = 20000,
      h = 580
    }


    bbox.b = pWorld:newLineCollider(bbox.x,bbox.y+bbox.h,bbox.x+bbox.w,bbox.y+bbox.h)
    bbox.b:setType("static")
    bbox.b.class = "Ground"
    bbox.b:setCollisionClass("Ground")

    bbox.l = pWorld:newLineCollider(bbox.x,bbox.y+bbox.h,bbox.x,bbox.y)
    bbox.l:setType("static")

    bbox.t = pWorld:newLineCollider(bbox.x,bbox.y,bbox.x+bbox.w,bbox.y)
    bbox.t:setType("static")

    bbox.r = pWorld:newLineCollider(bbox.x+bbox.w,bbox.y+bbox.h,bbox.x+bbox.w,bbox.y)
    bbox.r:setType("static")

  return bbox
end

return m
