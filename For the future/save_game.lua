local composer = require( "composer" )
local widget = require( "widget" )
local myData = require("mydata")
local scene = composer.newScene()
local JSON = require ("json")
local loadsave = require( "loadsave" ) 
local App42API = require("App42-Lua-API.App42API") 
App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
  	"4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
require("App42-Lua-API.Operator")
require("App42-Lua-API.Permission")
require("App42-Lua-API.GeoOperator")
require("App42-Lua-API.OrderByType")
require("App42-Lua-API.Operator")
local JSON = require("App42-Lua-API.JSON") 
local queryBuilder = require("App42-Lua-API.QueryBuilder")
local ACL = require("App42-Lua-API.ACL")
local storageService = App42API:buildStorageService()  

--Sends user to the login screen
local function submitLvl(event)
	if ( event.phase == "ended") then
		local dbName  = "USERS"
		local collectionName = "Bonus Levels"
		local json = {}
		json.user = myData.user
		json.level = userField.text
		json.type = myData.newType
		json.key = myData.newSearchkey
		json.keyone = myData.bonusShow.one
		json.keytwo = myData.bonusShow.two
		json.keythree = myData.bonusShow.three
		json.playcount = 0
		local App42CallBack = {}
		storageService:insertJSONDocument(dbName, collectionName, json,App42CallBack)
		function App42CallBack:onSuccess(object)
			print("dbName is "..object:getDbName())
			print("collectionName is "..object:getCollectionName())
			print("DocId is "..object:getJsonDocList():getDocId())
			print("Created At is "..object:getJsonDocList():getCreatedAt())
			print("Updated At is "..object:getJsonDocList():getUpdatedAt())
		end
		function App42CallBack:onException(exception)
			print("Message is : "..exception:getMessage())
			print("App Error code is : "..exception:getAppErrorCode())
			print("Http Error code is "..exception:getHttpErrorCode())
			print("Detail is : "..exception:getDetails())
		end
	end
end

local function userListener( event )
    if ( event.phase == "began" ) then
        -- user begins editing defaultField
        print( event.text )
    elseif ( event.phase == "ended") then
      native.setKeyboardFocus( nil )
    elseif ( event.phase == "submitted" ) then
      native.setKeyboardFocus( passField )
    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end

function scene:create( event )

    local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY - 75,1920-888,1080-500)
	background:setFillColor(0.04, 0.38, 0.37, 0.75)
	sceneGroup:insert(background)

	local optionsText = 
	{
    	--parent = textGroup,
    	text = "Fantastic! Your new level is almost ready to be submitted!",     
    	x = display.contentCenterX,
    	y = display.contentCenterY - 250,
    	width = 1920-940,     --required for multi-line and alignment
    	font = native.systemFontBold,   
    	fontSize = 48,
    	align = "center"  --new alignment parameter
	}

	local trial=display.newText(optionsText)
	sceneGroup:insert(trial)	



	local nameText = {
    	text = "Level Name: ",     
    	x = display.contentCenterX - 200,
    	y = display.contentCenterY,
    	width = 1920-940,     --required for multi-line and alignment
    	font = native.systemFontBold,   
    	fontSize = 48,
    	align = "center"  --new alignment parameter
	}
	local nametext=display.newText(nameText)
	sceneGroup:insert(nametext)

	userField = native.newTextField( display.contentCenterX + 200, display.contentCenterY, 330, 55 )
  	userField.size = nil
  	userField:resizeFontToFitHeight()
  	userField:setReturnKey( "next" )
	userField:addEventListener( "userInput", userListener )
	sceneGroup:insert(userField)


	local submit = widget.newButton
	{
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Submit",
		onEvent = submitLvl,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(submit)
	submit.x=display.contentCenterX
	submit.y=display.contentCenterY+125
	
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