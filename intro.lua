dev_splash_frames_switch = 20

-- intro image is 150 x 150
dev_splash_width = 150
dev_splash_height = 150

dev_splash_x = (320/2)-(dev_splash_width/2)
dev_splash_y = (240/2)-(dev_splash_height/2)

dev_splash_counter = 0

function loadIntro()
  img_dev_splash_f01 = love.graphics.newImage("gfx/dev_splash_01.png")
  img_dev_splash_f01:setFilter("nearest","nearest")
  img_dev_splash_f02 = love.graphics.newImage("gfx/dev_splash_02.png")
  img_dev_splash_f02:setFilter("nearest","nearest")

  dev_splash_quad_01 = love.graphics.newQuad(0, 0, dev_splash_width, dev_splash_height, img_dev_splash_f01:getDimensions())
  dev_splash_quad_02 = love.graphics.newQuad(0, 0, dev_splash_width, dev_splash_height, img_dev_splash_f02:getDimensions())
end

function updateIntro()
  dev_splash_counter = dev_splash_counter + 1
end

function drawIntro()
  love.graphics.draw(imgSpace, back_space, 0,0)
  if math.floor(dev_splash_counter / dev_splash_frames_switch) % 2 == 0 then
    --frame1
    love.graphics.draw(img_dev_splash_f01, dev_splash_quad_01, dev_splash_x, dev_splash_y)
  else
    --frame2
    love.graphics.draw(img_dev_splash_f02, dev_splash_quad_02, dev_splash_x, dev_splash_y)
  end

  love.graphics.printf("gmxr",200,150,0,"center")
  love.graphics.printf("ent.",200,160,0,"center")

end
