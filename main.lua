function love.load()
	bump = require 'bump'
	Object = require "classic"
	require "platform"
	require "player"
	require "bullet"
	world = bump.newWorld()

	player = Player(1, 500, world)
	platforms = {
		Platform(50,450,30,30,true, world), 
		Platform(100,400,30,30,true, world), 
		Platform(150,350,30,30,true, world),
		Platform(200, 300, 30, 30, true, world),
		Platform(250, 300, 30, 30, true, world),
		Platform(1, 510, 600, 10, true, world)
	}

	bullets = {}
end

function love.update(dt)
	player:update(dt, bullets)
	for i, v in ipairs (bullets) do
    	isDead = bullets[i]:update(dt)
    	if isDead then
    		world:remove(bullets[i])
			table.remove(bullets, i)
		end
    end
end

function love.draw()
    player:draw()
    for i, v in ipairs (platforms) do
    	platforms[i]:draw()
    end
    for i, v in ipairs (bullets) do
    	bullets[i]:draw()
    end
end