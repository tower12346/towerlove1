Player = Object:extend()

function Player:new(x1, y1, tx1)
	self.x = x1
	self.y = y1
	self.yv = 0
	self.yt = 0
	self.w = 20
	self.h = 20
	self.hp = 100
	self.tx = tx1
	self.xv = 100
	self.sprite = love.graphics.newImage("Butterfly.png")
	self.powers = {
		["canShootLeft"] = true,
		["canShootRight"] = true,
		["canShootUp"] = false,
		["canShootDown"] = false,
		["superjump"] = false,
		["rocket"] = true
	}

	--self.ty = 0
	self.isPlayer = true
	worlds[self.tx]:add(self, self.x,self.y, self.w, self.h)
end

function Player:update(dt)
	local goalX = self.x
	local goalY = self.y

	if love.keyboard.isDown("right") then
		goalX = self.x + self.xv * dt
	elseif love.keyboard.isDown("left") then
		goalX = self.x - self.xv * dt
	end
	if love.keyboard.isDown("up") then
		if self.powers.superjump then
			self.yv = 2.5
		else
			self.yv = 2
		end
	end
	goalY = self.y - self.yv*self.yt + 0.1*self.yt^2

	local actualX, actualY, cols, len = worlds[self.tx]:move(self, goalX, goalY)
	self.yt = self.yt + 1
	for i,v in ipairs (cols) do
		if cols[i].other.isFloor and cols[i].normal.y == -1 then
	    	self.yt = 0
			self.yv = 0
		end
		if cols[i].other.isCollectible then
			self.powers = cols[i].other:bestow(self.powers)
		end
	end

	self.x, self.y = actualX, actualY

	if self.x>800 and worlds[self.tx + 1] ~= nil then
		self.x = 1
		worlds[self.tx]:remove(self)
		self.tx = self.tx + 1
		worlds[self.tx]:add(self, self.x,self.y, self.w, self.h)
	elseif self.x<1 and worlds[self.tx - 1] ~= nil then
		self.x = 800
		worlds[self.tx]:remove(self)
		self.tx = self.tx - 1
		worlds[self.tx]:add(self, self.x,self.y, self.w, self.h)
	end

	if love.keyboard.isDown("a") and self.powers.canShootLeft then
		table.insert(tilemap2d[self.tx], Bullet(self.x-3, self.y+(self.h/2), -2, 0))
	end
	if love.keyboard.isDown('d') and self.powers.canShootRight then
		table.insert(tilemap2d[self.tx], Bullet(self.x+self.w, self.y+(self.h/2), 2, 0))
	end
	if love.keyboard.isDown('w') and self.powers.canShootUp then
		table.insert(tilemap2d[self.tx], Bullet(self.x+self.w/2, self.y - self.h, 0, -2))
	end
	if love.keyboard.isDown('s') and self.powers.canShootDown then
		if love.keyboard.isDown('v') then
			table.insert(tilemap2d[self.tx], Bullet(self.x+self.w/2, self.y + self.h, 0, -2))
		else
			table.insert(tilemap2d[self.tx], Bullet(self.x+self.w/2, self.y + self.h, 0, 2))
		end
	end

	if love.keyboard.isDown('space') then
		self.xv = 200
	else
		self.xv = 100
	end

	if self.hp <= 0 then
		return true
	end
end

function Player:ouch(wound)
	if wound==nil then
		self.hp = self.hp - 1
	else
		self.hp = self.hp - wound
	end
end

function Player:draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.print('Hit Points' .. self.hp, 700, 0)
	love.graphics.setColor(1, 1, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	love.graphics.draw(self.sprite, self.x, self.y, 0, self.w/self.sprite:getWidth(), self.h/self.sprite:getHeight())
end
