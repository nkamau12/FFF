local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function nextspeech()
			composer.hideOverlay( "fade", 400 )
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
		speech1= display.newImage("tutorial_search_5.png")
		speech1.anchorX=0
		speech1.anchorY=1
		speech1.x=0
		speech1.y=500
		speech1.alpha=0.9
		speech1.myName="speech1"
		local speech1X, speech1Y = speech1:localToContent( -70, -70 )
		nextb = display.newImage("next.png")
		nextb.anchorX=0
		nextb.anchorY=0
		nextb.x=speech1X+60
		nextb.y=speech1Y+170
		nextb.myName="nextb"
    -- Initialize the scene here.
	sceneGroup:insert(speech1)
	sceneGroup:insert(nextb)
	nextb:addEventListener("tap",nextspeech)
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
	local options = {
			isModal = true,
			
			params = {
			sampleVar = "my sample variable"
				}
			}
			composer.showOverlay( "SearchTutorial6", options )
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene