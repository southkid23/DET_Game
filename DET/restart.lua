local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "game", {time=250, effect=crossFade})
	
	return true	-- indicates successful touch
end

local function rectCollision(self, event)
	if event.phase == "began" then
		local loseText = display.newText("You lose, restart to try again!", 150, 200)
	end
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

function scene:create(event)
	local sceneGroup = self.view
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

	local playBtn = widget.newButton{
		label="Restart",
		labelColor = { default={255}, over={128} },
		default="Restart.png",
		over="Restart-over.png",
		width=154, height=200,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentWidth * 0.8
	playBtn.y = display.contentHeight - 480

	sceneGroup:insert( playBtn )

end

scene:addEventListener( "create", scene )
newText()
timer.performWithDelay(1000, drops, 10)

return scene