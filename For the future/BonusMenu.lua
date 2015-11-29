local parse = require( "mod_parse" )
local myData = require( "mydata" )
local widget = require( "widget" )
local composer = require( "composer" )
local JSON = require ("json")
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

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local gamemode
local tableView

local levels 
local templevel
local mx
local rankbox 
local userbox 
local scorebox 
local playthis
local bonuskeys
local bonusone
local bonustwo
local bonusthree
local title1
local title2
local title3
local title4
local trial
local ranknum
local userranked
local rankscore
local playthis



local function gohome( event )
    local options = {
    		isModal = true,
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("MainMenu",options)
end

local function playLevel( event )
	if(event.phase == "ended") then
	local options = {
		isModal = true,
        effect = "crossFade",
        time = 500
    }
    myData.bonusSearchLvl = event.target.id
    myData.bonusSearchLvlKey = bonuskeys[myData.bonusSearchLvl]
    myData.bonusSearchLvlOne = bonusone[myData.bonusSearchLvl]
    myData.bonusSearchLvlTwo = bonustwo[myData.bonusSearchLvl]
    myData.bonusSearchLvlThree = bonusthree[myData.bonusSearchLvl]
    print(myData.bonusSearchLvlKey)
    composer.gotoScene("BonusSearch",options)
    
	end
end

local function printRanks()
	mx = table.getn(levels)
	print("levels size is "..mx)
	for i=1, mx, 1 do
		ranknum = {
    		text = levels[i][1],    
    		x = display.contentCenterX,
    		y = display.contentCenterY + 15 + (i-1)*60,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 42,
    		align = "left"  --new alignment parameter
		}
		rankbox[i] = display.newText(ranknum)	
	end
	for i=1, mx, 1 do
		userranked = {
    		text = levels[i][2],    
    		x = display.contentCenterX + 350,
    		y = display.contentCenterY + 15 + (i-1)*60,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 42,
    		align = "left"  --new alignment parameter
		}
		userbox[i] = display.newText(userranked)	
	end
	for i=1, mx, 1 do
		rankscore = {
    		text = levels[i][3],    
    		x = display.contentCenterX + 700,
    		y = display.contentCenterY + 15 + (i-1)*60,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 42,
    		align = "left"  --new alignment parameter
		}
		scorebox[i] = display.newText(rankscore)	
	end
	for i=1, mx, 1 do
		playthis[i] = widget.newButton
		{
			id = i,
			width = 150,
			height = 45,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Play",
			onEvent = playLevel,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize = 36,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
			
		}	
		bonuskeys[i] = levels[i][4]
		bonusone[i] = levels[i][5]
		bonustwo[i] = levels[i][6]
		bonusthree[i] = levels[i][7]
		playthis[i].x=display.contentCenterX + 500
		playthis[i].y=display.contentCenterY + 15 + (i-1)*60
	end

end

function getSearch()
	print("start")
	local dbName  = "USERS"
	local collectionName = "Bonus Levels"
	App42CallBack = {} 
	local key = "type"
	local value = "Search"
	storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)
	function App42CallBack:onSuccess(object)
		print("dbName is "..object:getDbName())
		for i=1,table.getn(object:getJsonDocList()) do
			print("DocId is "..object:getJsonDocList()[i]:getDocId())
			print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
			templevel = {object:getJsonDocList()[i]:getJsonDoc().level,object:getJsonDocList()[i]:getJsonDoc().user,object:getJsonDocList()[i]:getJsonDoc().playcount,
			object:getJsonDocList()[i]:getJsonDoc().key,object:getJsonDocList()[i]:getJsonDoc().keyone,object:getJsonDocList()[i]:getJsonDoc().keytwo,object:getJsonDocList()[i]:getJsonDoc().keythree}
			table.insert( levels, templevel )
		end
		printRanks()
	end
	function App42CallBack:onException(exception)
		print("Error!")
	end
end

local function showSearchBonus( event )
	if(event.phase == "ended") then
		gamemode.text = "Search"
		getSearch()
		event.target:setEnabled(false)
	end
end

local function showRescueBonus()
	gamemode.text = "Rescue"
end

-- "scene:create()"
function scene:create( event )
	
	--update()
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )
	
    local sceneGroup = self.view
    local phase = event.phase
	
    if ( phase == "will" ) then
        print(" ")
	    print("start BonusMenu")

	    mx = 0
    	levels = {}
    	rankbox = {}
		userbox = {}
		scorebox = {}
		playthis = {}
		bonuskeys = {}
		bonusone = {}
		bonustwo = {}
		bonusthree = {}
		templevel = nil
		ranknum = {}
		userranked = {}
		rankscore = {}
		App42CallBack = {}

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

		local text=display.newText("Select a game type ",display.contentCenterX,display.contentCenterY - 250)
		sceneGroup:insert(text)	

		local search = widget.newButton
		{
			width = 180,
			height = 60,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Search",
			onEvent = showSearchBonus,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize=40,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
			
		}	
		sceneGroup:insert(search)
		search.x=display.contentCenterX - 150
		search.y=display.contentCenterY - 170

		local rescue = widget.newButton
		{
			width = 180,
			height = 60,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Rescue",
			onEvent = showRescueBonus,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize=40,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
			
		}	
		sceneGroup:insert(rescue)
		rescue.x=display.contentCenterX + 150
		rescue.y=display.contentCenterY - 170

		gamemode=display.newText(" ",display.contentCenterX,display.contentCenterY - 110)
		sceneGroup:insert(gamemode)	

		-- Create the widget
		tableView = widget.newTableView
		{
		    x = display.contentCenterX,
		    y = display.contentCenterY + 175,
		    height = 500,
		    width = 1400,
		    onRowRender = onRowRender,
		    onRowTouch = onRowTouch,
		    listener = scrollListener,
		    backgroundColor = { 0.8, 0.8, 0.8, 0.2 }
		}

		-- Insert 5 rows to tableview
		for i = 1, 7 do
		    local isCategory = false
		    local rowHeight = 60
		    local rowColor = { default={ 1, 1, 1, 0.2}, over={ 1, 0.5, 0, 0.2 } }
		    local lineColor = { 0.5, 0.5, 0.5 }
		    -- Make some rows categories
		    if ( i == 1) then
		        isCategory = true
		        rowHeight = 60
		        rowColor = { default={ 0.8, 0.8, 0.8, 0.8 } }
		        lineColor = { 1, 0, 0 }
		    end
		    -- Insert a row into the tableView
		    tableView:insertRow(
		        {
		            isCategory = isCategory,
		            rowHeight = rowHeight,
		            rowColor = rowColor,
		            lineColor = lineColor
		        }
		    )
		end
		sceneGroup:insert(tableView)


		local NameTitle = {
    		text = "Name",    
    		x = display.contentCenterX,
    		y = display.contentCenterY - 45,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 44,
    		align = "left"  --new alignment parameter
		}
		title1=display.newText(NameTitle)
		sceneGroup:insert(title1)

		local UserTitle = {
    		text = "\Created By",    
    		x = display.contentCenterX + 350,
    		y = display.contentCenterY - 45,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 44,
    		align = "left"  --new alignment parameter
		}
		title2=display.newText(UserTitle)
		sceneGroup:insert(title2)	

		local PlaysCount = {
    		text = "Play Count",    
    		x = display.contentCenterX + 700,
    		y = display.contentCenterY - 45,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 44,
    		align = "left"  --new alignment parameter
		}
		title3=display.newText(PlaysCount)
		sceneGroup:insert(title3)

		local PlaysTitle = {
    		text = "Play",    
    		x = display.contentCenterX + 1050,
    		y = display.contentCenterY - 45,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 44,
    		align = "left"  --new alignment parameter
		}
		title4=display.newText(PlaysTitle)
		sceneGroup:insert(title4)


		
		audio.resume(backgroundMusicplay)
		
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
		
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        for i=table.getn(rankbox),1, -1 do
			display.remove(rankbox[i])
			table.remove(rankbox,i)
		end

		for i=table.getn(userbox),1, -1 do
			display.remove(userbox[i])
			table.remove(userbox,i)
		end
		for i=table.getn(scorebox),1, -1 do
			display.remove(scorebox[i])
			table.remove(scorebox,i)
		end
		for i=table.getn(playthis),1, -1 do
			display.remove(playthis[i])
			table.remove(playthis,i)
		end
		print("rankbox end size is "..table.getn(rankbox))
		print("userbox end size is "..table.getn(userbox))
		print("scorebox end size is "..table.getn(scorebox))
		ranknum = nil
		userranked = nil
		rankscore = nil
		rankbox = {}
		userbox = {}
		scorebox = {}
		playthis = {}
		bonuskeys = {}
		bonusone = {}
		bonustwo = {}
		bonusthree = {}

		display.remove(title1)
		display.remove(title2)
		display.remove(title3)
		display.remove(title4)
		title1 = nil
		title2 = nil
		title3 = nil
		title4 = nil


		for i=table.getn(levels),1, -1 do
			table.remove(levels,i)
		end

		mx = nil
		print("scores end size is "..table.getn(levels))
		scores = {}


		templevel = nil

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene