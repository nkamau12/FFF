local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

--Sends user to the login screen
local function gologin(event)
	local options = {
		isModal = true,
    	effect = "crossFade",
        time = 500
    }
	composer.showOverlay("log_user", options)
end

--Sends user to the registration screen
local function goregister(event)
	local options = {
		isModal = true,
    	effect = "crossFade",
        time = 500
    }
	composer.showOverlay("register_user",options)
end


function scene:create( event )

    local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY + 20,1920-888,1080-500)
	background:setFillColor(grey,0.5)
	sceneGroup:insert(background)

	local optionsText = 
	{
    	--parent = textGroup,
    	text = "Hi there!\n Before you continue, please log in to your account or create one if you're new!",     
    	x = display.contentCenterX,
    	y = display.contentCenterY - 150,
    	width = 1920-940,     --required for multi-line and alignment
    	font = native.systemFontBold,   
    	fontSize = 48,
    	align = "center"  --new alignment parameter
	}

	local trial=display.newText(optionsText)
	sceneGroup:insert(trial)	
	local login = widget.newButton
	{
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Log In",
		onEvent = gologin,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(login)
	login.x=display.contentCenterX - 150
	login.y=display.contentCenterY+150
	local register = widget.newButton
	{
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Register",
		onEvent = goregister,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(register)
	register.x=display.contentCenterX + 150
	register.y=display.contentCenterY+150
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