local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

function bye()
    local options = {
            effect = "crossFade",
            time = 500
        }

    timer.performWithDelay( 5000, composer.gotoScene("MainMenu",options))
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    creds = display.newImage("credits_screen.png",system.ResourceDirectory)
        creds.anchorX=0
        creds.anchorY=1
        creds.height=2448.6
        creds.width=1920
        creds.x= 0
        creds.y=2448.6
        sceneGroup:insert(creds)

    local backgroundMusic = audio.loadStream( "bensound-slowmotion.mp3")
    local backgroundMusicplay = audio.play( backgroundMusic, {  fadein = 4000, loops=-1 } )

    timer.performWithDelay( 9000, transition.moveTo(creds, { x=0, y=1080, time=20000 } ))
    
end


-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        --local background=display.newRect(display.contentCenterX,display.contentCenterY,1080,720)
        --background:setFillColor(.3,.1,.8)
        
        
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