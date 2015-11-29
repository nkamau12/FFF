local parse = require( "mod_parse" )
local myData = require( "mydata" )
local composer = require( "composer" )
local JSON = require ("json")
local scene = composer.newScene()
local App42API = require("App42-Lua-API.App42API")  
App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
local scoreBoardService = App42API.buildScoreBoardService() 
local App42CallBack = {}

local bonus
local play

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


local function showSingle( event )
	if ( event.phase == "ended" ) then
		audio.pause(backgroundMusicplay)
		local options = {
			isModal = true,
			effect = "crossFade",
			time = 500
		}
		composer.gotoScene("LevelMenu",options)
	end
end

local function normalMenu()
	audio.pause(backgroundMusicplay)
	local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
	composer.gotoScene("BonusMenu",options)
end

local function bestMenu()
	local options = {
		isModal = true,
		effect = "fade",
		time = 400
	}
	print("hi")
	composer.showOverlay("bonus_menu",options)
end

local function gohome( event )
    local options = {
    	isModal = true,
        effect = "crossFade",
        time = 500
    }
    composer.gotoScene("MainMenu",options)
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
        print("start GamesMenu")
		

		local background = display.newImage("Images/theme_"..myData.theme.."/splash_main.png",system.ResourceDirectory)
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
		
		play = display.newImage("Images/singleplayer.png")
		play.height=163
		play.width=830
		play.x = display.contentCenterX
		play.y=display.contentCenterY-120
		sceneGroup:insert(play)
		play:addEventListener( "touch", showSingle )
		
		bonus = display.newImage("Images/bonuslevels.png")
		bonus.height=163
		bonus.width=809
		bonus.x = display.contentCenterX
		bonus.y=display.contentCenterY+180
		sceneGroup:insert(bonus)
		if(myData.isLeader == 1) then
			bonus:addEventListener( "tap", bestMenu )
		elseif(myData.isLeader == 0) then
			bonus:addEventListener( "tap", normalMenu )
		end
		
		
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
        homebutton:removeEventListener( "tap", gohome )

        if(myData.isLeader == 1) then
			bonus:removeEventListener( "tap", bestMenu )
		elseif(myData.isLeader == 0) then
			bonus:removeEventListener( "tap", normalMenu )
		end
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