local composer = require( "composer" )
local widget = require( "widget" )
local myData = require( "mydata" )
local loadsave = require( "loadsave" ) 
local scene = composer.newScene()
local yes 

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

local newCreds


local function confirm(event)
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		newCreds = myData.credits - myData.purchase[4]

		if(newCreds >= 0)then
			if(myData.purchase[1] == "powerup") then
				local dbName  = "USERS"
				local collectionName = "GameInfo"
				local docId = myData.userDoc

				local keys
				if(myData.purchase[5] == "keys") then
					myData.savedkeys = myData.savedkeys + 1
					keys = "{\""..myData.purchase[5].."\":"..myData.savedkeys.."}"
				else
					myData.savedclocks = myData.savedclocks + 1
					keys = "{\""..myData.purchase[5].."\":"..myData.savedclocks.."}"
				end

				App42CallBack = {}
				storageService = App42API:buildStorageService()
				storageService:addOrUpdateKeys(dbName, collectionName,docId, keys,App42CallBack) 
				function App42CallBack:onSuccess(object) 
					
				end
				function App42CallBack:onException(exception)
				end 

				local docId = myData.userDoc
				local keys = "{\"credits\":"..newCreds.."}"

				App42CallBack = {}
				storageService = App42API:buildStorageService()
				storageService:addOrUpdateKeys(dbName, collectionName,docId, keys,App42CallBack) 
				function App42CallBack:onSuccess(object) 
					
				end
				function App42CallBack:onException(exception)
				end 
				myData.credits = newCreds

			else
				local dbName  = "USERS"
				local collectionName = "Store"
				local docId = myData.storeDoc
				local keys
				if(myData.purchase[1] == "robot") then
					keys = "{\"".."robot_"..myData.purchase[5].."\":1}"
				elseif(myData.purchase[1] == "scientist") then
					keys = "{\"".."scientist_"..myData.purchase[5].."\":1}"
				elseif(myData.purchase[1] == "theme") then
					keys = "{\"".."theme_"..myData.purchase[5].."\":1}"
				end

				App42CallBack = {}
				storageService = App42API:buildStorageService()
				storageService:addOrUpdateKeys(dbName, collectionName,docId, keys,App42CallBack) 
				function App42CallBack:onSuccess(object) 
					
				end
				function App42CallBack:onException(exception)
				end 

				collectionName = "GameInfo"
				local docId = myData.userDoc
				local keys = "{\"credits\":"..newCreds.."}"

				App42CallBack = {}
				storageService = App42API:buildStorageService()
				storageService:addOrUpdateKeys(dbName, collectionName,docId, keys,App42CallBack) 
				function App42CallBack:onSuccess(object)
					
				end
				function App42CallBack:onException(exception)
				end 
				myData.credits = newCreds
			end
		end
		composer.hideOverlay( "fade", 400 )

		local userSettings = {
		  	user = myData.user,
		  	search = myData.maxsrch,
		  	rescue = myData.maxrsc,
		    volume = myData.musicVol,
		    sfx = myData.sfx,
		    credits = myData.credits,
		  	theme = myData.theme,
		  	robot = myData.roboSprite,
		  	science = myData.scienceSprite
		}
		loadsave.saveTable( userSettings, "user.json" )
	end
end

local function decline(event)
	composer.hideOverlay( "fade", 400 )
end

function scene:create( event )

    local sceneGroup = self.view
	local background = display.newRect(display.contentCenterX, display.contentCenterY,1920-400,1080-400)
	background:setFillColor(grey,0.5)
	sceneGroup:insert(background)
	
	local trial=display.newText("Confirm purchase of "..myData.purchase[2],display.contentCenterX,display.contentCenterY)
	sceneGroup:insert(trial)

	local confirm = widget.newButton
	{
		x = display.contentCenterX - 150,
		y = display.contentCenterY + 200,
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Confirm",
		onEvent = confirm,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
		
	}	
	sceneGroup:insert(confirm)
	
	local decline = widget.newButton
	{
		x = display.contentCenterX + 150,
		y = display.contentCenterY + 200,
		width = 200,
		height = 100,
		defaultFile = "buttonDefault.png",
		overFile = "buttonOver.png",
		label = "Decline",
		onEvent = decline,
		labelColor = { default={255,255,255}, over={255,255,255} },
		fontSize=40,
		fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
		shape="roundedRect"
	}	
	
	sceneGroup:insert(decline)
	
	
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