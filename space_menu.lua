menu_actions = {"new game","load game","something"}

function updateMenu(dt)
	--updateSpace(dt)
end

function drawMenu()
	drawSpace()
	love.graphics.printf("TEST",0,42,WIDTH,"center")
	if submenu == 0 then
		love.graphics.draw(imgSplash,60,30) -- 60 30
	elseif submenu == 1 then
	elseif submenu == 2 then
		love.graphics.printf("select action",0,22,WIDTH,"center")
		if selection > 2 then selection = 0
		elseif selection < 0 then selection = 2 end

		for i = 0,2 do
			if i == selection then
				love.graphics.printf("* "..menu_actions[i+1].." *",0,42+i*13,WIDTH,"center")
			else
				love.graphics.printf(menu_actions[i+1],0,42+i*13,WIDTH,"center")
			end
		end
	end
end
