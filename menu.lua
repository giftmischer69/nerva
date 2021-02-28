
function drawMenu()
  if submenu == 0 then
    drawSplash()
  elseif submenu == 1 then
    love.graphics.printf("select savegame",0,22,WIDTH,"center")
    if selection > 2 then selection = 0
    elseif selection < 0 then selection = 2 end

    for i = 0,2 do
      if i == selection then
        love.graphics.printf("* "..save_names[i+1].." *",0,42+i*13,WIDTH,"center")
      else
        love.graphics.printf(save_names[i+1],0,42+i*13,WIDTH,"center")
      end
    end
  end
end
