love = lutro

require("intro")
require("menu")
require("space")
require("splash")

WIDTH = 320
HEIGHT = 240
SCALE = 1

pause = false
mute = false
gamestate = 0
selection = 0
submenu = 0

use_music = true

splash_duration = 300

save_names = nil

au_level = 0.01

function love.conf(t)
	t.width = WIDTH
	t.height = HEIGHT
end

function love.load()
  print("LOAD")
	math.randomseed(os.time())

  loadSavegames()

	imgfont = love.graphics.newImageFont("gfx/imgfont.png"," abcdefghijklmnopqrstuvwxyz0123456789.!'-:*")
	love.graphics.setFont(imgfont)

  loadAudio()

	loadIntro()
  loadSpace()
  loadSplash()

  au_intro:play()

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
  if gamestate == 0 then
    drawIntro()
  elseif gamestate == 1 then
    drawSpace()
    drawMenu()
  elseif gamestate == 2 then
    --dev splash
  end
  love.graphics.printf("gs:" .. gamestate .. " sm:".. submenu,0,0,WIDTH,"right")
end

function love.update(dt)
  if gamestate == 0 then

    updateIntro()
    updateSpace(dt)
    if dev_splash_counter > splash_duration then
			gamestate = gamestate + 1
		end
	elseif gamestate == 1 then
    if au_level < 0.6 then
      au_level = au_level + 0.001 --slowly fade in if cut
    end
    auBGM:setVolume(au_level)
    if not auBGM:isPlaying() then
      auBGM:play()
    end
    updateSpace(dt)

		--dev splash
	elseif gamestate == 2 then
    if auBGM:isPlaying() then
      auBGM:stop()
    end
    -- TODO Dialog mission 1
	else
    --body
	end
end

function updateScale()
	SCRNWIDTH = WIDTH*SCALE
	SCRNHEIGHT = HEIGHT*SCALE
	love.window.setMode(SCRNWIDTH,SCRNHEIGHT,{fullscreen=false})
end

function love.gamepadpressed(i, key)
  print(selection)
  print(key)
  if gamestate == 0 then
    return
  elseif gamestate == 1 then
    if key == 'up' then
      selection = selection - 1
    elseif key == 'down' then
      selection = selection + 1
    elseif key == 'start' then
			love.audio.play(auSelect)
			if submenu == 0 then
      	submenu = 1
			elseif submenu == 1 then
				submenu = 0
				gamestate = 2
			end

    end
    return
  elseif gamestate == 2 then
    return
  end
end

function love.gamepadreleased(i, k)
	-- body
end

function loadSavegames()
  local filename = "sg.txt"
	local fh = io.open(filename, "r")
  if fh then
    --> File Found
  else
    --> File not found
    local s = "{\"xxx\", \"xxx\", \"xxx\"}"
    print("saving " .. s)
    local f = io.open(filename, "w")
    f:write(s)
    f:close()
  end

  local f = io.open(filename, "r")
  local t = f:read("*all")
  t = (loadstring or load)("return "..t)()
  save_names = t
	print(t)
  f:close()
end

function loadAudio()
--TODO blip & talking blip baba

  au_intro = love.audio.newSource("sfx/intro.ogg","stream")
  au_intro:setVolume(0.6)

  auSelect = love.audio.newSource("sfx/select.ogg","stream")
  auSelect:setVolume(0.6)

  if use_music == true then
    auBGM = love.audio.newSource("sfx/bgm.ogg","stream")
    auBGM:setLooping(true)
    auBGM:setVolume(au_level)
  end
end
