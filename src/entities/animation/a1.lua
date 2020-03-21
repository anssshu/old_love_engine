local json = require("lib.json")

local file =  "assets/bigeye.json"
local f2 =love.filesystem.read(file)
--[[
print(f2)
local lines = ""
local f=io.open(file)

if f == nil then f= io.open(game.folder..file) file = game.folder..file end
if  f ~= nil then
    for line in io.lines(file) do
      lines = lines..line
    end
    f:close()
end
]]
local atlas_json = json.parse(f2)
--print(lines)
--print(atlas_json)
--print(os.execute("pwd"))
--------------------------------------------
function three_dig_string(s)
  if s<10 then return "00"..s end
  if s>9 then return "0"..s end
end
function check_val_intable(vl,tbl)---check valueinside table or not
  for k,v in pairs (tbl) do
    if v == vl then return true end
 end
 return false
end
function pprint(data)for k,v in pairs(data) do print(k,v) end end
--function atlas:get(sprite)
      --return self[sprite].frame
--end
local Atlas = {}
Atlas.img = love.graphics.newImage("assets/bigeye.png")
Atlas.json = atlas_json
Atlas.frames = {}

local i = 0
local min =0
local max =0
table.sort(Atlas.json)
Atlas.anim ={}
Atlas.anim_name={}
local anim_string =""
-------------------code to calculate atlas.anim and Atlas.frames
for k,v in pairs(Atlas.json) do
  i=i+1
  Atlas.frames[i] = v.frame
  --split the keys into 2 part
  local anim_name = split(k,"_")[1]
  local anim_frame_no =tonumber(split(k,"_")[2])
  --print(i,split(k,"_")[1],tonumber(split(k,"_")[2]))
  ---------insert all animation frames names-----------------

  if anim_string ~= anim_name and not check_val_intable(anim_name,Atlas.anim) then

    anim_string = anim_name
    Atlas.anim[anim_name] = {name = anim_name,min=anim_frame_no,max=anim_frame_no,Q={},frames={}}-------append min and max farame no
    table.insert(Atlas.anim_name,anim_name)
  end

  -------------calculate the min and max frame no-------------------

    Atlas.anim[anim_name].min = math.min(Atlas.anim[anim_name].min,anim_frame_no)
    Atlas.anim[anim_name].max = math.max(Atlas.anim[anim_name].max,anim_frame_no)


    --print(k)
end
--------------------------------------------------calculate the animation quads----------------
for k,v in pairs(Atlas.anim) do
  for  j = v.min,v.max do
    table.insert(v.Q,v.name.."_"..three_dig_string(j))
  end
end

  for k,v in pairs(Atlas.anim) do
    for k2,v2 in pairs(v.Q) do
        --table.insert(v.quads,Atlas:get(v2))
        local q =Atlas.json[v2].frame
        table.insert(v.frames,love.graphics.newQuad(q.x, q.y, q.width, q.height,Atlas.img:getDimensions()))
        print(v2)
    end
  end
---------------------------------
--print(json.stringify(Atlas.anim))

function Atlas:getframe(fr_no)
 local q = self.frames[fr_no]
 return love.graphics.newQuad(q.x, q.y, q.width, q.height,self.img:getDimensions())
end

function Atlas:get(sprite)
  local q =self.json[sprite].frame
  return love.graphics.newQuad(q.x, q.y, q.width, q.height,self.img:getDimensions())
end
--print(atlas_json["./jump_000"].frame.width)





--  print(atlas[1])
local k =1
local empty = {}
local Q = Atlas.json[Atlas.anim["./running"].Q[k]].frame
local q = Atlas.anim["./running"].frames[k]
function empty:draw()
  love.graphics.draw(Atlas.img,love.graphics.newQuad(Q.x, Q.y, Q.width, Q.height,Atlas.img:getDimensions()),
  200,200-(160 - Q.height),0,1,1,50,160)
end
local FPS =120
local t = 0
function empty:update(dt)
  q = Atlas.anim["./running"].frames[k]
  Q = Atlas.json[Atlas.anim["./running"].Q[k]].frame
  t=t+dt
  --print(t)
  if t>1/FPS then t= 0
    k=k+1
    if k>50 then k =1 end
  end

end
empty.name  ="empty"
world:addTo("fgLayer",empty)
