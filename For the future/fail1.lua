local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()
local function tryagain(event)
	composer.hideOverlay( "fade", 400 )
end
function scene:create( event )

    local sceneGroup = self.view
	local background = display.newImage("splash_main.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080-500
		background.width=1920-888
		background.x= display.contentCenterX
		background.y=display.contentCenterY
	background:setFillColor(grey,0.5)
	sceneGroup:insert(background)
	local trial=display.newText("Sorry the scientist is not at that location",display.contentCenterX,display.contentCenterY)
	sceneGroup:insert(trial)	
	local try = widget.newButton
	{
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "TryAgain",
		onEvent = tryagain,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(try)
	try.x=display.contentCenterX
	try.y=display.contentCenterY+150
	--try:addEventListener( "tap", tryagain )
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
        parent:resetrobot()
		
    end
end

-- By some method (a "resume" button, for example), hide the overlay


scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )

return scene