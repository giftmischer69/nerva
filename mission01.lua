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

  img_driving_hud = love.graphics.newImage("gfx/opportunity_hud.png")
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

  --NOTE let the player choose a character sprite, display when character has lines
  -- do this when persistent storage works on the rpi
  scene_player_01 = { {img_bg_dialog, quad_bg_dialog, 0, 0},
                      {img_dialog, quad_dialog, 0, 240-80}
                    }

  scene_opportunity_01 = { {img_bg_dialog, quad_bg_dialog, 0, 0},
                      {img_driving_hud, quad_driving_hud, 0, 0},
                      {img_mechanic_portrait, quad_mechanic_portrait, 320-150, 240-60-150},
                      {img_dialog, quad_dialog, 0, 240-80}
                    }

  scene_opportunity_01 = { {img_bg_dialog, quad_bg_dialog, 0, 0},
                                        {img_driving_hud, quad_driving_hud, 0, 0},
                                        {img_mechanic_portrait, quad_mechanic_portrait, 320-150, 240-60-150},
                                        {img_dialog, quad_dialog, 0, 240-80}
                                      }
  scene_opportunity_02 = { {img_bg_dialog, quad_bg_dialog, 0, 0},
                           {img_driving_hud, quad_driving_hud, 0, 0},
                           {img_dialog, quad_dialog, 0, 240-80}
                         }
  --a line contains: location     , character, string_line, scene
  dialog_lines = {  {"xxx"        , "xxx"    , "...hello?", scene_black_01},
                    {"gstat_base_neo_earth", "chloe"  , "hey, wake\n\nup! your last job under my supervision is\n\ncoming up, and you oversleep! ...", scene_chloey_01},
                    {"gstat_base_neo_earth", "chloe"  , "you do \n\nknow, that, if everything goes smoothly\n\nhere, you'll get your ocl, right?", scene_chloey_01},
                    {"gstat_base_neo_earth", "player" , "yeah...\n\ni know...", scene_player_01},
                    {"gstat_base_neo_earth", "chloe"  , "well,\n\ndo you already know what your cargo\n\nalias should be for your license?", scene_chloey_01},
                    {"gstat_base_neo_earth", "player" , "\n\ntodo enter name", scene_player_01},
                    {""        , ""    , "", scene_black_01},
                    {"opportunity", "chloe"  , "we've got a pretty\n\nsimple job on our hands today.\n\nwe need to deliver 51 metric tons", scene_opportunity_01},
                    {"opportunity", "chloe"  , "of foodstuffs to a\n\nnearby solar system, and we'll make\n\n300 credits if everything goes well...", scene_opportunity_01},
                    {"opportunity", "player"  , "sounds great!\n\nwhen do we start?", scene_opportunity_02},
                    {"opportunity", "chloe",   "right now!\n\nand since this is the last\n\nofficially required trip", scene_opportunity_01},
                    {"opportunity", "chloe",   "for your ocl,\n\nit may also be our last trip together...\n\nyou're driving!", scene_opportunity_01},
                    {""        , ""    , "", scene_black_01}
                  }

end

function updateMission01(dt)
  --body
end

function drawMission01()
  local li = dialog_lines[dialog_line_no]
  local loc = li[1]
  local chrc = li[2]
  local l_str = chrc .. "@" .. loc .. ":~$ " .. li[3]
  local sc = li[4]

  for k, v in pairs(sc) do
    love.graphics.draw(v[1], v[2], v[3], v[4])
  end

  if dialog_char_no < string.len(l_str) then
    dialog_char_no = dialog_char_no + 1
  end

  love.graphics.printf(l_str:sub(1,dialog_char_no), 40, 181, WIDTH - 85, "left")

  if dialog_char_no % 2 == 0 and dialog_char_no < string.len(l_str) then
    au_chloe_blip:play()
  end
end
