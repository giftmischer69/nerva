maf = require 'maf'


drv_speed = 0.0005

--space is a 3d map with points marking destinations

drv_pos = maf.vec3(0, 0 ,0)
drv_target = maf.vec3(0, 2.4, 3.2)
drv_dir = drv_target - drv_pos


drv_bob = 0
drv_bob_delta = -0.05
drv_bob_limit = 4

drv_finished = false

drv_exp_index = 1

--NOTE GOAL: ~ 4.37 lightyears -> 4 min 22 sec in game time
--alpha centauri {0, 2.4, 3.2}
-- 1 float = 1 lightyear
-- psys_speed = 30 when "normal speed"


function loadDriving()
  --print("LOAD DRIVING")
  loadSpaceRoad()
  imgExplosion = love.graphics.newImage("gfx/explosion.png")
	imgExplosion:setFilter("nearest","nearest")

  expl_quads = {}
  for i=0,9 do
    local e_q = love.graphics.newQuad(i*385,0,320,240,320,240)
    print("inserting"..i*320)
    table.insert(expl_quads, e_q)
  end


end

function drawDriving()
  --print("DRAW DRIVING")
  drawSpace()
  drawSpaceRoad()
  love.graphics.draw(img_driving_hud, quad_driving_hud, 0, drv_bob)
  local drv_length = drv_target - drv_pos
  love.graphics.printf("distance:"..drv_length:length(), 0, 0, WIDTH, "left")

  if drv_finished == true then
    love.graphics.draw(imgExplosion, expl_quads[math.floor(drv_exp_index)], 0, 0)
  end
end

function updateDriving(dt)

    --print("UPDATE DRIVING")
    updateSpace(dt)
    if drv_bob < 0 or drv_bob > drv_bob_limit - 0.5 then
      drv_bob_delta = -drv_bob_delta
    end
    drv_bob = drv_bob + drv_bob_delta
    updateSpaceRoad(dt)
    local drv_dist = drv_target - drv_pos
    if drv_dist:length() > 0.1 then
      drv_pos = drv_pos + (drv_dir * drv_speed)
      psys_speed = 30 * drv_speed / 0.0001
      if not au_engine:isPlaying() then
        if not mute then
          --love.audio.play(au_engine)
        end
      end
    else
      if au_engine:isPlaying() then
        au_engine:stop()
      end

      if not au_explosion:isPlaying() then
        if not mute then
          --love.audio.play(au_explosion)
        end
      end
      drv_finished = true
    end

    if drv_finished == true and psys_speed > 0.01 then
      psys_speed = psys_speed - 0.01
    end

    if drv_finished == true and math.floor(drv_exp_index) < 11 then
      drv_exp_index = drv_exp_index + 1
    end

    if math.floor(drv_exp_index) == 10 then
      drv_exp_finished = true
    end



end
