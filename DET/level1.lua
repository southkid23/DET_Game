-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

local score = 0 
local tick = 400
--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- create a grey rectangle as the backdrop
	local background = display.newRect( 0, 0, screenW, screenH )
	background.anchorX = 0
	background.anchorY = 0
	background:setFillColor( .5 )
	
	-- create a grass object and add physics (with custom shape)
	local grass = display.newImageRect( "grass.png", screenW, 82 )
	grass.anchorX = 0
	grass.anchorY = 1
	grass.x, grass.y = 0, display.contentHeight

	local rings = display.newImageRect("Rings.png", 30, 30)
	rings.x, rings.y = 160, -100
	rings.rotation = 20


	physics.addBody( rings, { density=1.0, friction=0.3, bounce=0.3 } )


	-- To make rings drop randomly around the top of the screen 
local function loadRings()

	local whereFrom = math.random(3)
	ringsTable[numRings].myName="ring"
	
	if(whereFrom==1) then
		rings.x = -50
		rings.y = (math.random(display.contentHeight *.75))
		transition.to(rings, {x= (display.contentWidth +100),
		y=(math.random(display.contentHeight)), time =(math.random(5000, 10000))})
	elseif(whereFrom==2) then
		rings.x = (math.random(display.contentWidth))
		rings.y = -30
		transition.to(rings, {x= (math.random(display.contentWidth)),
		y=(display.contentHeight+100), time =(math.random(5000, 10000))})
	elseif(whereFrom==3) then
		rings.x = display.contentWidth+50
		rings.y = (math.random(display.contentHeight *.75))
		transition.to(rings, {x= -100,
		y=(math.random(display.contentHeight)), time =(math.random(5000, 10000))})
	end	
		
end

local function gameLoop()
	loadRings()

		if score > 2000 and tick >350 then
			tick = 350
		elseif score > 5000 and tick > 300 then
			tick = 300
		elseif score> 10000 and tick > 250 then
			tick = 250
		elseif score > 15000 and tick > 200 then
			tick = 200
		elseif score > 20000 and tick > 150 then 
			tick = 150
		elseif score > 25000 and tick > 100 then
		 tick = 100
	end
end
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local grassShape = { -halfW,-34, halfW,-34, halfW,34, -halfW,34 }
	physics.addBody( grass, "static", { friction=0.0001, shape=grassShape } )
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( grass)
	sceneGroup:insert( rings)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
timer.performWithDelay(tick, gameLoop, 0)

-----------------------------------------------------------------------------------------

return scene