love = lutro

require("intro")
require("menu")
require("space")
require("splash")
require("mission01")

WIDTH = 320
HEIGHT = 240
SCALE = 1

pause = false
mute = true
gamestate = 0
selection = 0
submenu = 0

use_music = true

splash_duration = 3--00

save_names = nil

au_level = 0.01

dialog_line_no = 1
dialog_char_no = 1

function love.conf(t)
	t.width = WIDTH
	t.height = HEIGHT
end

function love.load()
  print("LOAD")
	math.randomseed(os.time())

  loadSavegames()

	--TODO add gothic and symbol font
	-- - https://www.dafont.com/de/pixel-icons-compilation.font?text=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&fpp=200&sort=date&l[]=10&l[]=1&back=bitmap
  -- - https://www.dafont.com/de/owrekynge.font?text=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789%24%A2%80%A3%A5-%2A%2F%3D%25%27%23%40%26_%28%29%2C.%3B%3A%3F%21%7C%7B%7D%3C%3E%5B%5D%A7%5E%7E&fpp=200&sort=date&l[]=10&l[]=1&back=bitmap
	imgfont = love.graphics.newImageFont("gfx/imgfont.png"," abcdefghijklmnopqrstuvwxyz0123456789$-*/=%'#@&_(),.;:?!|{}<>[]^~")
	love.graphics.setFont(imgfont)

	--TODO version file for bash build naming
	--TODO dist folder with incremental builds
  loadAudio()

	loadIntro()
  loadSpace()
  loadSplash()
	loadMission01()

  au_intro:play()

	updateScale()
	restart()
end


function restart()
	print("RESTART")
	gamestate = 0
end


function love.draw()
	--NOTE MAYBE BITONALIZE EVERYTHIN (only 2 colors: b/w no grey) with a pallette: https://lospec.com/palette-list/1bit-monitor-glow
	love.graphics.clear()
	love.graphics.scale(SCALE,SCALE)
  if gamestate == 0 then
    drawIntro()
  elseif gamestate == 1 then
    drawSpace()
    drawMenu()
  elseif gamestate == 2 then
		drawMission01()
  end
  love.graphics.printf("dl:" .. dialog_line_no .. " gs:" .. gamestate .. " sm:".. submenu,0,0,WIDTH,"right")

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
		updateMission01(dt)
    -- TODO mock tutorial driving mission 1
		-- TODO driving mission 1
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
		if key == "a" or key == "start" then
			print("dln:"..dialog_line_no.." dll:"..table.getn(dialog_lines))
			if dialog_line_no ~= table.getn(dialog_lines) then
				print("update dlln")
				dialog_line_no = dialog_line_no + 1
				dialog_char_no = 1
			end
		end

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

function draw_debug_fonts()
	local str01 = " aabbccddeeffgghhiijjkkllmmnnooppqrstuvwxyz"
	local str02 = "0123456789"
	local str03 = "$-*/=%'#@&_()"
	local str04 = ",.;:?!|{}<>[]^~"
	love.graphics.printf(str01, 0, 20, WIDTH, "left")
	love.graphics.printf(str02, 0, 30, WIDTH, "left")
	love.graphics.printf(str03, 0, 40, WIDTH, "left")
	love.graphics.printf(str04, 0, 50, WIDTH, "left")
end
