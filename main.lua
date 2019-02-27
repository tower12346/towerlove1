function love.load()
	bump = require 'bump'
	Object = require "classic"
	require "platform"
	require "player"
	require "bullet"
	require "Enemy"
	require "Boss"
	require "EnemyBullet"
	require "Collectible"
	require "Spawner"
	require "MovingPlatform"

	worlds = {
		bump.newWorld(),
		bump.newWorld(),
		bump.newWorld(),
		bump.newWorld(),
		bump.newWorld()
	}

	enemhp = 30
	tilemap2d = {
		{
			Platform(50,450,30,30, 1),
			Platform(100,400,30,30, 1),
			Platform(150,350,30,30, 1),
			Collectible(150, 340, {["canShootUp"] = true}, 1),
			Platform(200, 300, 30, 30, 1),
			Collectible(200, 290, {["canShootDown"] = true}, 1),
			Platform(250, 300, 30, 30, 1),
			Platform(400, 330, 30, 30, 1),
			Platform(-20, 510, 840, 20, 1)
		},
		{
			Platform(50,450,30,30, 2),
			Platform(400,410,40,40, 2),
			Platform(120,400,50,50, 2),
			Platform(-20, 510, 840, 20, 2),
			Collectible(610, 500, {["superjump"] = true}, 2)
		},
		{
			Platform(0, 400, 500, 30, 3),
			Platform(100, 300, 500, 30, 3),
			Platform(0, 200, 500, 30, 3),
			Platform(400, 130, 30, 30, 3),
			Platform(600, 100, 30, 30, 3),
			Platform(0, 0, 10, 400, 3),
			Platform(-20, 510, 840, 20, 3),
			Collectible(610, 90, {["canShootUp"] = true}, 3),
			Spawner(200, 500, 100, 0, enemhp, 3),
			Spawner(200, 400, 100, 0, enemhp, 3),
			Spawner(200, 300, 100, 0, enemhp, 3),
			Spawner(200, 200, 100, 0, enemhp, 3)
		},
		{
			Platform(200, 100, 30, 700, 4),
			Platform(170,140, 30, 30, 4),
			Collectible(200, 70, {["canShootDown"] = true}, 4),
			Platform(-20, 510, 840, 20, 4),
			MovingPlatform(300, 200, 100, 30, 4, 290, 310, 50, 480, 50),
			MovingPlatform(500, 300, 100, 30, 4, 490, 510, 50, 480, -50),
			MovingPlatform(700, 100, 100, 30, 4, 690, 710, 50, 480, 50),
			Spawner(300, 0, 500, 0, enemhp, 4, 0.9),
			Spawner(300, 500, 300, 0, enemhp, 4)
		},
		{
			Boss(400, 400, 5),
			Platform(-20, 510, 840, 20, 5)
		}
	}
	lasttx = 3
	player = Player(1, 500, lasttx)
	--player:debug()
	killCount = 0
end

function love.update(dt)

	if love.keyboard.isDown("0") then
		love.load()
	end

	if player ~= nil then
		lasttx = player.tx
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
	love.graphics.print('Points:' .. killCount, 700, 10)

  if player then
  	player:draw()
  else
  	love.graphics.setColor(1, 0, 0)
  	love.graphics.print('Game Over', 700, 0)
  end

  for i, v in ipairs (tilemap2d[lasttx]) do
  	tilemap2d[lasttx][i]:draw()
  end
end
