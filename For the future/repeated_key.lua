local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
local myData = require( "mydata" )

--Sends user to the build search screen
local function createSearch(event)
	if ( "ended" == event.phase ) then
		local options = {
			isModal = true,
			effect = "crossFade",
			time = 500
		}
		myData.bonusShow = {}
		composer.gotoScene("Build_Search",options)
	end
end


function scene:create( event )

    local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY,1920-800,300)
	background:setFillColor(0.04, 0.38, 0.37, 0.75)
	sceneGroup:insert(background)

	local text=display.newText("Sorry! A level exactly like yours already exists!",display.contentCenterX,display.contentCenterY - 75)
	sceneGroup:insert(text)	

	local play = widget.newButton
	{
		width = 250,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Try Again",
		onEvent = createSearch,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(play)
	play.x=display.contentCenterX 
	play.y=display.contentCenterY + 50
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