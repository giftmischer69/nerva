love = lutro

require("space_menu")
require("space")

WIDTH = 320
HEIGHT = 240
SCALE = 1

function love.conf(t)
	t.width = WIDTH
	t.height = HEIGHT
end

bgcolor = {0,0,0,255}
darkcolor = {217,220,242,255}

--[[
  Gamestates:
  0 ingame
  1 menu
--]]

pause = false
mute = false
gamestate = 1
selection = 0
submenu = 0

use_music = true

function love.load()
	math.randomseed(os.time())
  print(load)
  love.graphics.setBackgroundColor(bgcolor)

	--loadHighscore()
	loadResources()
	love.graphics.setFont(imgfont)
  loadSpace()
	--pl = Player.create()
	updateScale()
	restart()
end

function restart()
  print("RESTART")
  --TODO
	--pl:reset()
	--clouds = {}
	--next_cloud = 0
	--birds = {}
	--next_bird = 1
	--track_frame = 0
	--scrn_shake = 0

	--START_SPEED = difficulty_settings[difficulty][1]
	--SPEED_INCREASE = difficulty_settings[difficulty][2]
	--MAX_SPEED = difficulty_settings[difficulty][3]
	--global_speed = START_SPEED

	--train = Train.create()
	--train.alive = false
	--tunnel = Tunnel.create()
	--tunnel.alive = false
	--gorge = Gorge.create()
	--gorge.alive = false

	--score = 0
	--coffee = 0
end

function love.update(dt)
  updateSpace(dt)
	if gamestate == 0 then
		updateGame(dt)
	elseif gamestate == 1 then
		updateMenu(dt)
	end
end

function updateGame(dt)
	if pause == true then
		return
	end
  --TODO
	-- Update terrain (skyscrapers etc.)
	-- updateSpace(dt)
end


function love.draw()
	love.graphics.clear()
	love.graphics.scale(SCALE,SCALE)
	love.graphics.setColor(255,255,255,255)
	if gamestate == 0 then
		drawGame()
	elseif gamestate == 1 then
		drawMenu()
	end
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

  imgStar = love.graphics.newImage("gfx/star.png")
  imgStar:setFilter("nearest","nearest")


	imgfont = love.graphics.newImageFont("gfx/imgfont.png"," abcdefghijklmnopqrstuvwxyz0123456789.!'-:*")

	-- Load sound effects
	--auCoffee = love.audio.newSource("sfx/coffee.wav","stream")
	--auHit = love.audio.newSource("sfx/hit.wav","stream")
	--auSelect = love.audio.newSource("sfx/select.wav","stream")
	--if use_music == true then
		--auBGM = love.audio.newSource("sfx/bgm.ogg","stream")
		--auBGM:setLooping(true)
		--auBGM:setVolume(0.6)
		--auBGM:play()
	--end
end



function love.quit()
   --body
end

function love.focus(f)
	if not f and gamestate == 0 then
		pause = true
	end
end
