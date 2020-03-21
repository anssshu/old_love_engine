
local cr_platform = function(pWorld,polyline)
  local platform ={}
  local points ={}
  --poly line made with tiled
  local polyline = polyline or {
            { x = 0, y = 0 },
            { x = 84.8485, y = -6.06061 },
            { x = 172.727, y = -21.2121 },
            { x = 218.182, y = -69.697 },
            { x = 251.515, y = -142.424 },
            { x = 269.697, y = -215.152 },
            { x = 242.424, y = -278.788 },
            { x = 200, y = -333.333 },
            { x = 154.545, y = -357.576 },
            { x = 154.545, y = -424.242 },
            { x = 230.303, y = -409.091 },
            { x = 281.818, y = -363.636 },
            { x = 312.121, y = -100 },
            { x = 233.333, y = 6.06061 },
            { x = 12.1212, y = 66.6667 },
            { x = 9.09091, y = 69.697 }
          }

  for k,v in pairs(polyline)do
      table.insert(points,v.x+1200)
      table.insert(points,v.y+540)
  end
  platform.body = pWorld:newChainCollider(pWorld,points)
  platform.body:setType("static")
  platform.body:setPreSolve(function(me,other,contact)
    local p,q
    p,q=contact:getNormal()
    if q >-.1 then contact:setEnabled(false)end
  end)

  return platform

end

return cr_platform
