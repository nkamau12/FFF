local composer = require( "composer" )
local widget = require( "widget" )
local myData = require("mydata")
local errorcount2 = myData.error2_count
local errorcount3 = myData.error3_count

local scene = composer.newScene()
local function tryagain(event)
	composer.hideOverlay( "fade", 400 )
end
function scene:create( event )

    local sceneGroup = self.view
	local background = display.newRect(display.contentCenterX, display.contentCenterY,1920-400,1080-400)
	background:setFillColor(grey,0.5)
	sceneGroup:insert(background)
	if(errorcount2 > 2 or errorcount3 > 2) then
		local errorNum
		if (errorcount2 > errorcount3) then
			errorNum = math.random(3,4)
		elseif(errorcount3 > errorcount2) then
			errorNum = math.random(5,6)
			myData.error3_count = myData.error3_count - 2
		else
			errorNum = math.random(3,6)
		end
		
		if(errorNum == 3)then
			trial = display.newText(myData.errorText3 ,display.contentCenterX,display.contentCenterY)
		elseif(errorNum == 4)then
			trial = display.newText(myData.errorText4 ,display.contentCenterX,display.contentCenterY)
		elseif(errorNum == 5)then
			trial = display.newText(myData.errorText5 ,display.contentCenterX,display.contentCenterY)
		else
			trial = display.newText(myData.errorText6 ,display.contentCenterX,display.contentCenterY)
		end
	else
		trial=display.newText("Sorry that path is blocked",display.contentCenterX,display.contentCenterY)
	end
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
		parent:resumeGame()
    end
end

-- By some method (a "resume" button, for example), hide the overlay


scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )

return scene