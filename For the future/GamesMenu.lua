local parse = require( "mod_parse" )
local myData = require( "mydata" )
local composer = require( "composer" )
local JSON = require ("json")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


local function showSingle()
	audio.pause(backgroundMusicplay)
	local options = {
		effect = "fade",
		time = 500
	}
	composer.gotoScene("LevelMenu",options)
end

local function showMulti()
audio.pause(backgroundMusicplay)
	local options = {
		effect = "crossFade",
		time = 500
	}
composer.gotoScene("Credits",options)
end

local function showBonus()
	audio.pause(backgroundMusicplay)
	local options = {
		effect = "crossFade",
		time = 500
	}
		composer.gotoScene("Credits",options)
end

local function gohome( event )
    local options = {
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("MainMenu",options)
end


-- "scene:create()"
function scene:create( event )
	
	--update()
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
		local background = display.newImage("Images/theme_red/splash_main.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080
		background.width=1920
		background.x= display.contentCenterX
		background.y=display.contentCenterY
		sceneGroup:insert(background)

		--home_button
        homebutton = display.newImage("Images/home.png")
        homebutton.anchorX=0
        homebutton.anchorY=0
        homebutton.x=1700
        homebutton.y=180
        homebutton.height=121
        homebutton.width=121
        sceneGroup:insert(homebutton)
		homebutton:addEventListener( "tap", gohome )
		
		local play = display.newImage("Images/singleplayer.png")
		play.height=163
		play.width=830
		play.x = display.contentCenterX
		play.y=display.contentCenterY-180
		sceneGroup:insert(play)
		play:addEventListener( "tap", showSingle )
		
		local tut = display.newImage("Images/multiplayer.png")
		tut.height=163
		tut.width=706
		tut.x = display.contentCenterX
		tut.y=display.contentCenterY+20
		sceneGroup:insert(tut)
		tut:addEventListener( "tap", showMulti )
		
		local credit = display.newImage("Images/bonuslevels.png")
		credit.height=163
		credit.width=809
		credit.x = display.contentCenterX
		credit.y=display.contentCenterY+240
		sceneGroup:insert(credit)
		credit:addEventListener( "tap", showBonus )
		
		audio.resume(backgroundMusicplay)
		
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