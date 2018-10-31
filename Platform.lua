Platform = Object:extend()

function Platform:new(x1, y1, w1, h1, iF, world)
	self.x = x1
	self.y = y1
	self.w = w1
	self.h = h1
	self.isFloor = iF
	world:add(self, x1, y1, w1, h1)
end

function Platform:update()
end

function Platform:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end