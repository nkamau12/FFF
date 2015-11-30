local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

--Sends user to the bonus menu screen
local function adieu(event)
	if ( "ended" == event.phase ) then
		local options = {
			isModal = true,
			effect = "crossFade",
			time = 500
		}
		composer.gotoScene("BonusMenu",options)
	end
end

--Opens a new overlay to prompt the user whether they want to create a new search or rescue level
local function pickType(event)
	if ( "ended" == event.phase ) then
		local options = {
			isModal = true,
			effect = "fade",
			time = 400
		}
		composer.showOverlay("create_level",options)
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

    --home button
	local home = display.newRect(display.contentCenterX, display.contentCenterY,display.contentWidth,display.contentHeight)
	home:setFillColor(white, 0.01)
	sceneGroup:insert(home)
	home:addEventListener("touch", gohome)

	local background = display.newRect(display.contentCenterX, display.contentCenterY,1920-888,300)
	background:setFillColor(0.04, 0.38, 0.37, 0.75)
	sceneGroup:insert(background)

	local text=display.newText("Select an option",display.contentCenterX,display.contentCenterY - 75)
	sceneGroup:insert(text)	

	--play button
	local play = widget.newButton
	{
		width = 250,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Play Level",
		onEvent = adieu,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(play)
	play.x=display.contentCenterX - 200
	play.y=display.contentCenterY + 50

	--create button
	local create = widget.newButton
	{
		width = 250,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Create Level",
		onEvent = pickType,
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