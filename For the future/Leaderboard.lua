local parse = require( "mod_parse" )
local myData = require( "mydata" )
local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()
local JSON = require ("json")
local loadsave = require( "loadsave" ) 

local App42API = require("App42-Lua-API.App42API") 
App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
local scoreBoardService = App42API.buildScoreBoardService()
local App42CallBack = {}

local scores 
local tempuser
local mx
local rankbox 
local userbox 
local scorebox 
local title1
local title2
local title3
local tableView
local trial
local ranknum
local userranked
local rankscore

local homebutton


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

local function printRanks()
	mx = table.getn(scores)
	for i=1, 5, 1 do
		ranknum = {
    		text = '\t\t'..i,    
    		x = display.contentCenterX,
    		y = display.contentCenterY - 60 + (i-1)*80,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "left"  --new alignment parameter
		}
		rankbox[i] = display.newText(ranknum)	
	end
	for i=1, 5, 1 do
		userranked = {
    		text = scores[i][1],    
    		x = display.contentCenterX + 450,
    		y = display.contentCenterY - 60 + (i-1)*80,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "left"  --new alignment parameter
		}
		userbox[i] = display.newText(userranked)	
	end
	for i=1, 5, 1 do
		rankscore = {
    		text = scores[i][2],    
    		x = display.contentCenterX + 900,
    		y = display.contentCenterY - 60 + (i-1)*80,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "left"  --new alignment parameter
		}
		scorebox[i] = display.newText(rankscore)	
	end
	if(myData.leader == 6) then
		--local num = table.indexOf( scores, 9 ) )
		ranknum = {
    		text = '\t\t'..mx,    
    		x = display.contentCenterX,
    		y = display.contentCenterY - 60 + (6-1)*80,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "left"  --new alignment parameter
		}
		rankbox[6] = display.newText(ranknum)	
		userranked = {
    		text = scores[mx][1],    
    		x = display.contentCenterX + 450,
    		y = display.contentCenterY - 60 + (6-1)*80,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "left"  --new alignment parameter
		}
		userbox[6] = display.newText(userranked)
		rankscore = {
    		text = scores[mx][2],    
    		x = display.contentCenterX + 900,
    		y = display.contentCenterY - 60 + (6-1)*80,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "left"  --new alignment parameter
		}
		scorebox[6] = display.newText(rankscore)
	end

end

function getRanks()
	local gameName = "Max Scores"
	local max = 5
	App42CallBack = {} 
	App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
	scoreBoardService = App42API.buildScoreBoardService()
	scoreBoardService:getTopRankings(gameName,App42CallBack)  
	function App42CallBack:onSuccess(object)
		if table.getn(object:getScoreList()) > 1 then
			for i=1,table.getn(object:getScoreList()),1 do
				if(object:getScoreList()[i]:getUserName() == myData.user) then
					myData.leader = i
				end
				tempuser = {object:getScoreList()[i]:getUserName(),object:getScoreList()[i]:getValue()}
				table.insert( scores, tempuser )
				if(myData.leader >5) then
					myData.leader = 6
					break
				end
			end
		else
			tempuser = {object:getScoreList()[i]:getUserName(),object:getScoreList()[i]:getValue()}
			table.insert( scores, tempuser )
		end
		printRanks()
		

	end
	function App42CallBack:onException(exception)
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
    		y = display.contentCenterY - 220,
    		width = 1920-940,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "center"  --new alignment parameter
		}
		trial=display.newText(optionsText)
		sceneGroup:insert(trial)	


    	mx = 0
    	scores = {}
    	rankbox = {}
		userbox = {}
		scorebox = {}
		tempuser = nil
		ranknum = {}
		userranked = {}
		rankscore = {}
		App42CallBack = {}
		myData.leader = 0

		

		-- Create the widget
		tableView = widget.newTableView
		{
		    x = display.contentCenterX,
		    y = display.contentCenterY + 100,
		    height = 560,
		    width = 1200,
		    onRowRender = onRowRender,
		    onRowTouch = onRowTouch,
		    listener = scrollListener,
		    backgroundColor = { 0.8, 0.8, 0.8, 0.2 }
		}

		-- Insert 5 rows to tableview
		for i = 1, 7 do
		    local isCategory = false
		    local rowHeight = 80
		    local rowColor = { default={ 1, 1, 1, 0.2}, over={ 1, 0.5, 0, 0.2 } }
		    local lineColor = { 0.5, 0.5, 0.5 }
		    -- Make some rows categories
		    if ( i == 1) then
		        isCategory = true
		        rowHeight = 80
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


		local RankTitle = {
    		text = '\t'.."Rank",    
    		x = display.contentCenterX,
    		y = display.contentCenterY - 140,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "left"  --new alignment parameter
		}
		title1=display.newText(RankTitle)
		sceneGroup:insert(title1)

		local UserTitle = {
    		text = "\User",    
    		x = display.contentCenterX + 450,
    		y = display.contentCenterY - 140,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "left"  --new alignment parameter
		}
		title2=display.newText(UserTitle)
		sceneGroup:insert(title2)	

		local ScoreTitle = {
    		text = "Score",    
    		x = display.contentCenterX + 900,
    		y = display.contentCenterY - 140,
    		width = 1200,     --required for multi-line and alignment
    		font = native.systemFontBold,   
    		fontSize = 48,
    		align = "left"  --new alignment parameter
		}
		title3=display.newText(ScoreTitle)
		sceneGroup:insert(title3)
		

		getRanks()

		for i=1,table.getn(rankbox), 1 do
			sceneGroup:insert(rankbox[i])
			sceneGroup:insert(userbox[i])
			sceneGroup:insert(scorebox[i])
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
		ranknum = nil
		userranked = nil
		rankscore = nil
		rankbox = {}
		userbox = {}
		scorebox = {}

		display.remove(title1)
		display.remove(title2)
		display.remove(title3)
		title1 = nil
		title2 = nil
		title3 = nil


		for i=table.getn(scores),1, -1 do
			table.remove(scores,i)
		end

		mx = nil
		scores = {}


		tempuser = nil

		display.remove(trial)
		trial = nil

    elseif ( phase == "did" ) then
    	homebutton:removeEventListener( "tap", gohome )
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