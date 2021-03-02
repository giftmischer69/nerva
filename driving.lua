


drv_speed = 0

--space is a 3d map with points marking destinations

drv_pos_x = 0
drv_pos_y = 0
drv_pos_z = 0

drv_bob = 0
drv_bob_delta = -0.05
drv_bob_limit = 4

--NOTE GOAL: ~ 4.37 lightyears -> 4 min 22 sec in game time
--alpha centauri {0, 2.4, 3.2}
-- 1 float = 1 lightyear
-- psys_speed = 30 when "normal speed"

function loadDriving()
  --print("LOAD DRIVING")
  loadSpaceRoad()
end

function drawDriving()
  --print("DRAW DRIVING")
  drawSpace()
  drawSpaceRoad()
  --love.graphics.draw(img_driving_hud, quad_driving_hud, 0, drv_bob)

  love.graphics.printf("driving", 0, 0, WIDTH, "center")
end

function updateDriving(dt)
    --print("UPDATE DRIVING")
    updateSpace(dt)
    if drv_bob < 0 or drv_bob > drv_bob_limit - 0.5 then
      drv_bob_delta = -drv_bob_delta
    end
    drv_bob = drv_bob + drv_bob_delta
end
