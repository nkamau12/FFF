local parse = require( "mod_parse" )
local myData = require( "mydata" )
local widget = require( "widget" )
local composer = require( "composer" )
local JSON = require ("json")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here
-- -------------------------------------------------------------------------------
local function gohome( event )
    local options = {
    		isModal = true,
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("MainMenu",options)
end

local function logout(event)
	myData.user = nil
	myData.theme = "default"

	local options = {
    		isModal = true,
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("Splash",options)
end

-- "scene:create()"
function scene:create( event )
end


-- "scene:show()"
function scene:show( event )
	
    local sceneGroup = self.view
    local phase = event.phase
	
    if ( phase == "will" ) then
		
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

		local optionsText = {
    		text = "Logged in as "..myData.user,     
    		x = display.contentCenterX,
    		y = display.contentCenterY - 200,
    		width = 1920-940,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "center"  --new alignment parameter
		}
		local trial=display.newText(optionsText)
		sceneGroup:insert(trial)	

		local logBut = widget.newButton{
			width = 300,
			height = 100,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Log Out",
			onRelease = logout,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize=40,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
		}	
		sceneGroup:insert(logBut)
		logBut.x=display.contentCenterX
		logBut.y=display.contentCenterY+300

		
    elseif ( phase == "did" ) then
		audio.resume(backgroundMusicplay)
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