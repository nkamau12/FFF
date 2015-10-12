local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local function showSearch1()
	audio.pause( backgroundMusicplay)
	local options = {
		effect = "fade",
		time = 500
	}
		composer.gotoScene("Search1",options)
end
-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
	
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
		
		local background = display.newImage("splash_main.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080
		background.width=1920
		background.x= display.contentCenterX
		background.y=display.contentCenterY
		sceneGroup:insert(background)
		
		
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
		local play = display.newImage("Play.png")
		play.height=180
		play.width=350
		play.x = display.contentCenterX
		play.y=display.contentCenterY-180
		sceneGroup:insert(play)
		play:addEventListener( "touch", showSearch1 )
		
		local tut = display.newImage("Tutorial.png")
		tut.height=180
		tut.width=520
		tut.x = display.contentCenterX
		tut.y=display.contentCenterY+20
		sceneGroup:insert(tut)
		tut:addEventListener( "touch", play )
		
		local credit = display.newImage("Credits.png")
		credit.height=180
		credit.width=430
		credit.x = display.contentCenterX
		credit.y=display.contentCenterY+240
		sceneGroup:insert(credit)
		credit:addEventListener( "touch", play )
		
		audio.resume( backgroundMusicplay )

		
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