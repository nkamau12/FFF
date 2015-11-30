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

--Sends user to the levels menu screen
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

--Sends user to the bonus menu screen
local function normalMenu()
	audio.pause(backgroundMusicplay)
	local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
	composer.gotoScene("BonusMenu",options)
end

--Opens an overlay to prompt the user whether they want to play an existing bonus level or create a new one
local function bestMenu()
	local options = {
		isModal = true,
		effect = "fade",
		time = 400
	}
	print("hi")
	composer.showOverlay("bonus_menu",options)
end

--Sends user back to the main menu screen
local function gohome( event )
    local options = {
    	isModal = true,
        effect = "crossFade",
        time = 500
    }
    composer.gotoScene("MainMenu",options)
end


function scene:create( event )
end


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
		--play button
		play = display.newImage("Images/singleplayer.png")
		play.height=163
		play.width=830
		play.x = display.contentCenterX
		play.y=display.contentCenterY-120
		sceneGroup:insert(play)
		play:addEventListener( "touch", showSingle )
		--bonus button
		bonus = display.newImage("Images/bonuslevels.png")
		bonus.height=163
		bonus.width=809
		bonus.x = display.contentCenterX
		bonus.y=display.contentCenterY+180
		sceneGroup:insert(bonus)

		--depending on whether the user is the #1 player, this sets the listener for bonus to either the standard menu or the play/create overlay
		if(myData.isLeader == 1) then
			bonus:addEventListener( "tap", bestMenu )
		elseif(myData.isLeader == 0) then
			bonus:addEventListener( "tap", normalMenu )
		end
		
		audio.resume(backgroundMusicplay)
		
    elseif ( phase == "did" ) then
    end
end


function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    	--for some reason sometimes the hidden scenes keep listening to taps even if isModal is set to true, 
    		--so this removes all listeners as soon as the user exits the scene

        homebutton:removeEventListener( "tap", gohome )
        play:removeEventListener( "touch", showSingle )
        if(myData.isLeader == 1) then
			bonus:removeEventListener( "tap", bestMenu )
		elseif(myData.isLeader == 0) then
			bonus:removeEventListener( "tap", normalMenu )
		end
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