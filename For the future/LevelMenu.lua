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


local function showSearch()
	audio.pause(backgroundMusicplay)
	local options = {
		effect = "fade",
		time = 500
	}
	composer.gotoScene("Search",options)
end

local function showRescue()
	audio.pause(backgroundMusicplay)
	local options = {
		effect = "fade",
		time = 500
	}
	composer.gotoScene("Rescue",options)
end

local function Search1()
	myData.searchLvl = 1
	showSearch()
end
local function Search2()
	myData.searchLvl = 2
	showSearch()
end
local function Search3()
	myData.searchLvl = 3
	showSearch()
end

local function Rescue1()
	myData.rescueLvl = 1
	showRescue()
end
local function Rescue2()
	myData.rescueLvl = 2
	showRescue()
end
local function Rescue3()
	myData.rescueLvl = 3
	showRescue()
end


local function gohome( event )
    local options = {
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("MainMenu",options)
end

-- "scene:create()"
function scene:create( event )
	
	--update()
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    local sceneGroup = self.view
    local phase = event.phase

    srchLvl = myData.searchLvl
    rscLvl = myData.rescueLvl
    maxsrch = myData.maxsrch
    maxrsc = myData.maxrsc

    if(myData.searchLvl > maxsrch) then
    	maxsrch = myData.searchLvl
    end
    if(myData.rescueLvl > maxrsc) then
    	maxrsc = myData.rescueLvl
    end

    local background = display.newImage("Images/theme_red/levels_menu.png",system.ResourceDirectory)
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
        homebutton.x=1699
        homebutton.y=122
        homebutton.height=120
        homebutton.width=120
        sceneGroup:insert(homebutton)
		homebutton:addEventListener( "tap", gohome )


		search1 = display.newImage("Images/level1.png")
		search1.anchorX=0
		search1.anchorY=0
		search1.height = 153
		search1.width = 153
		search1.x = 288
		search1.y = 453
		sceneGroup:insert(search1)
		search1:addEventListener( "tap", Search1 )
		
		if(maxrsc > 1)then
			search2 = display.newImage("Images/level2.png")
			search2:addEventListener( "tap", Search2 )
		else
			search2 = display.newImage("Images/level_locked.png")
		end
		search2.anchorX=0
		search2.anchorY=0
		search2.height = 153
		search2.width = 153
		search2.x = 462
		search2.y = 453
		sceneGroup:insert(search2)
		
		
		if(maxrsc > 2)then
			search3 = display.newImage("Images/level3.png")
			search3:addEventListener( "tap", Search3 )
		else
			search3 = display.newImage("Images/level_locked.png")
		end
		search3.anchorX=0
		search3.anchorY=0
		search3.height = 153
		search3.width = 153
		search3.x = 636
		search3.y = 453
		sceneGroup:insert(search3)
		



		if(maxsrch > 1)then
			rescue1 = display.newImage("Images/level1.png")
			rescue1:addEventListener( "tap", showRescue )
		else
			rescue1 = display.newImage("Images/level_locked.png")
		end
		rescue1.anchorX=0
		rescue1.anchorY=0
		rescue1.height = 153
		rescue1.width = 153
		rescue1.x = 1129
		rescue1.y = 453
		sceneGroup:insert(rescue1)
		
		
		if(maxsrch > 2)then
			rescue2 = display.newImage("Images/level2.png")
			rescue2:addEventListener( "tap", showRescue )
		else
			rescue2 = display.newImage("Images/level_locked.png")
		end
		rescue2.anchorX=0
		rescue2.anchorY=0
		rescue2.height = 153
		rescue2.width = 153
		rescue2.x = 1303
		rescue2.y = 453
		sceneGroup:insert(rescue2)
		
		
		if(maxsrch > 3)then
			rescue3 = display.newImage("Images/level3.png")
			rescue3:addEventListener( "tap", showRescue )
		else
			rescue3 = display.newImage("Images/level_locked.png")
		end
		rescue3.anchorX=0
		rescue3.anchorY=0
		rescue3.height = 153
		rescue3.width = 153
		rescue3.x = 1477
		rescue3.y = 453
		sceneGroup:insert(rescue3)
		
		
		audio.resume(backgroundMusicplay)
end


-- "scene:show()"
function scene:show( event )
	
	srchLvl = myData.searchLvl
    rscLvl = myData.rescueLvl
    maxsrch = myData.maxsrch
    maxrsc = myData.maxrsc

    if(myData.searchLvl > maxsrch) then
    	maxsrch = myData.searchLvl
    end
    if(myData.rescueLvl > maxrsc) then
    	maxrsc = myData.rescueLvl
    end
	
    local sceneGroup = self.view
    local phase = event.phase
	
    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
		--local background=display.newRect(display.contentCenterX,display.contentCenterY,1080,720)
		--background:setFillColor(.3,.1,.8)
		
		
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        if(search1 == nil) then
        --home_button
        homebutton = display.newImage("Images/home.png")
        homebutton.anchorX=0
        homebutton.anchorY=0
        homebutton.x=1699
        homebutton.y=122
        homebutton.height=120
        homebutton.width=120
        sceneGroup:insert(homebutton)
		homebutton:addEventListener( "tap", gohome )


		search1 = display.newImage("Images/level1.png")
		search1.anchorX=0
		search1.anchorY=0
		search1.height = 153
		search1.width = 153
		search1.x = 288
		search1.y = 453
		sceneGroup:insert(search1)
		search1:addEventListener( "tap", Search1 )
		
		if(maxrsc > 1)then
			search2 = display.newImage("Images/level2.png")
			search2:addEventListener( "tap", Search2 )
		else
			search2 = display.newImage("Images/level_locked.png")
		end
		search2.anchorX=0
		search2.anchorY=0
		search2.height = 153
		search2.width = 153
		search2.x = 462
		search2.y = 453
		sceneGroup:insert(search2)
		
		
		if(maxrsc > 2)then
			search3 = display.newImage("Images/level3.png")
			search3:addEventListener( "tap", Search3 )
		else
			search3 = display.newImage("Images/level_locked.png")
		end
		search3.anchorX=0
		search3.anchorY=0
		search3.height = 153
		search3.width = 153
		search3.x = 636
		search3.y = 453
		sceneGroup:insert(search3)
		



		if(maxsrch > 1)then
			rescue1 = display.newImage("Images/level1.png")
			rescue1:addEventListener( "tap", showRescue )
		else
			rescue1 = display.newImage("Images/level_locked.png")
		end
		rescue1.anchorX=0
		rescue1.anchorY=0
		rescue1.height = 153
		rescue1.width = 153
		rescue1.x = 1129
		rescue1.y = 453
		sceneGroup:insert(rescue1)
		
		
		if(maxsrch > 2)then
			rescue2 = display.newImage("Images/level2.png")
			rescue2:addEventListener( "tap", showRescue )
		else
			rescue2 = display.newImage("Images/level_locked.png")
		end
		rescue2.anchorX=0
		rescue2.anchorY=0
		rescue2.height = 153
		rescue2.width = 153
		rescue2.x = 1303
		rescue2.y = 453
		sceneGroup:insert(rescue2)
		
		
		if(maxsrch > 3)then
			rescue3 = display.newImage("Images/level3.png")
			rescue3:addEventListener( "tap", showRescue )
		else
			rescue3 = display.newImage("Images/level_locked.png")
		end
		rescue3.anchorX=0
		rescue3.anchorY=0
		rescue3.height = 153
		rescue3.width = 153
		rescue3.x = 1477
		rescue3.y = 453
		sceneGroup:insert(rescue3)
		
		
		audio.resume(backgroundMusicplay)
		end
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
        display.remove(search1)
        search1=nil
        display.remove(search2)
        search2=nil
        display.remove(search3)
        search3=nil
        display.remove(rescue1)
        rescue1=nil
        display.remove(rescue2)
        rescue2=nil
        display.remove(rescue3)
        rescue3=nil
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