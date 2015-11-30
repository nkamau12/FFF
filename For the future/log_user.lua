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
local storageService = App42API:buildStorageService() 
local socialService  = App42API:buildSocialService() 


local App42CallBack = {}

local newUser
local newPass

local userField
local passField

local fbAppID = "1115061051839753"  --replace with your Facebook App ID

local function trylogin(event)
	newUser = userField.text
	newPass = passField.text


	userService:authenticate(newUser,newPass,App42CallBack)  

	function App42CallBack:onSuccess(object)
  		print("userName is "..object:getUserName())
  		print("session id is "..object:getSessionId()) 
  		local options = {
				isModal = true,
    			effect = "crossFade",
        		time = 500
    	}
      loaduserinfo()

      --load user
      local dbName  = "USERS"
      local collectionName = "GameInfo"
      local key = "user"
      local value = newUser
      local App42CallBack = {}
      local jsonDoc = {}
      storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)

      function App42CallBack:onSuccess(object)
        print("dbName is "..object:getDbName())
        for i=1,table.getn(object:getJsonDocList()) do
          print("DocId is "..object:getJsonDocList()[i]:getDocId())
          print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
          jsonDoc.user = object:getJsonDocList()[i]:getJsonDoc().user
          jsonDoc.search = object:getJsonDocList()[i]:getJsonDoc().search
          jsonDoc.rescue = object:getJsonDocList()[i]:getJsonDoc().rescue
          jsonDoc.theme = object:getJsonDocList()[i]:getJsonDoc().theme
          jsonDoc.credits = object:getJsonDocList()[i]:getJsonDoc().credits
          jsonDoc.volume = object:getJsonDocList()[i]:getJsonDoc().volume
          jsonDoc.sfx = object:getJsonDocList()[i]:getJsonDoc().sfx
          jsonDoc.robot = object:getJsonDocList()[i]:getJsonDoc().robot
          jsonDoc.scientist = object:getJsonDocList()[i]:getJsonDoc().scientist

          myData.maxsrch = jsonDoc.search
          myData.maxrsc = jsonDoc.rescue
          myData.theme = jsonDoc.theme
          myData.credits = jsonDoc.credits
          myData.musicVol = jsonDoc.volume
          myData.sfx = jsonDoc.sfx
          myData.roboSprite = jsonDoc.robot
          myData.scienceSprite = jsonDoc.scientist
        end
      end


			composer.showOverlay("complete_log",options)
	end

	function App42CallBack:onException(exception)
  		print("Message is : "..exception:getMessage())
  		print("App Error code is : "..exception:getAppErrorCode())
  		print("Http Error code is "..exception:getHttpErrorCode())
  		print("Detail is : "..exception:getDetails())

  		local options = {
        isModal = true,
        effect = "crossFade",
        time = 500
      }
      myData.textmessage = "Your username and/or password is incorrect"
      myData.buttonlabel = "Try Again"
      myData.newscreen = "log_user"
      composer.showOverlay("reglog_error",options)
	end
end


function loaduserinfo()
	local userSettings = {
  	user = newUser,
  	name = nil,
  	search = 1,
  	rescue = 0,
    volume = 100,
    sfx = 100,
    credits = 0,
  	theme = "default",
  	robot = "default",
  	science = "default"
	}
	loadsave.saveTable( userSettings, "user.json" )
	myData.theme = "default"
	myData.user = newUser
  myData.musicVol = 100
  myData.sfx = 100
  myData.credits = 0
	myData.roboSprite = "default"
	myData.scienceSprite = "default"
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

local function passListener( event )
    if ( event.phase == "began" ) then
        -- user begins editing defaultField
        print( event.text )
    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        native.setKeyboardFocus( nil )
    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end

local function hideKb( event )
  native.setKeyboardFocus( nil )
end

--Sends user back to the main menu screen
local function gohome( event )
  if ( "ended" == event.phase ) then
    local options = {
      isModal = true,
        effect = "crossFade",
          time = 500
      }
    composer.showOverlay( "start_user", options )
  end
end


function scene:create( event )

  local sceneGroup = self.view

  --home button
  local home = display.newRect(display.contentCenterX, display.contentCenterY,display.contentWidth,display.contentHeight)
  home:setFillColor(white, 0.01)
  sceneGroup:insert(home)
  home:addEventListener("touch", gohome)

	local background = display.newRect(display.contentCenterX, display.contentCenterY + 20,1920-888,1080-500)
	background:setFillColor(grey,0.5)
  background:addEventListener( "tap", hideKb )
	sceneGroup:insert(background)

	local titleText = {
    	text = "Log In",     
    	x = display.contentCenterX,
    	y = display.contentCenterY - 210,
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
    	y = display.contentCenterY - 80,
    	width = 1920-940,     --required for multi-line and alignment
    	font = native.systemFontBold,   
    	fontSize = 48,
    	align = "center"  --new alignment parameter
	}
	local trial=display.newText(userText)
	sceneGroup:insert(trial)

	userField = native.newTextField( display.contentCenterX + 200, display.contentCenterY - 80, 330, 55 )
  userField.size = nil
  userField:resizeFontToFitHeight()
  userField:setReturnKey( "next" )
	userField:addEventListener( "userInput", userListener )
	sceneGroup:insert(userField)


	local passText = {
    	text = "Password: ",     
    	x = display.contentCenterX - 200,
    	y = display.contentCenterY + 20,
    	width = 1920-940,     --required for multi-line and alignment
    	font = native.systemFontBold,   
    	fontSize = 48,
    	align = "center"  --new alignment parameter
	}
	local trial=display.newText(passText)
	sceneGroup:insert(trial)

	passField = native.newTextField( display.contentCenterX + 200, display.contentCenterY + 20, 330, 55 )
	passField.isSecure = true
  passField.size = nil
  passField:resizeFontToFitHeight()
  passField:setReturnKey( "done" )
	passField:addEventListener( "userInput", passListener )
	sceneGroup:insert(passField)

	
	local createAcc = widget.newButton{
		width = 300,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Log In",
		onRelease = trylogin,
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