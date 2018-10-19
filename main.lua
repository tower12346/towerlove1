function makePlatform(x1, y1, w1, h1, iF)
	local platform = {
		x = x1,
		y = y1,
		w = w1,
		h = h1,
		isFloor = iF
	}
	return platform
end

function love.load()
	bump = require 'bump'
	world = bump.newWorld()

	player = {
		x = 1,
		y = 500,
		yv = 0,
		yt = 0,
		w = 10,
		h = 10
	}

	platforms = {
		makePlatform(50,450,30,30,true), 
		makePlatform(100,400,30,30,true), 
		makePlatform(150,350,30,30,false)
	}

	floor = {
		x = 1,
		y = 510,
		w = 510,
		h = 10,
		isFloor = true
	}
	world:add(player, player.x, player.y, player.w, player.h)
	for i,v in ipairs (platforms) do
		world:add(platforms[i], platforms[i].x, platforms[i].y, platforms[i].w, platforms[i].h)
	end
	world:add(floor, floor.x, floor.y, floor.w, floor.h)
end

local playerFilter = function(item, other)
  --if     other.isCoin   then return 'cross'
  --elseif other.isWall   then return 'slide'
  --elseif other.isExit   then return 'touch'
  --elseif other.isSpring then return 'bounce'
  --end
  -- else return nil
  return 'slide'
end

function love.update(dt)
	local goalX = player.x 
	local goalY = player.y
	if love.keyboard.isDown("right") then
		goalX = player.x + 100 * dt
	elseif love.keyboard.isDown("left") then
		goalX = player.x - 100 * dt
	end

	if love.keyboard.isDown("up") then
		player.yv = 2
	end
	goalY = player.y - player.yv*player.yt + 0.1*player.yt^2
	local actualX, actualY, cols, len = world:move(player, goalX, goalY)
	player.yt = player.yt + 1
	for i,v in ipairs (cols) do	
		if cols[i].other.isFloor and cols[i].normal.y == -1 then
	    	player.yt = 0
			player.yv = 0
		end
	end

	player.x, player.y = actualX, actualY
end

function love.draw()
	love.graphics.print(math.floor(player.x).." " .. math.floor(player.y) .." ".. math.floor(player.yt) .. " " .. math.floor(player.yv), 400, 300)
    love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
    for i, v in ipairs (platforms) do
    	love.graphics.rectangle("fill", platforms[i].x, platforms[i].y, platforms[i].w, platforms[i].h)
    end
end