


local cr_platform = function(pWorld,x,y,w,h)
  local platform ={
    x= x or 400,
    y=y or 270,
    width = w or 200,
    height = h or 20
  }
  platform.body = pWorld:newRectangleCollider(
                    platform.x,platform.y,
                    platform.width,platform.height
                  )
  platform.body:setType("static")

  return platform

end

return cr_platform
