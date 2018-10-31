Bullet = Object:extend()

function Bullet:new(x1, y1, xv1, yv1, world, bullets)
	self.x = x1
	self.y = y1
	self.xv = xv1
	self.yv = yv1
	self.t = 3
	self.w = 3
	self.h = 3
	self.isFloor = true
	self.isBullet = true
	world:add(self, self.x,self.y, self.w, self.h)
end

function Bullet:update(dt)
	goalX = self.x + self.xv * 500 * dt
	goalY = self.y + self.yv * 500 * dt
	self.t = self.t - dt

	self.filter = function(item, other)
		if other.isBullet then 
  			return 'touch'
  		else 
  			return 'slide'
		end	
	end

	local actualX, actualY, cols, len = world:move(self, goalX, goalY, self.filter)
	self.x, self.y = actualX, actualY
	if (self.t<0) then
		return true
	end
end

function Bullet:draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end