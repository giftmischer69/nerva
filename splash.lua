

function loadSplash()
  img_splash = love.graphics.newImage("gfx/splash.png")
	img_splash:setFilter("nearest","nearest")

  splash_quad = love.graphics.newQuad(0, 0, 320, 240, img_splash:getDimensions())
end

function drawSplash()
  love.graphics.draw(img_splash, splash_quad, 0,0)
  --TODO replace press

  love.graphics.printf("press start",0,210,WIDTH,"center")
end
