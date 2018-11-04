Enemy = Object:extend()

function Enemy:new(x1, y1, world)
	self.x = x1
	self.y = y1
	self.yv = 0
	self.yt = 0
	self.w = 10
	self.h = 10
	self.isEnemy = true
	world:add(self, self.x,self.y, self.w, self.h)
end

function Enemy:update(dt)
	local goalX = self.x 
	local goalY = self.y
	if math.random() > 0.5 then
		goalX = goalX + 100 * dt
	end
	if math.random() > 0.5 then
		goalX = goalX - 100 * dt
	end

	if math.random() > 0.99 then
		self.yv = 2
	end
	goalY = self.y - self.yv*self.yt + 0.1*self.yt^2
	local actualX, actualY, cols, len = world:move(self, goalX, goalY)
	self.yt = self.yt + 1
	for i,v in ipairs (cols) do	
		if cols[i].other.isFloor and cols[i].normal.y == -1 then
	    	self.yt = 0
			self.yv = 0
		end
		if cols[i].other.isBullet then
	    	return true
		end
	end

	self.x, self.y = actualX, actualY
end

function Enemy:draw()
	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end