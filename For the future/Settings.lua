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
local App42CallBack = {}
local showButton = 1
local accessToken
local volumeValue
local sfxValue
local homebutton

local saveBut
local robo_counter = 1
local science_counter = 1
local theme_counter = 1

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

    myData.roboSprite = myData.roboSprites[robo_counter][5]
    myData.scienceSprite = myData.scienceSprites[science_counter][5]
    myData.theme = myData.themeColours[theme_counter][5]

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
    jsonDoc.stopwatch = myData.savedclocks
    jsonDoc.keys = myData.savedkeys

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

local function prevRobo( event )
    if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        print("roboSprites size is "..table.maxn(myData.roboSprites))
        if(myData.roboSprites[robo_counter - 1] == nil) then
            robo_counter = table.maxn(myData.roboSprites)
        else
            robo_counter = robo_counter - 1
        end
        print("robo_counter is "..robo_counter)
        robo_pic:removeSelf()
        robo_title:removeSelf()
        robo_title = display.newText(myData.roboSprites[robo_counter][2], display.contentCenterX-600, display.contentCenterY+275, native.systemFont, 40)
        robo_pic = display.newImage(myData.roboSprites[robo_counter][3],system.ResourceDirectory)
        robo_pic.x = display.contentCenterX - 600
        robo_pic.y = display.contentCenterY + 175
        robo_pic.height = 125
        robo_pic.width = 125
    end
end

local function nextRobo( event )
    if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        print("roboSprites size is "..table.maxn(myData.roboSprites))
        print("roboSprites3 size is "..myData.roboSprites[3][5])
        if(myData.roboSprites[robo_counter + 1] == nil) then
            robo_counter = 1
        else
            robo_counter = robo_counter + 1
        end
        print("robo_counter is "..robo_counter)
        robo_pic:removeSelf()
        robo_title:removeSelf()
        robo_title = display.newText(myData.roboSprites[robo_counter][2], display.contentCenterX-600, display.contentCenterY+275, native.systemFont, 40)
        robo_pic = display.newImage(myData.roboSprites[robo_counter][3],system.ResourceDirectory)
        robo_pic.x = display.contentCenterX - 600
        robo_pic.y = display.contentCenterY + 175
        robo_pic.height = 125
        robo_pic.width = 125
    end
end

local function prevTheme( event )
    if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        print("themeColours size is "..table.maxn(myData.themeColours))
        if(myData.themeColours[theme_counter - 1] == nil) then
            theme_counter = table.maxn(myData.themeColours)
        else
            theme_counter = theme_counter - 1
        end
        print("theme_counter is "..robo_counter)
        theme_pic:removeSelf()
        theme_title:removeSelf()
        theme_title = display.newText(myData.themeColours[theme_counter][2], display.contentCenterX, display.contentCenterY+275, native.systemFont, 40)
        theme_pic = display.newImage(myData.themeColours[theme_counter][3],system.ResourceDirectory)
        theme_pic.x = display.contentCenterX
        theme_pic.y = display.contentCenterY + 175
        theme_pic.height = 125
        theme_pic.width = 218.74
    end
end

local function nextTheme( event )
    if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        print("themeColours size is "..table.maxn(myData.themeColours))
        if(myData.themeColours[theme_counter + 1] == nil) then
            theme_counter = 1
        else
            theme_counter = theme_counter + 1
        end
        print("theme_counter is "..theme_counter)
        theme_pic:removeSelf()
        theme_title:removeSelf()
        theme_title = display.newText(myData.themeColours[theme_counter][2], display.contentCenterX, display.contentCenterY+275, native.systemFont, 40)
        theme_pic = display.newImage(myData.themeColours[theme_counter][3],system.ResourceDirectory)
        theme_pic.x = display.contentCenterX
        theme_pic.y = display.contentCenterY + 175
        theme_pic.height = 125
        theme_pic.width = 218.74
    end
end

local function prevScience( event )
    if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        print("scienceSprites size is "..table.maxn(myData.scienceSprites))
        if(myData.scienceSprites[science_counter - 1] == nil) then
            science_counter = table.maxn(myData.scienceSprites)
        else
            science_counter = science_counter - 1
        end
        print("science_counter is "..science_counter)
        science_pic:removeSelf()
        science_title:removeSelf()
        science_title = display.newText(myData.scienceSprites[science_counter][2], display.contentCenterX + 600, display.contentCenterY+275, native.systemFont, 40)
        science_pic = display.newImage(myData.scienceSprites[science_counter][3],system.ResourceDirectory)
        science_pic.x = display.contentCenterX + 600
        science_pic.y = display.contentCenterY + 175
        science_pic.height = 125
        science_pic.width = 125
    end
end

local function nextScience( event )
    if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        print("scienceSprites size is "..table.maxn(myData.scienceSprites))
        if(myData.scienceSprites[science_counter + 1] == nil) then
            science_counter = 1
        else
            science_counter = science_counter + 1
        end
        print("science_counter is "..science_counter)
        science_pic:removeSelf()
        science_title:removeSelf()
        science_title = display.newText(myData.scienceSprites[science_counter][2], display.contentCenterX + 600, display.contentCenterY+275, native.systemFont, 40)
        science_pic = display.newImage(myData.scienceSprites[science_counter][3],system.ResourceDirectory)
        science_pic.x = display.contentCenterX + 600
        science_pic.y = display.contentCenterY + 175
        science_pic.height = 125
        science_pic.width = 125
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
		logBut.x=display.contentCenterX - 300
		logBut.y=display.contentCenterY+375

		saveBut = widget.newButton{
			width = 374.4,
			height = 80.6,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Save Settings",
			onRelease = saveUser,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize=48,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
		}	
		sceneGroup:insert(saveBut)
		saveBut.x=display.contentCenterX + 300
		saveBut.y=display.contentCenterY+375

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


        for i=1, table.maxn(myData.roboSprites), 1 do
            if(myData.roboSprite == myData.roboSprites[i][5])then
                robo_counter = i
            end
        end
        print("roboSprite is "..myData.roboSprite)
        print("robo_counter is "..robo_counter)

        local leftrobo = widget.newButton{
            x = display.contentCenterX - 750,
            y = display.contentCenterY+175,
            shape = "polygon",
            vertices = {display.contentCenterX - 750,display.contentCenterY+175, 
                    display.contentCenterX - 675,display.contentCenterY+125, 
                    display.contentCenterX - 675,display.contentCenterY+225},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = prevRobo
        }
        sceneGroup:insert(leftrobo)

        local rightrobo = widget.newButton{
            x = display.contentCenterX - 450,
            y = display.contentCenterY+175,
            shape = "polygon",
            vertices = {display.contentCenterX - 375,display.contentCenterY+175, 
                    display.contentCenterX - 450,display.contentCenterY+125, 
                    display.contentCenterX - 450,display.contentCenterY+225},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = nextRobo
        }
        sceneGroup:insert(rightrobo)

        robo_pic = display.newImage(myData.roboSprites[robo_counter][3],system.ResourceDirectory)
        robo_pic.height = 125
        robo_pic.width = 125
        robo_pic.x = display.contentCenterX - 600
        robo_pic.y = display.contentCenterY+175
        sceneGroup:insert(robo_pic)
        
        robo_title = display.newText(myData.roboSprites[robo_counter][2], display.contentCenterX-600, display.contentCenterY+275, native.systemFont, 40)
        sceneGroup:insert(robo_title)


        for i=1, table.maxn(myData.themeColours), 1 do
            if(myData.theme == myData.themeColours[i][5])then
                theme_counter = i
            end
        end
        print("theme is "..myData.theme)
        print("theme_counter is "..theme_counter)

        local lefttheme = widget.newButton{
            x = display.contentCenterX - 175,
            y = display.contentCenterY+175,
            shape = "polygon",
            vertices = {display.contentCenterX - 175,display.contentCenterY+175, 
                    display.contentCenterX - 100,display.contentCenterY+125, 
                    display.contentCenterX - 100,display.contentCenterY+225},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = prevTheme
        }
        sceneGroup:insert(lefttheme)

        local righttheme = widget.newButton{
            x = display.contentCenterX + 175,
            y = display.contentCenterY+175,
            shape = "polygon",
            vertices = {display.contentCenterX + 175,display.contentCenterY+175, 
                    display.contentCenterX + 100,display.contentCenterY+125, 
                    display.contentCenterX + 100,display.contentCenterY+225},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = nextTheme
        }
        sceneGroup:insert(righttheme)

        theme_pic = display.newImage(myData.themeColours[theme_counter][3],system.ResourceDirectory)
        theme_pic.height = 125
        theme_pic.width = 218.74
        theme_pic.x = display.contentCenterX
        theme_pic.y = display.contentCenterY+175
        sceneGroup:insert(theme_pic)
        
        theme_title = display.newText(myData.themeColours[theme_counter][2], display.contentCenterX, display.contentCenterY+275, native.systemFont, 40)
        sceneGroup:insert(theme_title)


        for i=1, table.maxn(myData.scienceSprites), 1 do
            if(myData.scienceSprite == myData.scienceSprites[i][5])then
                science_counter = i
            end
        end
        print("scienceSprite is "..myData.scienceSprite)
        print("science_counter is "..science_counter)

        local leftscience = widget.newButton{
            x = display.contentCenterX + 750,
            y = display.contentCenterY+175,
            shape = "polygon",
            vertices = {display.contentCenterX + 750,display.contentCenterY+175, 
                    display.contentCenterX + 675,display.contentCenterY+125, 
                    display.contentCenterX + 675,display.contentCenterY+225},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = prevScience
        }
        sceneGroup:insert(leftscience)

        local rightscience = widget.newButton{
            x = display.contentCenterX + 450,
            y = display.contentCenterY+175,
            shape = "polygon",
            vertices = {display.contentCenterX + 375,display.contentCenterY+175, 
                    display.contentCenterX + 450,display.contentCenterY+125, 
                    display.contentCenterX + 450,display.contentCenterY+225},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = nextScience
        }
        sceneGroup:insert(rightscience)

        science_pic = display.newImage(myData.scienceSprites[science_counter][3],system.ResourceDirectory)
        science_pic.height = 125
        science_pic.width = 125
        science_pic.x = display.contentCenterX+600
        science_pic.y = display.contentCenterY+175
        sceneGroup:insert(science_pic)
        
        science_title = display.newText(myData.scienceSprites[science_counter][2], display.contentCenterX+600, display.contentCenterY+275, native.systemFont, 40)
        sceneGroup:insert(science_title)

		
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
        if(robo_pic ~= nil)then
            robo_pic:removeSelf()
        end
        if(robo_title ~= nil)then
            robo_title:removeSelf()
        end

        if(science_pic ~= nil)then
            science_pic:removeSelf()
        end
        if(science_title ~= nil)then
            science_title:removeSelf()
        end

        if(theme_pic ~= nil)then
            theme_pic:removeSelf()
        end
        if(theme_title ~= nil)then
            theme_title:removeSelf()
        end
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