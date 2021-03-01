love = lutro

require("intro")
require("space")


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

dialog_line_no = 1
dialog_char_no = 1

function love.conf(t)
	t.width = WIDTH
	t.height = HEIGHT
end


function love.load()
  math.randomseed(os.time())

  loadSavegames()

  imgfont = love.graphics.newImageFont("gfx/imgfont.png"," abcdefghijklmnopqrstuvwxyz0123456789$-*/=%'#@&_(),.;:?!|{}<>[]^~")
	love.graphics.setFont(imgfont)

	loadIntro()
  loadSpace()
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
  end
  love.graphics.printf("dl:" .. dialog_line_no .. " gs:" .. gamestate .. " sm:".. submenu,0,0,WIDTH,"right")
end

function love.update(dt)
  if gamestate == 0 then
    updateIntro()
    updateSpace(dt)
	end
end

function updateScale()
	SCRNWIDTH = WIDTH*SCALE
	SCRNHEIGHT = HEIGHT*SCALE
	love.window.setMode(SCRNWIDTH,SCRNHEIGHT,{fullscreen=false})
end

------------------------------------


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
