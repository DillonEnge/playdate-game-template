function testDouble()
	print("--Testing double--")
	local input = 2
	local output = Utils.double(input)

	assert(output == 4)
	print("--double passed--")
end

Tests = {}

Tests[testDouble] = true
