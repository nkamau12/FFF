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

--Connects to App42's database and saves a JSON with the new level's information
	--The JSON will contain: username, level name, level type(Search/Rescue), answer key, main function, one function, two function, and play count
local function submitLvl()
	local dbName  = "USERS"
	local collectionName = "Bonus Levels"
	local json = {}
	json.user = myData.user
	json.level = userField.text
	json.type = myData.newType
	json.key = myData.newSearchkey
	json.keyoneone = myData.bonusShow.one[1]
	json.keyonetwo = myData.bonusShow.one[2]
	json.keyonethree = myData.bonusShow.one[3]
	json.keyonefour = myData.bonusShow.one[4]
	json.keyonefive = myData.bonusShow.one[5]

	json.keytwoone = myData.bonusShow.two[1]
	json.keytwotwo = myData.bonusShow.two[2]
	json.keytwothree = myData.bonusShow.two[3]
	json.keytwofour = myData.bonusShow.two[4]
	json.keytwofive = myData.bonusShow.two[5]

	json.keythreeone = myData.bonusShow.three[1]
	json.keythreetwo = myData.bonusShow.three[2]
	json.keythreethree = myData.bonusShow.three[3]
	json.keythreefour = myData.bonusShow.three[4]
	json.keythreefive = myData.bonusShow.three[5]
	

	json.playcount = 0
	local App42CallBack = {}
	storageService:insertJSONDocument(dbName, collectionName, json,App42CallBack)
	function App42CallBack:onSuccess(object)
		print("DocId is "..object:getJsonDocList():getDocId())
		print("Created At is "..object:getJsonDocList():getCreatedAt())
		local options = {
            isModal = true,
            effect = "crossFade",
            time = 500
        }
		composer.showOverlay("search_created",options)
		
	end
	function App42CallBack:onException(exception)
		print("Message is : "..exception:getMessage())
	end
end


local function checkLvl(event)
	if ( event.phase == "ended") then
		local dbName  = "USERS"
		local collectionName = "Bonus Levels"
		local key = "level"
		local value = userField.text
		local App42CallBack = {}
		storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)
		function App42CallBack:onSuccess(object)
			print("dbName is "..object:getDbName())
			for i=1,table.getn(object:getJsonDocList()) do
				print("DocId is "..object:getJsonDocList()[i]:getDocId())
				print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
				local options = {
                        isModal = true,
                        effect = "crossFade",
                        time = 500
                }
                composer.showOverlay("repeated_name", options)
			end
		end
		function App42CallBack:onException(exception)
			print("Message is : "..exception:getMessage())
			print("App Error code is : "..exception:getAppErrorCode())
			local errorCode = exception:getAppErrorCode()

            if(errorCode == 2601) then
                submitLvl()
            end
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
		onEvent = checkLvl,
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