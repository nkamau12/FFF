local parse = require( "mod_parse" )
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
		composer.gotoScene("Leaderboard",options)
end

--Sends user to the game store screen
local function showStore()
	audio.pause(backgroundMusicplay)
	local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
		composer.gotoScene("Store",options)
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

local function checkTop()
	local gameName = "Max Scores"
	local max = 1
	local App42CallBack = {}
	App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
	local scoreBoardService = App42API.buildScoreBoardService() 
	scoreBoardService:getTopNRankings(gameName,max,App42CallBack)
	function App42CallBack:onSuccess(object)
		print("Game name is "..object:getName())
		print("userName is : "..object:getScoreList():getUserName())
		if(myData.user == object:getScoreList():getUserName()) then
			myData.isLeader = 1
		else
			myData.isLeader = 0
		end
		print("score is : "..object:getScoreList():getValue())
		print("scoreId is : "..object:getScoreList():getScoreId())
		print("isLeader is "..myData.isLeader)
	end
	function App42CallBack:onException(exception)
		print("Message is : "..exception:getMessage())
	end
end




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
        print("start MainMenu")
		if (check1()=="1") then
		
		else
		local options = {
			isModal = true,
				}
			
			composer.showOverlay( "permission", options )
		end

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
		if (myData.user == nil)then
			composer.showOverlay("start_user", options)
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

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
		audio.resume(backgroundMusicplay)
		
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        store:removeEventListener( "tap", showStore )
        credit:removeEventListener( "tap", showCredits )
        tut:removeEventListener( "tap", showTutorial )
        play:removeEventListener( "tap", showLevel )
        settingsbutton:removeEventListener( "tap", gosettings )
        scores:removeEventListener( "tap", showScores )
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