local parse = require( "mod_parse" )
local myData = require( "mydata" )
local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()
local JSON = require ("json")
local loadsave = require( "loadsave" ) 
local App42API = require("App42-Lua-API.App42API") 
App42API:initialize("1115061051839753", "ceb665dfcdccce67e201ad66ebc741f3")
local userService  = App42API:buildUserService()  
local storageService = App42API:buildStorageService()  
local socialService  = App42API:buildSocialService() 
local fbAppID = "1115061051839753"  --replace with your Facebook App ID
local App42CallBack = {}
local facebook = require( "plugin.facebook.v4" )
local showButton = 1
local accessToken

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
	  	theme = "default",
	  	robot = "default",
	  	science = "default"
	}
	loadsave.saveTable( userSettings, "user.json" )
	myData.theme = "default"
	myData.user = nil
	myData.roboSprite = "default"
	myData.scienceSprite = "default"

	local options = {
    		isModal = true,
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("Splash",options) 
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


-- "scene:create()"
function scene:create( event )
end

-- "scene:show()"
function scene:show( event )
	
    local sceneGroup = self.view
    local phase = event.phase
	
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
			width = 300,
			height = 100,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Log Out",
			onRelease = logout,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize=40,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
		}	
		sceneGroup:insert(logBut)
		logBut.x=display.contentCenterX - 200
		logBut.y=display.contentCenterY+300

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
			  	facebookBtn.x=display.contentCenterX + 200
			  	facebookBtn.y=display.contentCenterY + 300
		    end
		end

		
    elseif ( phase == "did" ) then
		audio.resume(backgroundMusicplay)
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
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