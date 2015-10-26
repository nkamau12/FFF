local parse = require( "mod_parse" )

local composer = require( "composer" )
--local parse = require( "mod_parse" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local function showMain()
	local options = {
		effect = "fade",
		time = 500
	}
		composer.gotoScene("MainMenu",options)
end
-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
	local backgroundMusic = audio.loadStream( "bensound-scifi.mp3")
	local backgroundMusicplay = audio.play( backgroundMusic, {  loops=-1 } )
	
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
		--local background=display.newRect(display.contentCenterX,display.contentCenterY,1080,720)
		--background:setFillColor(.3,.1,.8)
		
		local background = display.newImage("title_background.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080
		background.width=1920
		background.x= display.contentCenterX
		background.y=display.contentCenterY
		sceneGroup:insert(background)
		background:addEventListener( "touch", showMain )
		
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