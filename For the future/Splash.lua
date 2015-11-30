local myData = require( "mydata" )
local composer = require( "composer" )
local scene = composer.newScene()
local JSON = require ("json")
local loadsave = require( "loadsave" ) 

local background


-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local function showMain()
	local options = {
        isModal = true,
		effect = "crossFade",
		time = 500
	}
		  composer.gotoScene("MainMenu",options)
end

function scene:create( event )

    local sceneGroup = self.view
	local backgroundMusic = audio.loadStream( "Music/bensound-scifi.mp3")
	local backgroundMusicplay = audio.play( backgroundMusic, {  channel = 1, loops=-1 } )
end


function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        print(" ")
	    print("start Splash")

	    --sets volume level according to the user settings
		local vol = myData.musicVol / 100
		audio.setVolume(vol, {channel = 1})
		
		background = display.newImage("Images/theme_"..myData.theme.."/title_background.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080
		background.width=1920
		background.x= display.contentCenterX
		background.y=display.contentCenterY
		sceneGroup:insert(background)
		background:addEventListener( "touch", showMain )
		
    elseif ( phase == "did" ) then
    end
end


function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    background:removeEventListener( "touch", showMain )
    elseif ( phase == "did" ) then
    end
end


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