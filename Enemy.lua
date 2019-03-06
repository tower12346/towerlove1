Enemy = Object:extend()

function Enemy:new(x1, y1, hp1)
	self.x = x1
	self.y = y1
	self.hp = hp1
	self.hpmax = hp1
	self.yv = 0
	self.yt = 0
	self.w = 10
	self.h = 10
	self.tx = player.tx
	self.isEnemy = true
	self.delete = false
	worlds[self.tx]:add(self, self.x,self.y, self.w, self.h)
end

function Enemy:update(dt)
	local goalX = self.x
	local goalY = self.y
	local speed = 100
	if math.random() > 0.5 then
		goalX = goalX + speed * dt
	end
	if math.random() > 0.5 then
		goalX = goalX - speed * dt
	end

	if player and player.x<goalX then
		goalX = goalX - speed/2 * dt
	else
		goalX = goalX + speed/2 * dt
	end

	if math.random() > 0.99 or player and player.y <= goalY-50 then
		self.yv = 2
	end
	goalY = self.y - self.yv*self.yt + 0.1*self.yt^2
	local playerFilter = function(item, other)
		if other.isBullet then
			return 'cross'
		else
			return 'touch'
		end
	end
	local actualX, actualY, cols, len = worlds[self.tx]:move(self, goalX, goalY, playerFilter)
	self.yt = self.yt + 1
	for i,v in ipairs (cols) do
		if cols[i].other.isFloor and cols[i].normal.y == -1 then
	    	self.yt = 0
			self.yv = 0
		end
		if cols[i].other.isBullet then
			cols[i].other.delete = true
	    self.hp = self.hp - 1
		end
		if cols[i].other.isYoyo then
			self.hp = self.hp - 30
		end
		if cols[i].other.isPlayer then
			cols[i].other:ouch(1)
		end
	end

	self.x, self.y = actualX, actualY

	if self.hp <= 0 then
		return true
	end

	return self.delete
end

function Enemy:draw()
	love.graphics.setColor((1-self.hp/self.hpmax), self.hp/self.hpmax, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
