local parse = require( "mod_parse" )
local myData = require( "mydata" )
local composer = require( "composer" )
local JSON = require ("json")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


local function showLevel()
	audio.pause(backgroundMusicplay)
	local options = {
		effect = "fade",
		time = 500
	}
	composer.gotoScene("GamesMenu",options)
	--if(myData.rescue == 1) then
	--	composer.gotoScene("Rescue",options)
	--	print("Going to Rescue")
	--else
	--	composer.gotoScene("Search",options)
	--end
end

local function showCredits()
audio.pause(backgroundMusicplay)
	local options = {
		effect = "crossFade",
		time = 500
	}
composer.gotoScene("Credits",options)
end

local function showTutorial()
	audio.pause(backgroundMusicplay)
	local options = {
		effect = "crossFade",
		time = 500
	}
		composer.gotoScene("TutorialsMenu",options)
end

local function showScores()
	audio.pause(backgroundMusicplay)
	local options = {
		effect = "crossFade",
		time = 500
	}
		composer.gotoScene("Credits",options)
end

local function showStore()
	audio.pause(backgroundMusicplay)
	local options = {
		effect = "crossFade",
		time = 500
	}
		composer.gotoScene("Credits",options)
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
        -- Called when the scene is still off screen (but is about to come on screen).
		--local background=display.newRect(display.contentCenterX,display.contentCenterY,1080,720)
		--background:setFillColor(.3,.1,.8)
		if (check1()=="1") then
		
		else
		local options = {
			isModal = true,
				}
			
			composer.showOverlay( "permission", options )
		end
		local background = display.newImage("Images/theme_red/splash_main.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080
		background.width=1920
		background.x= display.contentCenterX
		background.y=display.contentCenterY
		sceneGroup:insert(background)
		
		
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        

		local play = display.newImage("Images/Play.png")
		play.height=180
		play.width=350
		play.x = display.contentCenterX
		play.y=display.contentCenterY-160
		sceneGroup:insert(play)
		play:addEventListener( "tap", showLevel )
		
		local tut = display.newImage("Images/Tutorial.png")
		tut.height=163
		tut.width=528
		tut.x = display.contentCenterX - 435
		tut.y=display.contentCenterY+40
		sceneGroup:insert(tut)
		tut:addEventListener( "tap", showTutorial )
		
		local scores = display.newImage("Images/scores.png")
		scores.height=163
		scores.width=416
		scores.x = display.contentCenterX - 435
		scores.y=display.contentCenterY+260
		sceneGroup:insert(scores)
		scores:addEventListener( "tap", showScores )

		local credit = display.newImage("Images/Credits.png")
		credit.height=163
		credit.width=470
		credit.x = display.contentCenterX + 435
		credit.y=display.contentCenterY+260
		sceneGroup:insert(credit)
		credit:addEventListener( "tap", showCredits )

		local store = display.newImage("Images/store.png")
		store.height=163
		store.width=353
		store.x = display.contentCenterX + 435
		store.y=display.contentCenterY+40
		sceneGroup:insert(store)
		store:addEventListener( "tap", showStore )
		
		audio.resume(backgroundMusicplay)
		
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
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