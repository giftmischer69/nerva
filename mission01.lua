function loadMission01()
  img_mechanic_portrait = love.graphics.newImage("gfx/mechanic_portrait.png")
	img_mechanic_portrait:setFilter("nearest","nearest")
  quad_mechanic_portrait = love.graphics.newQuad(0,0,150,150,img_mechanic_portrait:getDimensions())

  img_dialog = love.graphics.newImage("gfx/dialog_box.png")
	img_dialog:setFilter("nearest","nearest")
  quad_dialog = love.graphics.newQuad(0,0,320,80,img_dialog:getDimensions())

  img_bg_dialog = love.graphics.newImage("gfx/background_dialog.png")
	img_bg_dialog:setFilter("nearest","nearest")
  quad_bg_dialog = love.graphics.newQuad(0,0,320,240,img_bg_dialog:getDimensions())

  img_bg_black = love.graphics.newImage("gfx/bg_black.png")
	img_bg_black:setFilter("nearest","nearest")
  quad_bg_black = love.graphics.newQuad(0,0,320,240,img_bg_black:getDimensions())

  --TODO use a better spaceship
  img_driving_hud = love.graphics.newImage("gfx/driving_hud.png")
  img_driving_hud:setFilter("nearest","nearest")
  quad_driving_hud = love.graphics.newQuad(0,0,320,240,img_driving_hud:getDimensions())

  au_chloe_blip = love.audio.newSource("sfx/chloe_a_blip.ogg","stream")
  au_chloe_blip:setVolume(0.1)

  --a scene contains: list of drawables
  --a drawable contains: an image, a quad, x, y
  scene_black_01 = { {img_bg_black, quad_bg_black, 0, 0},
                     {img_dialog, quad_dialog, 0, 240-80}
                   }

  scene_chloey_01 = { {img_bg_dialog, quad_bg_dialog, 0, 0},
                      {img_mechanic_portrait, quad_mechanic_portrait, 320-150, 240-60-150},
                      {img_dialog, quad_dialog, 0, 240-80}
                    }

  scene_player_01 = { {img_bg_dialog, quad_bg_dialog, 0, 0},
                      {img_dialog, quad_dialog, 0, 240-80}
                    }

  scene_opportunity_01 = { {img_bg_dialog, quad_bg_dialog, 0, 0},
                      {img_driving_hud, quad_driving_hud, 0, 0},
                      {img_mechanic_portrait, quad_mechanic_portrait, 320-150, 240-60-150},
                      {img_dialog, quad_dialog, 0, 240-80}
                    }

  --a line contains: location     , character, string_line, scene
  dialog_lines = {  {"xxx"        , "xxx"    , "...hello?", scene_black_01},
                    {"gstat_base_neo_earth", "chloe"  , "hey wake up! your last job under my super-\n\nvision is coming up, and you oversleep! ...", scene_chloey_01},
                    {"gstat_base_neo_earth", "chloe"  , "you do know that if everything goes \n\nsmoothly here, you'll get your official\n\ncargo license, right?", scene_chloey_01},
                    {"gstat_base_neo_earth", "player" , "yeah... i know...", scene_player_01},
                    {"gstat_base_neo_earth", "chloe"  , "well, do you already know what your cargo\n\nalias should be for your license??", scene_chloey_01},
                    {"gstat_base_neo_earth", "player" , "todo enter name", scene_player_01},
                    {""        , ""    , "", scene_black_01},
                    {"opportunity", "chloe"  , "we got a pretty simple job on our hands\n\ntoday. we need to deliver 51 metric\n\ntons of Foodstuffs to a Nearby solar System,", scene_opportunity_01},
                    {"opportunity", "chloe"  , "we'll make 300 credits if everything goes\n\nwell...", scene_opportunity_01}
                 }

end

function updateMission01(dt)

end

function drawMission01()
  local li = dialog_lines[dialog_line_no]
  local loc = li[1]
  local chrc = li[2]
  local l_str = li[3]
  local sc = li[4]

  for k, v in pairs(sc) do
    love.graphics.draw(v[1], v[2], v[3], v[4])
  end

  love.graphics.printf(chrc .. "@" .. loc, 0, 160, WIDTH, "center")
  if dialog_char_no < string.len(l_str) then
    dialog_char_no = dialog_char_no + 1
  end
  love.graphics.printf(l_str:sub(1,dialog_char_no), 40, 185, WIDTH - 80, "left")
  if dialog_char_no % 2 == 0 and dialog_char_no < string.len(l_str) then
    print("blip: " .. dialog_char_no)
    print(dialog_char_no .. " < " .. string.len(l_str))
    au_chloe_blip:play()
  end
end
