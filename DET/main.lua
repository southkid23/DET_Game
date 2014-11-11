-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)


-- include Corona's "physics" library
local physics = require "physics"
physics.start()
physics.setScale(10)



local background = display.newImage("clouds.jpg")
background.x = 0
background.y = 240



local function drops()

	local rings = display.newImageRect("Rings.png", 30, 30)
	rings.x, rings.y = 160, -120
	rings.rotation = 20

	rings.x = 1 + math.random( 300 ); rings.y = -20

	physics.addBody( rings, { density=1.0, friction=0.3, bounce=0.3 } )

	rings.touch = onRingTouch
	rings:addEventListener("touch", rings)

end

function onRingTouch(self, event)
	if(event.phase == "began") then
		timer.performWithDelay(1, function() self:removeSelf() end )
	end
	return true
end

timer.performWithDelay(1000, drops, 10)