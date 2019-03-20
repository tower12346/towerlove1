Deathball = Object:extend()

function Deathball:new(x1, y1, xu, yu, tx)
	self.x = x1
	self.y = y1
	self.xu = xu
	self.yu = yu
	--self.x = self.xc + 10*xu
	--self.y = self.yc + 10*yu
	self.t = 0
	self.r = 20
	self.isFloor = false
	self.isYoyo = true
	self.isEnemy = true
	self.tx = tx
	self.delete = false
	worlds[self.tx]:add(self, self.x,self.y, self.r*2, self.r*2)
end

function Deathball:update(dt)
	goalX = self.x + -30*self.xu*math.pi*math.cos(math.pi*self.t) * dt
	goalY = self.y + -30*self.yu*math.pi*math.sin(math.pi*self.t) * dt
	self.t = self.t + dt

	self.filter = function(item, other)
  		return 'cross'
	end

	local actualX, actualY, cols, len = worlds[self.tx]:move(self, goalX, goalY, self.filter)

	self.x, self.y = actualX, actualY

	for i,v in ipairs (cols) do
		if cols[i].other.isPlayer then
			cols[i].other:ouch(5)
		end
	end

	if (self.t<0) then
		return true
	end
	return self.delete
end

function Deathball:draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.circle("fill", self.x+self.r/2, self.y+self.r/2, self.r)
end
