MovingPlatform = Platform:extend()

function MovingPlatform:new(x1, y1, w1, h1, tx1, xmin, xmax, ymin, ymax, v)
	MovingPlatform.super.new(self, x1, y1, w1, h1, tx1)
	self.xmin = xmin
	self.xmax = xmax
	self.ymin = ymin
	self.ymax = ymax
	self.xv = v
	self.yv = v
end

function MovingPlatform:update(dt)
	MovingPlatform.super.update(self, dt)
	self.x = self.x + self.xv*dt
	self.y = self.y + self.yv*dt
	if self.x<self.xmin then
		self.xv = math.abs(self.xv)
	elseif self.x>self.xmax then
		self.xv = -math.abs(self.xv)
	end
	if self.y<self.ymin then
		self.yv = math.abs(self.yv)
	elseif self.y>self.ymax then
		self.yv = -math.abs(self.yv)
	end
	local actualX, actualY, cols, len = worlds[self.tx]:update(self, self.x, self.y)

end

function MovingPlatform:draw()
	MovingPlatform.super.draw(self)
end
