
local composer = require( "composer" )
local scene = composer.newScene()
local speed = 1000
local count = 10


function scene:create(event)
	local score = 0

	local background = display.newImage("clouds.jpg")
	background.x = 0
	background.y = 240
	textScore = display.newText("Score: "..score, 25, -25, nil, 12)
   	textScore:setTextColor(1,1,1)

   	local rect = display.newRect(160, 530, display.contentWidth, 10)
   	rect.myName = "obj"
   	physics.addBody(rect, "static", {})

end

-- include Corona's "physics" library
local physics = require "physics"
physics.start()
physics.setScale(10)


local score = 0

local function newText()
   textScore = display.newText("Score: "..score, 100, 200, nil, 12)
   textScore:setTextColor(1,1,1)
end          

local function updateText()
    textScore.text = "Score: "..score
end


local function drops()

	local rings = display.newImageRect("Rings.png", 30, 30)
	rings.myName = "ring"
	rings.x, rings.y = 160, -120
	rings.rotation = 20

	rings.x = math.random(15, 300); rings.y = -70

	physics.addBody( rings, { density=1.0, friction=0.3, bounce=0.3 } )

	rings.touch = onRingTouch
	rings:addEventListener("touch", rings)

end

-- Sleeps for x milliseconds
function delayRings()

	count=count*1.4
	speed=speed/1.4
	timer.performWithDelay(speed, drops, count)
end

function onRingTouch(self, event)
	if(event.phase == "began") then
		timer.performWithDelay(1, function() self:removeSelf() end )
		score = score + 1
		updateText()
	end
	return true
end


scene:addEventListener( "create", scene )
newText()
timer.performWithDelay(1000, drops, 10)
timer.performWithDelay(10000, delayRings, 2)

return scene