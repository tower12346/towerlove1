function love.load()
	bump = require 'bump'
	Object = require "classic"
	require "platform"
	require "player"
	require "bullet"
	require "Enemy"

	worlds = {
		bump.newWorld(),
		bump.newWorld()
	}
	tilemap2d = {
		{
			Platform(50,450,30,30, 1), 
			Platform(100,400,30,30, 1), 
			Platform(150,350,30,30, 1),
			Platform(200, 300, 30, 30, 1),
			Platform(250, 300, 30, 30, 1),
			Platform(400, 330, 30, 30, 1),
			Platform(1, 510, 800, 20, 1)
		},
		{
			Platform(50,450,30,30, 2), 
			Platform(1, 510, 800, 20, 2)
		}
	}
	player = Player(1, 500)
	killCount = 0
	lasttx = 1
end

function love.update(dt)
	if player ~= nil then
		lasttx = player.tx
	end

	if player ~= nil and math.random() > 0.99 then
    	table.insert(tilemap2d[lasttx], Enemy(math.random(100, 300), 500))
    end

	if player~=nil and player:update(dt) then
		player = nil
	end
	
	for ia, v in ipairs (tilemap2d) do
		for i, v in ipairs (tilemap2d[ia]) do
	    	if tilemap2d[ia][i]:update(dt) then
	    		if tilemap2d[ia][i].isEnemy then
	    			killCount = killCount + 1
	    		end
	    		worlds[ia]:remove(tilemap2d[ia][i])
				table.remove(tilemap2d[ia], i)
			end
	    end
	end
end

function love.draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.print('Kills:' .. killCount, 400, 310)

    if player~=nil then
    	player:draw()
    else
    	love.graphics.setColor(1, 0, 0)
    	love.graphics.print('Game Over', 400, 300)
    end

    for i, v in ipairs (tilemap2d[lasttx]) do
    	tilemap2d[lasttx][i]:draw()
    end
end