local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

require("App42-Lua-API.Operator")
require("App42-Lua-API.Permission")
require("App42-Lua-API.GeoOperator")
require("App42-Lua-API.OrderByType")
require("App42-Lua-API.Operator")
local JSON = require("App42-Lua-API.JSON") 
local queryBuilder = require("App42-Lua-API.QueryBuilder")
local App42API = require("App42-Lua-API.App42API")
local ACL = require("App42-Lua-API.ACL")
App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
local storageService = App42API:buildStorageService() 



local function oops(event)
	local options = {
		isModal = true,
    	effect = "crossFade",
        time = 500
    }
	composer.gotoScene("Splash",options)
end

function scene:create( event )
    local sceneGroup = self.view
	local background = display.newRect(display.contentCenterX, display.contentCenterY,1920-888,1080-500)
	background:setFillColor(grey,0.5)
	sceneGroup:insert(background)
	local trial=display.newText("Welcome back!",display.contentCenterX,display.contentCenterY)
	sceneGroup:insert(trial)	
	local try = widget.newButton
	{
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Ok",
		onEvent = oops,
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
        --parent:tryagain()
		
    end
end

-- By some method (a "resume" button, for example), hide the overlay


scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )

return scene