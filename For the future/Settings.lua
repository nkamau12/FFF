local parse = require( "mod_parse" )
local myData = require( "mydata" )
local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()
local JSON = require ("json")
local loadsave = require( "loadsave" ) 
local App42API = require("App42-Lua-API.App42API") 
App42API:initialize("1115061051839753", "ceb665dfcdccce67e201ad66ebc741f3")
require("App42-Lua-API.Operator")
require("App42-Lua-API.Permission")
require("App42-Lua-API.GeoOperator")
require("App42-Lua-API.OrderByType")
require("App42-Lua-API.Operator")
local JSON = require("App42-Lua-API.JSON") 
local queryBuilder = require("App42-Lua-API.QueryBuilder")
local ACL = require("App42-Lua-API.ACL")
local userService  = App42API:buildUserService()  
local storageService = App42API:buildStorageService()  
local socialService  = App42API:buildSocialService() 
local fbAppID = "1115061051839753"  --replace with your Facebook App ID
local App42CallBack = {}
local facebook = require( "plugin.facebook.v4" )
local showButton = 1
local accessToken
local volumeValue
local sfxValue
local homebutton

local saveBut

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here
-- -------------------------------------------------------------------------------
local function gohome( event )
    local options = {
    		isModal = true,
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("MainMenu",options)
end

local function logout(event)
	local userSettings = {
	  	user = nil,
	  	name = nil,
	  	search = 1,
	  	rescue = 0,
	  	credits = 0,
	  	volume = 100,
	  	sfx = 100,
	  	theme = "default",
	  	robot = "default",
	  	science = "default"
	}
	loadsave.saveTable( userSettings, "user.json" )
	myData.theme = "default"
	myData.user = nil
	myData.musicVol = 100
	myData.sfx = 100
	myData.credits = 0
	myData.roboSprite = "default"
	myData.scienceSprite = "default"

	local options = {
    		isModal = true,
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("Splash",options) 
end


local function saveUser(event)
	local userSettings = {
	  	user = myData.user,
	  	search = maxsrch,
	  	rescue = maxrsc,
	    volume = myData.musicVol,
	    sfx = myData.sfx,
	    credits = myData.credits,
	  	theme = myData.theme,
	  	robot = myData.roboSprite,
	  	science = myData.scienceSprite
	}
	loadsave.saveTable( userSettings, "user.json" )

	local dbName  = "USERS"
    local collectionName = "GameInfo"
    local key = "user"
    local value = myData.user
    local jsonDoc = {}
  	jsonDoc.user = myData.user
    jsonDoc.search = myData.maxsrch
    jsonDoc.rescue = myData.maxrsc
    jsonDoc.credits = myData.credits
    jsonDoc.theme = myData.theme
    jsonDoc.volume = myData.musicVol
    jsonDoc.sfx = myData.sfx
    jsonDoc.robot = myData.roboSprite
    jsonDoc.scientist = myData.scienceSprite

    local App42CallBack = {}
    App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
    storageService:saveOrupdateDocumentByKeyValue(dbName,collectionName,key,value,jsonDoc,App42CallBack)
    function App42CallBack:onSuccess(object)
        print("dbName is "..object:getDbName())
        for i=1,table.getn(object:getJsonDocList()) do
            print("DocId is "..object:getJsonDocList()[i]:getDocId())
            print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
            print("UpdatedAt is "..object:getJsonDocList()[i]:getUpdatedAt())
            print("jsonDoc is "..JSON:encode(object:getJsonDocList()[i]:getJsonDoc())); 
        end
    end
    function App42CallBack:onException(exception)
        print("Message is : "..exception:getMessage())
        print("App Error code is : "..exception:getAppErrorCode())
        print("Http Error code is "..exception:getHttpErrorCode())
        print("Detail is : "..exception:getDetails())
    end
end


function fblogin()
  if ( facebook.isActive ) then
    accessToken = facebook.getCurrentAccessToken()
    facebook.login( fbAppID, facebookListener, { "public_profile", "user_friends", "email" } )
	App42CallBack = {}
	App42API:initialize("1115061051839753", "ceb665dfcdccce67e201ad66ebc741f3")
	socialService:linkUserFacebookAccount(myData.user, accessToken.token, App42CallBack)
	function App42CallBack:onSuccess(object)
	  print("userName is " ..object:getUserName()) 
	  print("facebookAccessToken is "..object:getFacebookAccessToken()) 
	end
	function App42CallBack:onException(exception)
	  print("Message is : "..exception:getMessage())
	  print("App Error code is : "..exception:getAppErrorCode())
	  print("Http Error code is "..exception:getHttpErrorCode())
	  print("Detail is : "..exception:getDetails())
	end
  end
end


local function facebookListener( event )
    print( "event.name:" .. event.name )  --"fbconnect"
    print( "isError: " .. tostring( event.isError ) )
    print( "didComplete: " .. tostring( event.didComplete ) )
    print( "event.type:" .. event.type )  --"session", "request", or "dialog"
    --"session" events cover various login/logout events
    --"request" events handle calls to various Graph API calls
    --"dialog" events are standard popup boxes that can be displayed
    if ( "session" == event.type ) then
        --options are "login", "loginFailed", "loginCancelled", or "logout"
        if ( "login" == event.phase ) then
            accessToken = event.token
        end
    elseif ( "request" == event.type ) then
        print("facebook request")
        if ( not event.isError ) then
            local response = json.decode( event.response )
            --process response data here
        end
    elseif ( "dialog" == event.type ) then
        print( "dialog", event.response )
        --handle dialog results here
    end
end

-- Slider listener
local function sliderListener( event )
    print( "Slider at " .. event.value .. "%" )
    vol = event.value / 100
    myData.musicVol = event.value
    audio.setVolume(vol, { channel=1 })
    if(volumeValue == nil) then
    	return
    else
        volumeValue.text = event.value.."%"
    end
end

local function sfxSliderListener( event )
    print( "Slider at " .. event.value .. "%" )
    sfxvol = event.value / 100
    myData.sfx = event.value
    audio.setVolume(sfxvol, { channel=2 })
    if(sfxValue == nil) then
    	return
    else
        sfxValue.text = event.value.."%"
    end
end


-- "scene:create()"
function scene:create( event )
end

-- "scene:show()"
function scene:show( event )
	
    local sceneGroup = self.view
    local phase = event.phase
    local vol = 100
	
    if ( phase == "will" ) then
		
		local background = display.newImage("Images/theme_"..myData.theme.."/splash_main.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080
		background.width=1920
		background.x= display.contentCenterX
		background.y=display.contentCenterY
		sceneGroup:insert(background)

		--home_button
        homebutton = display.newImage("Images/home.png")
        homebutton.anchorX=0
        homebutton.anchorY=0
        homebutton.x=1700
        homebutton.y=180
        homebutton.height=121
        homebutton.width=121
        sceneGroup:insert(homebutton)
		homebutton:addEventListener( "tap", gohome )

		local optionsText = {
    		text = "Logged in as "..myData.user,     
    		x = display.contentCenterX,
    		y = display.contentCenterY - 200,
    		width = 1920-940,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "center"  --new alignment parameter
		}
		local trial=display.newText(optionsText)
		sceneGroup:insert(trial)	

		local logBut = widget.newButton{
			width = 374.4,
			height = 80.6,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Log Out",
			onRelease = logout,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize=48,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
		}	
		sceneGroup:insert(logBut)
		logBut.x=display.contentCenterX - 400
		logBut.y=display.contentCenterY+375

		saveBut = widget.newButton{
			width = 300,
			height = 80.6,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Save Settings",
			onRelease = saveUser,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize=40,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
		}	
		sceneGroup:insert(saveBut)
		saveBut.x=display.contentCenterX
		saveBut.y=display.contentCenterY+375

		if ( facebook.isActive ) then
		    accessToken = facebook.getCurrentAccessToken()
		    if not ( accessToken ) then
		    	local facebookBtn = widget.newButton{
				    width = 374.4,
				    height = 80.6,
				    defaultFile = "facebook.png",
				    overFile = "facebook.png",
				    onRelease = fblogin,
				    labelColor = { default={255,255,255}, over={255,255,255} },
				} 
			  	sceneGroup:insert(facebookBtn)
			  	facebookBtn.x=display.contentCenterX + 400
			  	facebookBtn.y=display.contentCenterY + 375
		    end
		end

		--volume Slider
		local volumeText = {
    		text = "Music volume: ",     
    		x = display.contentCenterX - 220,
    		y = display.contentCenterY - 70,
    		width = 1920-940,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "center"  --new alignment parameter
		}
		local trial=display.newText(volumeText)
		sceneGroup:insert(trial)	

		local slider = widget.newSlider
		{
		    x = 1100,
		    y = display.contentCenterY - 65,
		    left = 50,
		    width = 300,
		    value = myData.musicVol,  -- Start slider at 10% (optional)
		    listener = sliderListener
		}
		sceneGroup:insert(slider)
		volumeValue = display.newText(myData.musicVol.."%", display.contentCenterX + 380, display.contentCenterY - 70, native.systemFontBold, 48)
        volumeValue:setFillColor( 1, 1, 1 )
        sceneGroup:insert(volumeValue)

        --sound effects Slider
		local sfxText = {
    		text = "Sound effects: ",     
    		x = display.contentCenterX - 220,
    		y = display.contentCenterY + 20,
    		width = 1920-940,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "center"  --new alignment parameter
		}
		local trial=display.newText(sfxText)
		sceneGroup:insert(trial)	
		local sfxSlider = widget.newSlider
		{
		    x = 1100,
		    y = display.contentCenterY + 25,
		    left = 50,
		    width = 300,
		    value = myData.sfx,  -- Start slider at 10% (optional)
		    listener = sfxSliderListener
		}
		sceneGroup:insert(sfxSlider)
		sfxValue = display.newText(myData.sfx.."%", display.contentCenterX + 380, display.contentCenterY + 20, native.systemFontBold, 48)
        sfxValue:setFillColor( 1, 1, 1 )
        sceneGroup:insert(sfxValue)

		
    elseif ( phase == "did" ) then
		audio.resume(backgroundMusicplay)
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    	homebutton:removeEventListener( "tap", gohome )
    elseif ( phase == "did" ) then
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene