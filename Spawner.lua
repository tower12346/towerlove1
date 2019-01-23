Spawner = Object:extend()

function Spawner:new(x1, y1, w1, h1, tx1)
	self.x = x1
	self.y = y1
	self.w = w1
	self.h = h1
	self.tx = tx1
	self.isFloor = true
end

function Spawner:update(dt)
	if player ~= nil and self.tx==lasttx and math.random() > 0.99 then
    	table.insert(tilemap2d[self.tx], Enemy(math.random(self.x, self.x+self.w), math.random(self.y, self.y+self.h)))
  end
end

function Spawner:draw()
	return false
end
