
local composer = require( "composer" )
local scene = composer.newScene()

local function rectCollision(self, event)
		if event.phase == "began" then
			local loseText = display.newText("You LOSE!", 150, 200)	
		end
		if event.phase == "end" then

		end
	end

function scene:create(event)
	local score = 0

	local background = display.newImage("clouds.jpg")
	background.x = 0
	background.y = 240
	textScore = display.newText("Score: "..score,50, 0, nil, 12)
   	textScore:setTextColor(1,1,1)

   	local rect = display.newRect(160, 530, display.contentWidth, 10)
   	physics.addBody(rect, "static", {})
   	rect.type = "rect"
	rect.collision = rectCollision
	rect:addEventListener("collision", rect)
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
		score = score + 1
		updateText()
	end
	return true
end


scene:addEventListener( "create", scene )
newText()
timer.performWithDelay(1000, drops, 10)

return scene