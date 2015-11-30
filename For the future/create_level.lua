local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

--Sends user to the build search screen
local function createSearch(event)
	if ( "ended" == event.phase ) then
		local options = {
			isModal = true,
			effect = "crossFade",
			time = 500
		}
		composer.gotoScene("Build_Search",options)
	end
end

--Sends user to the build rescue screen
local function createRescue(event)
	if ( "ended" == event.phase ) then
		local options = {
			isModal = true,
			effect = "crossFade",
			time = 500
		}
		composer.gotoScene("Build_Rescue",options)
	end
end

--Sends user back to the main menu screen
local function gohome( event )
	if ( "ended" == event.phase ) then
		composer.hideOverlay( "fade", 400 )
	end
end

function scene:create( event )

    local sceneGroup = self.view

    local home = display.newRect(display.contentCenterX, display.contentCenterY,display.contentWidth,display.contentHeight)
	home:setFillColor(white, 0.01)
	sceneGroup:insert(home)
	home:addEventListener("touch", gohome)

	local background = display.newRect(display.contentCenterX, display.contentCenterY,1920-888,300)
	background:setFillColor(0.04, 0.38, 0.37, 0.75)
	sceneGroup:insert(background)

	local text=display.newText("Select your game type",display.contentCenterX,display.contentCenterY - 75)
	sceneGroup:insert(text)	

	local play = widget.newButton
	{
		width = 250,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Search",
		onEvent = createSearch,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(play)
	play.x=display.contentCenterX - 200
	play.y=display.contentCenterY + 50

	local create = widget.newButton
	{
		width = 250,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Rescue",
		onEvent = createRescue,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(create)
	create.x=display.contentCenterX + 200
	create.y=display.contentCenterY + 50
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
    end
end


scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )

return scene