local composer = require( "composer" )
local widget = require( "widget" )
local myData = require( "mydata" )
local scene = composer.newScene()
local JSON = require ("json")
local loadsave = require( "loadsave" ) 
local App42API = require("App42-Lua-API.App42API") 
App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
  	"4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
local userService  = App42API:buildUserService()  

require("App42-Lua-API.Operator")
require("App42-Lua-API.Permission")
require("App42-Lua-API.GeoOperator")
require("App42-Lua-API.OrderByType")
require("App42-Lua-API.Operator")
local JSON = require("App42-Lua-API.JSON") 
local queryBuilder = require("App42-Lua-API.QueryBuilder")
local ACL = require("App42-Lua-API.ACL")
local storageService = App42API:buildStorageService()  


local App42CallBack = {}

local newUser
local newPass
local newEmail

local userField
local passField
local emailField

checkUser = ""
checkPass = nil
checkEmail = nil


local function tryregister(event)
	--"[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?" email regex
	-- pass min 8
	--create user

	newUser = userField.text
	newPass = passField.text
	newEmail = emailField.text

	checkPass = string.len(newPass)
	if (checkPass < 8) then
    	local options = {
		isModal = true,
    	effect = "crossFade",
        time = 500
    	}
		composer.showOverlay("pass_error",options)

	elseif not (newEmail:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")) then
    	local options = {
		isModal = true,
    	effect = "crossFade",
        time = 500
    	}
		composer.showOverlay("email_error",options)
    else

		userService:getUser(newUser,App42CallBack)
		function App42CallBack:onSuccess(object)
  			print("userName is "..object:getUserName())
  			checkUser = object:getUserName()
  			print("emailId is "..object:getEmail())
  			print("checked user: "..checkUser)
  			local options = {
				isModal = true,
    			effect = "crossFade",
        		time = 500
    		}
			composer.showOverlay("userreg_error",options)
		end

		function App42CallBack:onException(exception)
			
  			print("Message is : "..exception:getMessage())
  			print("App Error code is : "..exception:getAppErrorCode())
  			print("Http Error code is "..exception:getHttpErrorCode())
  			print("Detail is : "..exception:getDetails())

  			App42CallBack = {}
  			userService:createUser(newUser,newPass,newEmail,App42CallBack)
  			function App42CallBack:onSuccess(object)
  				print("userName is "..object:getUserName())
  				local options = {
					isModal = true,
    				effect = "crossFade",
        			time = 500
    			}
    			loaduserinfo()

          local dbName  = "USERS"
          local collectionName = "GameInfo"
          local json2 = "{\"user\":"..newUser",\"search\":1,\"rescue\":1,\"theme\":\"default\",\"robot\":\"default\",\"scientist\":\"default\"}"
          local App42CallBack = {}
          local storageService = App42API:buildStorageService()
          storageService:insertJSONDocument(dbName, collectionName, json2,App42CallBack)
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
				  composer.showOverlay("complete_reg",options)
			  end
		end
	end
end

function loaduserinfo()
	local userSettings = {
  	user = newUser,
  	name = nil,
  	search = 1,
  	rescue = 0,
  	theme = "default",
  	robot = "default",
  	science = "default"
	}
	loadsave.saveTable( userSettings, "user.json" )
	myData.theme = "default"
	myData.user = newUser
	myData.roboSprite = "default"
	myData.scienceSprite = "default"
end


local function textListener( event )
    if ( event.phase == "began" ) then
        -- user begins editing defaultField
        print( event.text )
    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- do something with defaultField text
        print( event.target.text )
    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end


function scene:create( event )

    local sceneGroup = self.view
	local background = display.newRect(display.contentCenterX, display.contentCenterY,1920-888,1080-500)
	background:setFillColor(grey,0.5)
	sceneGroup:insert(background)

	local titleText = {
    	text = "Register An Accout",     
    	x = display.contentCenterX,
    	y = display.contentCenterY - 230,
    	width = 900,     --required for multi-line and alignment
    	font = native.systemFontBold,   
    	fontSize = 92,
    	align = "center"  --new alignment parameter
	}
	local title=display.newText(titleText)
	sceneGroup:insert(title)	


	local userText = {
    	text = "Username: ",     
    	x = display.contentCenterX - 200,
    	y = display.contentCenterY - 130,
    	width = 1920-940,     --required for multi-line and alignment
    	font = native.systemFontBold,   
    	fontSize = 48,
    	align = "center"  --new alignment parameter
	}
	local trial=display.newText(userText)
	sceneGroup:insert(trial)

	userField = native.newTextField( display.contentCenterX + 200, display.contentCenterY - 130, 300, 30 )
	userField:addEventListener( "userInput", textListener )
	sceneGroup:insert(userField)


	local passText = {
    	text = "Password: ",     
    	x = display.contentCenterX - 200,
    	y = display.contentCenterY - 60,
    	width = 1920-940,     --required for multi-line and alignment
    	font = native.systemFontBold,   
    	fontSize = 48,
    	align = "center"  --new alignment parameter
	}
	local trial=display.newText(passText)
	sceneGroup:insert(trial)

	passField = native.newTextField( display.contentCenterX + 200, display.contentCenterY - 60, 300, 30 )
	passField.isSecure = true
	passField:addEventListener( "userInput", textListener )
	sceneGroup:insert(passField)


	local emailText = {
    	text = "E-mail: ",     
    	x = display.contentCenterX - 200,
    	y = display.contentCenterY + 10,
    	width = 1920-940,     --required for multi-line and alignment
    	font = native.systemFontBold,   
    	fontSize = 48,
    	align = "center"  --new alignment parameter
	}
	local trial=display.newText(emailText)
	sceneGroup:insert(trial)

	emailField = native.newTextField( display.contentCenterX + 200, display.contentCenterY + 10, 300, 30 )
	emailField:addEventListener( "userInput", textListener )
	sceneGroup:insert(emailField)


	
	local createAcc = widget.newButton{
		width = 300,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Create Account",
		onRelease = tryregister,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
	}	
	sceneGroup:insert(createAcc)
	createAcc.x=display.contentCenterX
	createAcc.y=display.contentCenterY+200
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