--one particle steering from center to left bottom
--calculate other values from that
--draw road with https://love2d.org/wiki/love.graphics.polygon
-- 4 values on the diagonals 2 l 2 r "chasing each other"
--    \   /
--     \ /
--      X
--p5-> /_\<-p1
--p4->/___\<-p2


rsys_x = 0
rsys_y = 0
rsys_width = 320
rsys_height = 240
rsys_num = 1 --The max number of particles at the same time.
rsys_speed = 1

rsys_acc_x = 0.01
rsys_acc_y = 0.01


roads = {}

rsys_center_x = rsys_x + (rsys_width / 2)
rsys_center_y = rsys_y + (rsys_height / 2)

rsys_fade_in_sec = 1

rsys_particle_color = {255, 0, 255}

--offset_x = 100
--steer_x = -0.1


function getTimeStamp()
  return love.timer.getTime()
end

function getRandomFloatMinusOneToOne()
  local temp_num = math.random() + math.random(1, 99)
  temp_num = temp_num / 50 - 1
  return temp_num
end

function loadSpaceRoad()
  for i=1,rsys_num do
    local speed = rsys_speed * 2
    local slow_speed = rsys_speed
    --a road_trapezoid cotains 4 points each with speeds
    local road_trapezoid = {
      rsys_center_x, rsys_center_x, -speed, speed,
      rsys_center_x, rsys_center_x, -slow_speed, slow_speed,
      rsys_center_x, rsys_center_x, speed, speed,
      rsys_center_x, rsys_center_x, slow_speed, slow_speed
    }
    table.insert(roads, road_trapezoid)
  end
end


function updateSpaceRoad(dt)
  --offset_x = offset_x + steer_x
  --if offset_x < -100 or offset_x > 100 then
    --steer_x = -steer_x
  --end
  --print(os.time(os.date("!*t")))
  --print("UPDATE SPACE")


  for index, value in ipairs(roads) do
    
    value[1] = (value[1] + (value[3] * dt)) - (offset_x / 400)
    value[2] = (value[2] + (value[4] * dt))

    value[3] = value[3] + value[3] * rsys_acc_x
    value[4] = value[4] + value[4] * rsys_acc_y

    value[5] = (value[5] + (value[7] * dt)) - (offset_x / 400)
    value[6] = (value[6] + (value[8] * dt))

    value[7] = value[7] + value[7] * rsys_acc_x
    value[8] = value[8] + value[8] * rsys_acc_y

    value[9] = (value[9] + (value[11] * dt)) - (offset_x / 400)
    value[10] = (value[10] + (value[12] * dt))

    value[11] = value[11] + value[11] * rsys_acc_x
    value[12] = value[12] + value[12] * rsys_acc_y

    value[13] = (value[13] + (value[15] * dt)) - (offset_x / 400)
    value[14] = (value[14] + (value[16] * dt))

    value[15] = value[15] + value[15] * rsys_acc_x
    value[16] = value[16] + value[16] * rsys_acc_y

    --print(index, ". ", value)
    if value[1] < rsys_x
      or value[1] > rsys_width
      --or value[2] < rsys_y
      --or value[2] > rsys_height

      or value[5] < rsys_x
      or value[5] > rsys_width
      --or value[6] < rsys_y
      --or value[6] > rsys_height

      or value[9] < rsys_x
      or value[9] > rsys_width
      --or value[10] < rsys_y
      --or value[10] > rsys_height

      or value[13] < rsys_x
      or value[13] > rsys_width
      --or value[14] < rsys_y
      --or value[14] > rsys_height
    then

      value[1] = rsys_center_x - offset_x
      value[2] = rsys_center_y

      value[5] = rsys_center_x - offset_x
      value[6] = rsys_center_y

      value[9] = rsys_center_x - offset_x
      value[10] = rsys_center_y

      value[13] = rsys_center_x - offset_x
      value[14] = rsys_center_y

      local speed = rsys_speed * 2
      local slow_speed = rsys_speed

      -- -s -s
      -- -sl -sl
      -- +s -s
      -- +sl -sl

      value[3] = -speed
      value[4] = speed

      value[7] = -slow_speed
      value[8] = slow_speed

      value[11] = speed
      value[12] = speed

      value[15] = slow_speed
      value[16] = slow_speed
    end


  end

end

function drawSpaceRoad()
  -- defining a table with the coordinates
  -- this table could be built incrementally too
  for index, value in ipairs(roads) do
    love.graphics.setColor(255, 0, 255)
    love.graphics.polygon("line",
      value[1], value[2],
      value[5], value[6],
      value[9], value[10],
      value[13], value[14]
    )

  end
end
