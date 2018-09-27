function love.load()
	player = {
		x = 0,
		y = 500,
		yv = 0,
		yt = 0
	}
	platform1 = {
		x = 50,
		y = 450
	}
end

function love.update(dt)
	if love.keyboard.isDown("right") then
		player.x = player.x + 60 * dt
	elseif love.keyboard.isDown("left") then
		player.x = player.x - 60 * dt
	end

	if love.keyboard.isDown("up") then
		player.yv = 1.5
	end
	if player.yv > 0 then
		player.yt = player.yt + 1
	end
	player.y = player.y - player.yv*player.yt + 0.5*0.1*player.yt^2

    if math.floor(player.y)+10==math.floor(platform1.y) and 
    	player.x>platform1.x and 
    	player.x<platform1.x + 20 then
    	player.yv = 0
    end

    if math.floor(player.y)==math.floor(platform1.y) + 30 and
    	player.x>platform1.x and 
    	player.x<platform1.x + 20 then
    	player.yv = 0
    	player.yt = 0
    end


	if player.y>=500 then
		player.yt = 0
		player.yv = 0
		player.y = 500
	end
end

function love.draw()
	love.graphics.print(math.floor(player.x).." " .. math.floor(player.y) .." ".. math.floor(player.yt) .. " " .. math.floor(player.yv), 400, 300)
    love.graphics.rectangle("fill", player.x, player.y, 10, 10)
    love.graphics.rectangle("fill", platform1.x, platform1.y, 30, 20)
end