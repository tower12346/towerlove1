Bullet = Object:extend()

function Bullet:new(x1, y1, xv1, yv1)
	self.x = x1
	self.y = y1
	self.xv = xv1
	self.yv = yv1
	self.t = 3
	self.w = 3
	self.h = 3
	self.isFloor = true
	self.isBullet = true
	self.tx = player.tx
	self.delete = false
	worlds[self.tx]:add(self, self.x,self.y, self.w, self.h)
end

function Bullet:update(dt)
	goalX = self.x + self.xv * 500 * dt
	goalY = self.y + self.yv * 500 * dt
	self.t = self.t - dt

	self.filter = function(item, other)
		if other.isBullet then 
  			return 'touch'
  		elseif other.isEnemy then
  			return 'cross'
  		else
  			return 'slide'
		end	
	end

	local actualX, actualY, cols, len = worlds[self.tx]:move(self, goalX, goalY, self.filter)
	
	self.x, self.y = actualX, actualY
	if (self.t<0) then
		return true
	end
	return self.delete
end

function Bullet:draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end