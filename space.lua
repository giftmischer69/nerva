psys_x = 0
psys_y = 0
psys_width = 320
psys_height = 240
psys_num = 600 --The max number of particles at the same time.
psys_speed = 30
psys_time_alive = 10

particles = {}

psys_center_x = psys_x + (psys_width / 2)
psys_center_y = psys_y + (psys_height / 2)

psys_fade_in_sec = 2

psys_particle_color_val = 200--155

back_space = love.graphics.newQuad(0,0,320,240,512,512)

space_ship_hud = love.graphics.newQuad(0,0,320,240,320,240)
--front_space = love.graphics.newQuad(0,224,300,94,512,512)
--track_space = love.graphics.newQuad(0,48,121,5,128,128)

offset_x = 100
steer_x = -0.1

function getTimeStamp()
  return love.timer.getTime()
end

function getRandomFloatMinusOneToOne()
  temp_num = math.random() + math.random(1, 99)
  temp_num = temp_num / 50 - 1
  return temp_num
end

function loadSpace()

  for i=1,psys_num do
    p_sp_x = getRandomFloatMinusOneToOne() * psys_speed
    p_sp_y = getRandomFloatMinusOneToOne() * psys_speed
    -- a particle is a table {x position, y position, x speed, y speed, created_time}
    particle = {psys_center_x, psys_center_y, p_sp_x, p_sp_y, getTimeStamp()}
    table.insert(particles, particle)
  end
end


function updateSpace(dt)
  offset_x = offset_x + steer_x
  if offset_x < -100 or offset_x > 100 then
    steer_x = -steer_x
  end
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
      value[1] = psys_center_x - offset_x
      value[2] = psys_center_y
      value[3] = getRandomFloatMinusOneToOne() * psys_speed
      value[4] = getRandomFloatMinusOneToOne() * psys_speed
      value[5] = getTimeStamp()
    end

    value[1] = (value[1] + (value[3] * dt)) + (offset_x / 200)-- % psys_width
    value[2] = (value[2] + (value[4] * dt)) -- % psys_height
  end
end

function drawSpace()
  love.graphics.draw(imgSpace, back_space, 0,0)

  for index, value in ipairs(particles) do
    diff = getTimeStamp() - value[5]

    if diff < psys_fade_in_sec then
      col = (diff / psys_fade_in_sec) * psys_particle_color_val
      love.graphics.setColor(col, col, col)
      love.graphics.circle("fill", value[1],value[2],1)
    else
      love.graphics.setColor(psys_particle_color_val, psys_particle_color_val, psys_particle_color_val)
      love.graphics.circle("fill", value[1],value[2],1)
    end
    love.graphics.setColor(255,0,0)
    love.graphics.circle("fill", psys_center_x - offset_x, psys_center_y, 1)

    love.graphics.draw(imgShipHud, space_ship_hud, 0, 0)

    --love.graphics.point(value[1],value[2])
    --p_quad = love.graphics.newQuad(value[1],value[2],9,9,9,9)
    --love.graphics.draw(imgStar,p_quad,value[1],value[2])
  end
end
