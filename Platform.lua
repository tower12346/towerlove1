Platform = Object:extend()

function Platform:new(x1, y1, w1, h1, tx1)
	self.x = x1
	self.y = y1
	self.w = w1
	self.h = h1
	self.tx = tx1
	self.isFloor = true
	worlds[self.tx]:add(self, self.x, self.y, self.w, self.h)
end

function Platform:update(dt)
	return false
end

function Platform:draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
