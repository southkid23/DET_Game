
local composer = require( "composer" )
local scene = composer.newScene()
local speed = 1000
local count = 10


function scene:create(event)
	local score = 0

	local background = display.newImage("clouds.jpg")
	background.x = 0
	background.y = 240
	textScore = display.newText("Score: "..score, 50, -0, nil, 12)
   	textScore:setTextColor(1,1,1)

<<<<<<< HEAD
   	local rect = display.newRect(160, 530, display.contentWidth, 10)
=======
   	local rect = display.newRect(160, 580, display.contentWidth, 10)
>>>>>>> soundtest
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
		local SoundFx = audio.loadSound("Ring_Sound.mp3")
		audio.play( SoundFx )
		score = score + 1
		updateText()
	end
	return true
end

function onCollision(event)
	if((event.object1.myName=="ring" and event.object2.myName=="obj") or
	(event.object1.myName=="obj" and event.object2.myName=="ring")) then
		timer.performWithDelay( 100, function() physics.stop() end, 1 )
<<<<<<< HEAD
=======
		audio.pause( gameMusic )
		local LoseFx = audio.loadSound("WWWamp.mp3")
		audio.play(LoseFx)
>>>>>>> soundtest
		local single = display.newImage("forever-alone.jpg")
		single:scale(.5, .5)
		single.x = 160
		single.y = 260
	end
end

scene:addEventListener( "create", scene )
Runtime:addEventListener("collision", onCollision)
newText()
timer.performWithDelay(1000, drops, 10)
timer.performWithDelay(10000, delayRings, 2)

return scene