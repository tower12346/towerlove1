function love.load()
	bump = require 'bump'
	world = bump.newWorld()

	player = {
		x = 0,
		y = 500,
		yv = 0,
		yt = 0,
		w = 10,
		h = 10
	}
	platform1 = {
		x = 50,
		y = 450,
		w = 30,
		h = 30
	}
	floor = {
		x = 1,
		y = 500,
		w = 500,
		h = 1
	}
	world:add(player, player.x, player.y, player.w, player.h)
	world:add(platform1, platform1.x, platform1.y,  platform1.w, platform1.h)
	--world:add(floor, floor.x, floor.y, floor.w, floor.h)
end

function love.update(dt)
	local goalX = player.x 
	local goalY = player.y
	if love.keyboard.isDown("right") then
		goalX = player.x + 60 * dt
	elseif love.keyboard.isDown("left") then
		goalX = player.x - 60 * dt
	end

	if love.keyboard.isDown("up") then
		player.yv = 1
	end
	if player.yv > 0 then
		player.yt = player.yt + 1
	end
	goalY = player.y - player.yv*player.yt + 0.5*0.1*player.yt^2
	local actualX, actualY, cols, len = world:move(player, goalX, goalY)

	if actualY>=500 then
		player.yt = 0
		player.yv = 0
		actualY = 500
	end

	player.x, player.y = actualX, actualY
end

function love.draw()
	love.graphics.print(math.floor(player.x).." " .. math.floor(player.y) .." ".. math.floor(player.yt) .. " " .. math.floor(player.yv), 400, 300)
    love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
    love.graphics.rectangle("fill", platform1.x, platform1.y, platform1.w, platform1.h)
end