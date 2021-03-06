local myData = require( "mydata" )
local composer = require( "composer" )
local JSON = require ("json")
local loadsave = require( "loadsave" )
local scene = composer.newScene()
local App42API = require("App42-Lua-API.App42API")  

local play
local tut
local scores
local credit
local store


-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

--Sends user to the games menu screen
local function showLevel()
	audio.pause(backgroundMusicplay)
	local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
	composer.gotoScene("GamesMenu",options)
end

--Sends user to the credits screen
local function showCredits()
audio.pause(backgroundMusicplay)
	local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
composer.gotoScene("Credits",options)
end

--Sends user to the tutorials menu screen
local function showTutorial()
	audio.pause(backgroundMusicplay)
	local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
composer.gotoScene("TutorialsMenu",options)
end

--Sends user to the leaderboard screen
local function showScores()
	audio.pause(backgroundMusicplay)
	local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
	if(myData.internet == 1)then
		composer.gotoScene("Leaderboard",options)
	else
		composer.showOverlay("no_internet",options)
	end
end

--Sends user to the game store screen
local function showStore()
	audio.pause(backgroundMusicplay)
	local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
	if(myData.internet == 1)then
		composer.gotoScene("Store",options)
	else
		composer.showOverlay("no_internet",options)
	end
end

--Sends user to the settings screen
local function gosettings( event )
    local options = {
    		isModal = true,
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("Settings",options)
end


function check1()
    if (dir == nil) then
        dir = system.DocumentsDirectory;
    end

    local path = system.pathForFile( "agree.json", dir)
    local contents = ""
    local myTable = {}
    local file = io.open( path, "r" )
    if file then
		
         -- read all contents of file into a string
         local contents = file:read( "*a" )
		 
         myTable = JSON.decode(contents);
         io.close( file )
         return myTable 
    end
    return nil
end

function update()
    local path = system.pathForFile( "agree.json", system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = JSON.encode("0")
        file:write( contents )
        io.close( file )
        return true
    else
        return false
    end
end

--Checks if the current user is the top player. This is later used in GamesMenu to determine if the user is allowed to create new content.
local function checkTop()
	local gameName = "Max Scores"
	local max = 5
	local App42CallBack = {}
	App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
	local scoreBoardService = App42API.buildScoreBoardService() 
	scoreBoardService:getTopNRankings(gameName,max,App42CallBack)
	function App42CallBack:onSuccess(object)
		if table.getn(object:getScoreList()) > 1 then
			for i=1,table.getn(object:getScoreList()),1 do
				if(myData.user == object:getScoreList()[i]:getUserName() and myData.isLeader == nil) then
					myData.isLeader = i
				end
				
			end
			if(myData.isLeader == nil) then
				myData.isLeader = 0
			end
		else
			if(myData.user == object:getScoreList():getUserName()) then
				myData.isLeader = 1
			else
				myData.isLeader = 0
			end
		end
	end
	function App42CallBack:onException(exception)
	end
end

local function getExtras()
	myData.buyable = {}
	myData.roboSprites = {}
	myData.scienceSprites = {}
	myData.themeColours = {}
	table.insert(myData.roboSprites, myData.storeItems[8])
	table.insert(myData.scienceSprites, myData.storeItems[9])
	table.insert(myData.themeColours, myData.storeItems[10])
	local dbName  = "USERS"
	local collectionName = "Store"
	local key = "name"
	local value = myData.user
	local App42CallBack = {}
	storageService = App42API:buildStorageService()
	storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)
	function App42CallBack:onSuccess(object)
		for i=1,table.getn(object:getJsonDocList()) do
			myData.storeDoc = object:getJsonDocList()[i]:getDocId()
			if(object:getJsonDocList()[i]:getJsonDoc().robot_santa == 0) then
				table.insert(myData.buyable, myData.storeItems[1])
			else
				table.insert(myData.roboSprites, myData.storeItems[1])
			end
			if(object:getJsonDocList()[i]:getJsonDoc().robot_potato == 0) then
				table.insert(myData.buyable, myData.storeItems[2])
			else
				table.insert(myData.roboSprites, myData.storeItems[2])
			end
			if(object:getJsonDocList()[i]:getJsonDoc().scientist_present == 0) then
				table.insert(myData.buyable, myData.storeItems[3])
			else
				table.insert(myData.scienceSprites, myData.storeItems[3])
			end
			if(object:getJsonDocList()[i]:getJsonDoc().scientist_sadface == 0) then
				table.insert(myData.buyable, myData.storeItems[4])
			else
				table.insert(myData.scienceSprites, myData.storeItems[4])
			end
			if(object:getJsonDocList()[i]:getJsonDoc().theme_yellow == 0) then
				table.insert(myData.buyable, myData.storeItems[5])
			else
				table.insert(myData.themeColours, myData.storeItems[5])
			end
			if(object:getJsonDocList()[i]:getJsonDoc().theme_red == 0) then
				table.insert(myData.buyable, myData.storeItems[6])
			else
				table.insert(myData.themeColours, myData.storeItems[6])
			end
			if(object:getJsonDocList()[i]:getJsonDoc().theme_green == 0) then
				table.insert(myData.buyable, myData.storeItems[7])
			else
				table.insert(myData.themeColours, myData.storeItems[7])
			end
		end
	end
	function App42CallBack:onException(exception)
	end
end


function scene:create( event )
end


function scene:show( event )
	
    local sceneGroup = self.view
    local phase = event.phase
	
    if ( phase == "will" ) then
		if (check1()=="1") then
		else
			local options = {
				isModal = true,
			}
			composer.showOverlay( "permission", options )
		end

		local userSettings = {
            user = myData.user,
            search = myData.maxsrch,
            rescue = myData.maxrsc,
            theme = myData.theme,
            volume = myData.musicVol,
            sfx = myData.sfx,
            robot = myData.roboSprite,
            science = myData.scienceSprite,
            keys = myData.savedkeys,
            credits = myData.credits,
            stopwatch = myData.savedclocks }
        loadsave.saveTable( userSettings, "user.json" )

		--background image
		local background = display.newImage("Images/theme_"..myData.theme.."/splash_main.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080
		background.width=1920
		background.x= display.contentCenterX
		background.y=display.contentCenterY
		sceneGroup:insert(background)

		--if no user is logged in, this opens the login/registration overlay
		local options = {
			isModal = true,
            effect = "crossFade",
            time = 500
        }
		if (myData.user == nil or myData.user == "nil")then
			composer.showOverlay("start_user", options)

		--if a logged user is found, the normal main menu is then loaded
		else
			--settings_button
	        settingsbutton = display.newImage("Images/Settings.png")
	        settingsbutton.anchorX=0
	        settingsbutton.anchorY=0
	        settingsbutton.x=95
	        settingsbutton.y=170
	        settingsbutton.height=120
	        settingsbutton.width=120
	        sceneGroup:insert(settingsbutton)
			settingsbutton:addEventListener( "tap", gosettings )
			
			--play_button
			play = display.newImage("Images/Play.png")
			play.height=180
			play.width=350
			play.x = display.contentCenterX
			play.y=display.contentCenterY-160
			sceneGroup:insert(play)
			play:addEventListener( "tap", showLevel )
			
			--tutorials_button
			tut = display.newImage("Images/Tutorial.png")
			tut.height=163
			tut.width=528
			tut.x = display.contentCenterX - 435
			tut.y=display.contentCenterY+40
			sceneGroup:insert(tut)
			tut:addEventListener( "tap", showTutorial )
			
			--scores_button
			scores = display.newImage("Images/scores.png")
			scores.height=163
			scores.width=416
			scores.x = display.contentCenterX - 435
			scores.y=display.contentCenterY+260
			sceneGroup:insert(scores)
			scores:addEventListener( "tap", showScores )

			--credits_button
			credit = display.newImage("Images/Credits.png")
			credit.height=163
			credit.width=470
			credit.x = display.contentCenterX + 435
			credit.y=display.contentCenterY+260
			sceneGroup:insert(credit)
			credit:addEventListener( "tap", showCredits )

			--store_button
			store = display.newImage("Images/store.png")
			store.height=163
			store.width=353
			store.x = display.contentCenterX + 435
			store.y=display.contentCenterY+40
			sceneGroup:insert(store)
			store:addEventListener( "tap", showStore )
		end

		checkTop()
		getExtras()

    elseif ( phase == "did" ) then
		audio.resume(backgroundMusicplay)
    end
end


function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    	if(store ~= nil) then
        	store:removeEventListener( "tap", showStore )
        end
        if(credit ~= nil) then
        	credit:removeEventListener( "tap", showCredits )
        end
        if(tut ~= nil) then
        	tut:removeEventListener( "tap", showTutorial )
        end
        if(play ~= nil) then
        	play:removeEventListener( "tap", showLevel )
        end
        if(settingsbutton ~= nil) then
        	settingsbutton:removeEventListener( "tap", gosettings )
        end
        if(scores ~= nil) then
        	scores:removeEventListener( "tap", showScores )
        end
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


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