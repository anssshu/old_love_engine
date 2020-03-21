--local w= require("src.scenes.scene_template")
local world = require("src.components.world")
------------------------------------------------
--[[
game has one world which has 4 screens
each screens can draw scenes which can be  loaded to individual screens

game can switch screen with game:switchTo(screen)
]]
----------------game object----------------------
-----------------------------------------------------------
  local game = {
    folder = "game/",
    world = world,
    _pause = false,
    audioLib = {
      -- delcare all the sound resources
      jump = love.audio.newSource("assets/jump.mp3","static"),
    },
    ----------this is for playing background music --------------
    musicPlayer = {
      mute = false,
      volume = 1,
      audio = love.audio.newSource("assets/bg.wav","stream"),
      play = function(self)
        love.audio.play(self.audio)
        love.audio.setVolume(self.volume)
        self.audio:setLooping(true)
      end,
      replay = function(self)
        love.audio.rewind( self.audio )
        self:play()
      end
    },
  }
  function game:playSound(music)
      love.audio.play(game.audioLib[music])
  end
  --------------------------game start function--------
  function game:start()
    function love.load()
      -----------------set global objects--------
    	_G.world = game.world
    	_G.game = game
      -----------------------------------
    	game:gotoStartScreen()


      --self.musicPlayer:play()
    	game:draw()
    	game:eventPoll()
      game:update(dt)
    end---end of load func

  end
----------------------methods for game object---------------
  function game:gotoStartScreen()
      self:loadScreens()
      self:switchTo("startScreen")
      self.musicPlayer.audio:stop()
  end
  -----------------------------------------------------------
  function game:play()------for playing the first scene
      -------start over from the first scene ----------------
      if self.world.level ~= 1 then
        self.world:loadScene("src.scenes.level0","mainScreen")
      end
      self:switchTo("mainScreen")
      self.musicPlayer:play()
  end
  ----play the current level
  -----------------------------------------------------------
  function game:restart()
      self:switchTo("mainScreen")
      self.musicPlayer:replay()
  end
  -----------------------------------------------------------
  function game:gameOver()
      self:switchTo("gameoverScreen")
      self.musicPlayer.audio:stop()
  end
  -----------------------------------------------------------
  function game:pause()
      self._pause = true
      game.musicPlayer.audio:pause()
  end
  -----------------------------------------------------------
  function game:resume()
    self._pause = false
    game.musicPlayer.audio:resume()
  end
  -----------------------------------------------------------

  function game:togglePasue()
    game._pause = not game._pause
    if not game._pause then game.musicPlayer.audio:resume() end
    if game._pause then game.musicPlayer.audio:pause() end
  end
-----------------------------------------------------------
  function game:switchTo(screen)
      self.world:switchTo(screen)
  end
-----------------------------------------------------------
  function game:quit()
    love.event.quit()
    --os.exit()
  end
-----------------------------------------------------------

  function game:loadScreens()

      self.world:loadScene("src.scenes.startScene","startScreen")
      self.world:loadScene("src.scenes.level0","mainScreen")
      self.world:loadScene("src.scenes.gameoverScene","gameoverScreen")
      self.world:loadScene("src.scenes.settingsScene","settingsScreen")
      self.world:loadScene("src.scenes.levelSelectScene","levelScreen")

  end
  -----------game update function------------
function game:update(dt)
      function love.update(dt)
        if not game._pause then
      		game.world:update(dt)
      	end
        ------when game is paused ----update the ui elements
        if game._pause then
            --update hud-------------
            world:find("Hud"):update(dt)
        end

        if game.musicPlayer.mute then
          love.audio.setVolume(0)
        else
          love.audio.setVolume(self.musicPlayer.volume)
        end

      end
end
--------------game. draw ----------
function game:draw(dt)
  function love.draw()
  	game.world:draw()
  end
end
------------event polling---------------
function game:eventPoll()
  function love.keypressed(key)
  	if key == "space" and game.world.currentScreen == "mainScreen"then
  			game:togglePasue()
  	end

  	if key =="r" then
  		game:restart()
  	end
  	if key == "q" then
  		game:quit()
  	end
  end
  love.mousepressed = function(x, y, button)
  	-- pretty sure you want to register mouse events
  end
  love.mousereleased = function(x, y, button)

  end
  love.wheelmoved = function(x, y)

  end

end
----------------------------------------
local module =function()
  return game
end

return module
-----------------------------------------------------------
