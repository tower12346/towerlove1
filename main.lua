function love.load()
	bump = require 'bump'
	Object = require "classic"
	require "platform"
	require "player"
	require "bullet"
	require "Enemy"
	world = bump.newWorld()

	bullets = {}
	player = Player(1, 500, world, bullets)
	enemies = {
		Enemy(300, 500, world)
	}
	platforms = {
		Platform(50,450,30,30,true, world), 
		Platform(100,400,30,30,true, world), 
		Platform(150,350,30,30,true, world),
		Platform(200, 300, 30, 30, true, world),
		Platform(250, 300, 30, 30, true, world),
		Platform(400, 330, 30, 30, true, world),
		Platform(1, 510, 600, 20, true, world)
	}
	killCount = 0
end

function love.update(dt)
	if math.random() > 0.99 then
    	table.insert(enemies, Enemy(math.random(100, 300), 500, world))
    end

	if player~=nil and player:update(dt) then
		player = nil
	end
	
	for i, v in ipairs (enemies) do
    	if enemies[i]:update(dt) then
    		world:remove(enemies[i])
			table.remove(enemies, i)
			killCount = killCount + 1
		end
    end

	for i, v in ipairs (bullets) do
    	if bullets[i]:update(dt) then
    		world:remove(bullets[i])
			table.remove(bullets, i)
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

    for i, v in ipairs (platforms) do
    	platforms[i]:draw()
    end

    for i, v in ipairs (bullets) do
    	bullets[i]:draw()
    end

    for i, v in ipairs (enemies) do
    	enemies[i]:draw()
    end
end