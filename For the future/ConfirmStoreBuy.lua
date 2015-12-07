local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
local yes 


local function confirm(event)
	composer.hideOverlay( "fade", 400 )
end

local function decline(event)
	composer.hideOverlay( "fade", 400 )
end

function scene:create( event )

    local sceneGroup = self.view
	local background = display.newRect(display.contentCenterX, display.contentCenterY,1920-400,1080-400)
	background:setFillColor(grey,0.5)
	sceneGroup:insert(background)
	
	local confirm = widget.newButton
	{
		x = display.contentCenterX - 150,
		y = display.contentCenterY + 200,
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Confirm",
		onEvent = confirm,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(confirm)
	
	local decline = widget.newButton
	{
		x = display.contentCenterX + 150,
		y = display.contentCenterY + 200,
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Decline",
		onEvent = decline,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
	}	
	
	sceneGroup:insert(decline)
	
	
	--try:addEventListener( "tap", tryagain )
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
		-- Call the "resumeGame()" function in the parent scene
        
    end
end

-- By some method (a "resume" button, for example), hide the overlay


scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )

return scene