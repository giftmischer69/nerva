psys_x = 0
psys_y = 0
psys_width = 320
psys_height = 240
psys_num = 1000 --100 --The max number of particles at the same time.
particles = {}

psys_speed = 20

psys_center_x = psys_x + (psys_width / 2)
psys_center_y = psys_y + (psys_height / 2)

--back_space = love.graphics.newQuad(0,0,320,240,512,512)

--front_space = love.graphics.newQuad(0,224,300,94,512,512)
--track_space = love.graphics.newQuad(0,48,121,5,128,128)

-- ein particle ist ein table
-- - x position
-- - y position
-- - speed x
-- - speed y
-- (optional) - scale

function getRandomFloatMinusOneToOne()
  temp_num = math.random() + math.random(1, 99)
  temp_num = temp_num / 50 - 1
  return temp_num
end

function loadSpace()

  for i=1,psys_num do
    p_sp_x = getRandomFloatMinusOneToOne()--math.random(-1,1)
    p_sp_y = getRandomFloatMinusOneToOne()--math.random(-1,1)

    particle = {psys_center_x, psys_center_y, p_sp_x, p_sp_y}
    table.insert(particles, particle)
  end
end

function updateSpace(dt)
  --print("UPDATE SPACE")
  for index, value in ipairs(particles) do
    --print(index, ". ", value)
    value[1] = (value[1] + (value[3] * dt * psys_speed)) % psys_width
    value[2] = (value[2] + (value[4] * dt * psys_speed)) % psys_height
  end
end

function drawSpace()
  for index, value in ipairs(particles) do
    --print(index, ". ", value)
    for i, v in ipairs(value) do
      --print("- ",i, v)
    end
    --print(index, ". ", value[0], value[1], value[2], value[3])
    --love.graphics.circle("fill", value[1],value[2],1,5)   -- Draw red circle with five segments.
    love.graphics.point(value[1],value[2])
    --p_quad = love.graphics.newQuad(value[1],value[2],9,9,9,9)
    --love.graphics.draw(imgStar,p_quad,value[1],value[2])
  end
end
