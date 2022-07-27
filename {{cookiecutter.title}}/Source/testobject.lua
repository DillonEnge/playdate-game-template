TestObject = {}
TestObject.__index = TestObject

-- TestObject is an example implementation of an OOP object
function TestObject:new(x, y, width, height)
	local self = Gfx.sprite:new()

	self:setSize(width, height)
	self.rect = Geom.rect.new(0, 0, self:getSize())
	self:setCenter(0, 0)

	self:setCollideRect(self.rect)

	self.collisionResponse = Gfx.sprite.kCollisionTypeBounce

	self:add()

	self:moveTo(x, y)

	function self:draw()
		Gfx.setColor(Gfx.kColorBlack)
		Gfx.fillRect(self.rect)
	end

	return self
end
