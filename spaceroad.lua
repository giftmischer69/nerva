psys_x = 0
psys_y = 0
psys_width = 320
psys_height = 240
--psys_num = 600 --The max number of particles at the same time.
psys_speed = 30
psys_time_alive = 20

particles = {}

psys_center_x = psys_x + (psys_width / 2)
psys_center_y = psys_y + (psys_height / 2)

psys_fade_in_sec = 1

psys_particle_color_val = 240--155 --NOTE to pink

back_space = love.graphics.newQuad(0,0,320,240,512,512)

offset_x = 100
steer_x = -0.1

--one particle steering from center to left bottom
--calculate other values from that
--draw road with https://love2d.org/wiki/love.graphics.polygon
-- 4 values on the diagonals 2 l 2 r "chasing each other"

function getTimeStamp()
  return love.timer.getTime()
end

function getRandomFloatMinusOneToOne()
  temp_num = math.random() + math.random(1, 99)
  temp_num = temp_num / 50 - 1
  return temp_num
end

function loadSpaceRoad()
  imgSpace = love.graphics.newImage("gfx/space_backdrop.png")
	imgSpace:setFilter("nearest","nearest")

  for i=1,psys_num do
    p_sp_x = getRandomFloatMinusOneToOne() * psys_speed
    p_sp_y = getRandomFloatMinusOneToOne() * psys_speed
    -- a particle is a table {x position, y position, x speed, y speed, created_time}
    particle = {psys_center_x, psys_center_y, p_sp_x, p_sp_y, getTimeStamp()}
    table.insert(particles, particle)
  end
end


function updateSpaceRoad(dt)
  --offset_x = offset_x + steer_x
  --if offset_x < -100 or offset_x > 100 then
    --steer_x = -steer_x
  --end
  --print(os.time(os.date("!*t")))
  --print("UPDATE SPACE")
  for index, value in ipairs(particles) do
    --print(index, ". ", value)
    if (getTimeStamp() - value[5]) > psys_time_alive
      or value[1] < psys_x
      or value[1] > psys_width
      or value[2] < psys_y
      or value[2] > psys_height
    then

      --table.remove(particles, index)
      -- a particle is a table {x position, y position, x speed, y speed, created_time}
      value[1] = psys_center_x -- offset_x
      value[2] = psys_center_y
      value[3] = 0
      value[4] = ((getRandomFloatMinusOneToOne() / 2) + 0.5) * psys_speed
      value[5] = getTimeStamp()
    end

    --value[1] = (value[1] + (value[3] * dt)) --+ (offset_x / 200)-- % psys_width
    value[2] = (value[2] + (value[4] * dt)) -- % psys_height
  end
end

function drawSpaceRoad()
  -- defining a table with the coordinates
  -- this table could be built incrementally too
  local vertices = {100, 100, 200, 100, 150, 200}
  love.graphics.setColor(255, 0, 255)
  -- passing the table to the function as a second argument
  love.graphics.polygon('fill', vertices)
end
