local composer = require( "composer" )
local widget = require( "widget" )
local JSON = require ("json")

local scene = composer.newScene()
local function tryagain(event)
	composer.hideOverlay( "fade", 400 )
	update()
end
local function back(event)
	composer.hideOverlay( "fade", 400 )
	local options = {
		effect = "fade",
		time = 500
	}
	composer.gotoScene("Splash",options)
end

function update()
    local path = system.pathForFile( "agree.json", system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = JSON.encode("1")
        file:write( contents )
        io.close( file )
        return true
    else
        return false
    end
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
	sceneGroup:insert(background)
	local trial=display.newText("User information will be \n recorded during gameplay ",display.contentCenterX,display.contentCenterY)
	sceneGroup:insert(trial)	
	local Accept = widget.newButton
	{
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Accept",
		onEvent = tryagain,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(Accept)
	Accept.x=display.contentCenterX-110
	Accept.y=display.contentCenterY+150
	
	local decline = widget.newButton
	{
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Decline",
		onEvent = back,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(decline)
	decline.x=display.contentCenterX+110
	decline.y=display.contentCenterY+150
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