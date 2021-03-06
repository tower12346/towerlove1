Spawner = Object:extend()

function Spawner:new(x1, y1, w1, h1, hp1, tx1, prob)
	self.x = x1
	self.y = y1
	self.w = w1
	self.h = h1
	self.hp = hp1
	self.tx = tx1
	self.isFloor = true
	self.prob = prob
	if self.prob==nil then
		self.prob = 0.99
	end
end

function Spawner:update(dt)
	if player and self.tx==lasttx and math.random() > self.prob and (player.x<self.x or player.x>self.x+self.w) then
    	table.insert(tilemap2d[self.tx], Enemy(math.random(self.x, self.x+self.w), math.random(self.y, self.y+self.h), self.hp))
  end
end

function Spawner:draw()
	return false
end
