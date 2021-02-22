psys_x = 0
psys_y = 0
psys_width = 100
psys_height = 100
psys_num = 100 --The max number of particles at the same time.
particles = {}

psys_speed = 5

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

function loadSpace(dt)
  for i=1,psys_num do
    p_sp_x = math.random(-1,1)
    p_sp_y = math.random(-1,1)
    particle = {psys_center_x, psys_center_y, p_sp_x, p_sp_y}
    table.insert(particles, particle)
  end
end

function updateSpace(dt)
  print("UPDATE SPACE")
  for index, value in ipairs(particles) do
    print(index, ". ", value)
    value[0] = value[0] + (value[2] * dt * psys_speed)
    value[1] = value[1] + (value[3] * dt * psys_speed)
  end
end

function drawSpace()
  for index, value in ipairs(particles) do
    --print(index, ". ", value)
    p_quad = love.graphics.newQuad(value[0],value[1],9,9,50,50)
    love.graphics.draw(imgStar,p_quad,value[0],value[1])
  end
end
