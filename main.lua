function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
--[[
local settings = {
  2000,------high Score
  1,------voilume

}
]]

if not love.filesystem.isFile( "f" ) then
    love.filesystem.write("f", "0.5 0")
end

-----load setting data
local data = love.filesystem.read("f")

local data =split(data," ")
local volume = tonumber(data[1])
local mute = tonumber(data[2])
if mute == 1 then mute = true else mute = false end

---------------------------------------------
local Game = require("game")
local game = Game()
game.musicPlayer.volume = volume
game.musicPlayer.mute = mute
game:start()
