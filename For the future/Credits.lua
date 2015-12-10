local parse = require( "mod_parse" )
local composer = require( "composer" )
local myData = require( "mydata" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------
-- local forward references should go here
-- -------------------------------------------------------------------------------

function bye()
    audio.pause(backgroundMusicplay)
    local options = {
            isModal = true,
            effect = "crossFade",
            time = 500
        }
    timer.performWithDelay( 5000, composer.gotoScene("MainMenu",options))
end

-- "scene:create()"
function scene:create( event )
end


-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        print(" ")
        print("start Credits")
        
        creds = display.newImage("Images/theme_"..myData.theme.."/credits_screen.png",system.ResourceDirectory)
        creds.anchorX=0
        creds.anchorY=1
        creds.height=2615.227
        creds.width=1920
        creds.x= 0
        creds.y=2448.6
        sceneGroup:insert(creds)
        creds:addEventListener( "tap", bye )

        local backgroundMusic = audio.loadStream( "Music/bensound-slowmotion.mp3")
        local backgroundMusicplay = audio.play( backgroundMusic, {  channel = 1, fadein = 4000, loops=-1 } )

        timer.performWithDelay( 9000, transition.moveTo(creds, { x=0, y=1080, time=20000 } ))
        
    elseif ( phase == "did" ) then
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene