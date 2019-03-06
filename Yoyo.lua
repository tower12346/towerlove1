Yoyo = Object:extend()

function Yoyo:new(x1, y1, xu, yu)
	self.xc = x1
	self.yc = y1
	self.x = self.xc + 10*xu
	self.y = self.yc + 10*yu
	self.t = 0.5
	self.r = 3
	self.isFloor = true
	self.isYoyo = true
	self.tx = player.tx
	self.delete = false
	worlds[self.tx]:add(self, self.x,self.y, self.r*2, self.r*2)
end

function Yoyo:update(dt)
	goalX = self.x + math.pi*math.cos(math.pi*self.t) * dt
	goalY = self.y + math.pi*math.sin(math.pi*self.t) * dt
	self.t = self.t - dt

	self.filter = function(item, other)
  		return 'cross'
	end

	local actualX, actualY, cols, len = worlds[self.tx]:move(self, goalX, goalY, self.filter)

	self.x, self.y = actualX, actualY
	if (self.t<0) then
		return true
	end
	return self.delete
end

function Yoyo:draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.circle("fill", self.x+self.r/2, self.y+self.r/2, self.r)
end
