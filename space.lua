front_x = 0
back_x = 0

back_space = love.graphics.newQuad(0,0,320,240,512,512)
--front_space = love.graphics.newQuad(0,224,300,94,512,512)
--track_space = love.graphics.newQuad(0,48,121,5,128,128)

function updateSpace(dt)
	--front_x = (front_x + 65*dt) % WIDTH
	--back_x = (back_x + 40*dt) % WIDTH
end

function drawSpace()
	love.graphics.draw(imgSpace,back_space,0,0)
	--love.graphics.draw(imgTerrain,back_terrain,WIDTH-back_x,0)
	--love.graphics.draw(imgTerrain,front_terrain,0-front_x,0)
	--love.graphics.draw(imgTerrain,front_terrain,WIDTH-front_x,0)
end
