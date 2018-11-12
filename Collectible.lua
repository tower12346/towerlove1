Collectible = Object:extend()

function Collectible:new(x1, y1, bps, tx1)
	self.x = x1
	self.y = y1
	self.radius = 5
	self.tx = tx1
	self.delete = false
	self.bpowers = bps
	self.isCollectible = true
	worlds[self.tx]:add(self, self.x, self.y, self.radius*2, self.radius*2)
end

function Collectible:update(dt)
	return self.delete
end

function Collectible:bestow(powers)
	for i, v in ipairs (self.bpowers) do
		powers[i] = self.bpowers[i]
	end
	self.delete = true
	return powers
end

function Collectible:draw()
	love.graphics.setColor(0, 0, 255)
	love.graphics.circle("fill", self.x, self.y, self.radius)
end