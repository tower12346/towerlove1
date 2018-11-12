Boss = Enemy:extend()

function Boss:new(x1, y1, tx1)
	self.x = x1
	self.y = y1
	self.yv = 0
	self.yt = 0
	self.w = 100
	self.h = 100
	self.tx = tx1
	self.hp = 10000
	self.isEnemy = true
	worlds[self.tx]:add(self, self.x,self.y, self.w, self.h)
end

function Boss:update(dt)
	if Boss.super.update(self, dt) then
		self.hp = self.hp - 1
	end

	if self.hp <= 0 then
		return true
	end

	if math.random() > 0.99 then
		table.insert(tilemap2d[self.tx], EnemyBullet(self.x-10, self.y, -2, 0, self.tx))
		table.insert(tilemap2d[self.tx], EnemyBullet(self.x-10, self.y+(self.h/2), -2, 0, self.tx))
		table.insert(tilemap2d[self.tx], EnemyBullet(self.x-10, self.y+(self.h-10), -2, 0, self.tx))
		table.insert(tilemap2d[self.tx], EnemyBullet(self.x+self.w, self.y, 2, 0, self.tx))
		table.insert(tilemap2d[self.tx], EnemyBullet(self.x+self.w, self.y+(self.h/2), 2, 0, self.tx))
		table.insert(tilemap2d[self.tx], EnemyBullet(self.x+self.w, self.y+(self.h-10), 2, 0, self.tx))
		table.insert(tilemap2d[self.tx], EnemyBullet(self.x+self.w, self.y - self.h, 0, -2, self.tx))
		table.insert(tilemap2d[self.tx], EnemyBullet(self.x+self.w/2, self.y - self.h, 0, -2, self.tx))
		table.insert(tilemap2d[self.tx], EnemyBullet(self.x, self.y - self.h, 0, -2, self.tx))
	end
end

function Boss:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.print('Boss HP:' .. self.hp, 400, 320)
	Boss.super.draw(self)
end