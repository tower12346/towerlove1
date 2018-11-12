EnemyBullet = Bullet:extend()

function EnemyBullet:new(x1, y1, xv1, yv1, tx1)
	self.x = x1
	self.y = y1
	self.xv = xv1
	self.yv = yv1
	self.t = 3
	self.w = 10
	self.h = 10
	self.isFloor = true
	self.isEnemy = true
	self.tx = tx1
	self.delete = false
	worlds[self.tx]:add(self, self.x,self.y, self.w, self.h)
end

function EnemyBullet:update(dt)
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

	local actualX, actualY, cols, len = worlds[self.tx]:move(self, goalX, goalY, self.filter)
	for i,v in ipairs (cols) do
		if cols[i].other.isPlayer then
			cols[i].other:ouch(20)
			return true
		end
		if cols[i].other.isBullet then
			cols[i].other.delete = true
			return true
		end
	end
	self.x, self.y = actualX, actualY
	if (self.t<0) then
		return true
	end
	return self.delete
end

function EnemyBullet:draw()
	EnemyBullet.super.draw(self)
end