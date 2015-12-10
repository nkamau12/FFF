local composer = require( "composer" )
local widget = require( "widget" )
local myData = require( "mydata" )

local scene = composer.newScene()
local function ok(event)
	composer.hideOverlay("fade",400)
end
function scene:create( event )

    local sceneGroup = self.view
	local background = display.newRect(display.contentCenterX, display.contentCenterY,1920-788,1080-600)
	background:setFillColor(grey,0.5)
	sceneGroup:insert(background)

	local success=display.newText("You need an internet connection for this feature!",display.contentCenterX,display.contentCenterY - 100)
	sceneGroup:insert(success)	

	local try = widget.newButton
	{
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Ok",
		onEvent = ok,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(try)
	try.x=display.contentCenterX
	try.y=display.contentCenterY+125
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
        --parent:tryagain()
		
    end
end

-- By some method (a "resume" button, for example), hide the overlay


scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )

return scene