love = lutro

require("intro")
--require("splash")
--require("space")
--require("space_menu")


--TODO Core Features:
-- - minimap
-- - lazer road
-- - asteroids


WIDTH = 320
HEIGHT = 240
SCALE = 1

--bgcolor = {0, 1, 1,255} 				--NOTE check if needed
--darkcolor = {240, 246, 240,255} --NOTE check if needed

pause = false
mute = false
gamestate = 0
selection = 0
submenu = 0

use_music = false

splash_duration = 240

function love.conf(t)
	t.width = WIDTH
	t.height = HEIGHT
end

function love.load()
	math.randomseed(os.time())

	imgfont = love.graphics.newImageFont("gfx/imgfont.png"," abcdefghijklmnopqrstuvwxyz0123456789.!'-:*")
	love.graphics.setFont(imgfont)

	loadIntro()

	updateScale()
	restart()
end

function restart()
	print("RESTART")
	gamestate = 0
end

function love.draw()
	love.graphics.clear()
	love.graphics.scale(SCALE,SCALE)
	love.graphics.setColor(255,255,255,255) --NOTE: check if needed
	--[[
	  Gamestates:
	  0 intro screen
		1 splash screen
	  2 menu: savegame slots
		4 dialog
		5 driving
		6 TODO customization
	--]]
	if gamestate == 0 then
		drawIntro()
		return
	elseif gamestate == 1 then
		--dev splash
	elseif gamestate == 2 then
		--dev splash
	else
		print("GAMESTATE ELSE")
		return
	end
end

function love.update(dt)
	if gamestate == 0 then
		updateIntro()
		if dev_splash_counter > splash_duration then
			print("next gamestate")
			gamestate = gamestate + 1
			print(gamestate)
		end
	elseif gamestate == 1 then
		--dev splash
	elseif gamestate == 2 then
		--dev splash
	else

	end
  --  updateSpace(dt)
  --	if gamestate == 0 then
  --		updateGame(dt)
  --	elseif gamestate == 1 then
  --		updateMenu(dt)
  --	end
end

function updateGame(dt)
	if pause == true then
		return
	end
  --TODO
	-- Update terrain (skyscrapers etc.)
	-- updateSpace(dt)
end




function drawGame()
	-- Draw terrain (skyscrapers etc.)
	drawSpace()
  --TODO
	-- Draw pause message
	if pause == true then
		love.graphics.printf("paused",0,30,WIDTH,"center")
		love.graphics.printf("press start to continue",0,45,WIDTH,"center")
	end

end

function love.gamepadpressed(i, key)
	if key == 'a' then -- will be A most of the time
		return          -- avoid unnecessary checks
	elseif key == 'b' then
		restart()
	elseif key == 'up' then
		selection = selection-1
	elseif key == 'down' then
		selection = selection+1

	elseif key == 'start' then
		if gamestate == 1 then
			if submenu == 0 then -- splash screen
				submenu = 2 -- Jumps straight to difficulty.
				love.audio.play(auSelect)
			elseif submenu == 2 then  -- difficulty selection
				difficulty = selection+1
				--love.audio.play(auSelect)
				gamestate = 0
				restart()
			end
		end

	elseif key == 'y' then
		if gamestate == 0 then -- ingame
			gamestate = 1
			submenu = 2
			selection = 0
		elseif gamestate == 1 then
			if submenu == 0 then
				love.event.quit()
			elseif submenu == 2 then
				submenu = 0
			end
		end
		--love.audio.play(auSelect) --TODO
	end
end

function love.gamepadreleased(i, k)
	-- body
end

function updateScale()
	SCRNWIDTH = WIDTH*SCALE
	SCRNHEIGHT = HEIGHT*SCALE
	love.window.setMode(SCRNWIDTH,SCRNHEIGHT,{fullscreen=false})
end

function loadResources()
	-- Load images
	imgSpace = love.graphics.newImage("gfx/space_backdrop.png")
	imgSpace:setFilter("nearest","nearest")

	imgSplash = love.graphics.newImage("gfx/splash.png")
	imgSplash:setFilter("nearest","nearest")

	imgShipHud = love.graphics.newImage("gfx/driving_hud.png")
  imgShipHud:setFilter("nearest","nearest")


	-- Load sound effects
	--auCoffee = love.audio.newSource("sfx/coffee.wav","stream")
	--auHit = love.audio.newSource("sfx/hit.wav","stream")
	--auSelect = love.audio.newSource("sfx/select.wav","stream")
	if use_music == true then
		auBGM = love.audio.newSource("sfx/bgm_jazz.ogg","stream")
		auBGM:setLooping(true)
		auBGM:setVolume(0.6)
		auBGM:play()
	end
end



function love.quit()
   --body
end

function love.focus(f)
	if not f and gamestate == 0 then
		pause = true
	end
end
