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
local search = {}
local rescue = {}

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

local function Searchnum(event)
	print(event.target.name)
	myData.searchLvl = event.target.name
	showSearch()
end


local function Rescuenum(event)
	myData.rescueLvl = event.target.name
	print("Going to rescue "..event.target.name)
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

    local background = display.newImage("Images/theme_"..myData.theme.."/levels_menu.png",system.ResourceDirectory)
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


		search[1] = display.newImage("Images/level1.png")
		search[1].anchorX=0
		search[1].anchorY=0
		search[1].height = 153
		search[1].width = 153
		search[1].x = 208
		search[1].y = 433
		search[1].name = 1
		sceneGroup:insert(search[1])
		search[1]:addEventListener( "tap", Searchnum )
		

		for l=2,12,1 do 
			m = l - 1
			if(maxrsc > m)then
				search[l] = display.newImage("Images/level"..l..".png")
				search[l]:addEventListener( "tap", Searchnum )
			else
				search[l] = display.newImage("Images/level_locked.png")
			end
			search[l].anchorX=0
			search[l].anchorY=0
			search[l].height = 153
			search[l].width = 153
			if(l==2 or l==3 or l==4)then
				search[l].x = 208 + (m*174)
				search[l].y = 433
			elseif(l==5 or l==6 or l==7 or l==8)then
				search[l].x = 208 + ((l-5)*174)
				search[l].y = 607
			else
				search[l].x = 208 + ((l-9)*174)
				search[l].y = 781
			end
			search[l].name = l
			sceneGroup:insert(search[l])
		end

		
		for l=1,12,1 do 
			if(maxsrch > l)then
				rescue[l] = display.newImage("Images/level"..l..".png")
				rescue[l]:addEventListener( "tap", Rescuenum )
			else
				rescue[l] = display.newImage("Images/level_locked.png")
			end
			rescue[l].anchorX=0
			rescue[l].anchorY=0
			rescue[l].height = 153
			rescue[l].width = 153
			if(l==1 or l==2 or l==3 or l==4)then
				rescue[l].x = 1039 + ((l-1)*174)
				rescue[l].y = 433
			elseif(l==5 or l==6 or l==7 or l==8)then
				rescue[l].x = 1039 + ((l-5)*174)
				rescue[l].y = 607
			else
				rescue[l].x = 1039 + ((l-9)*174)
				rescue[l].y = 781
			end
			rescue[l].name = l
			sceneGroup:insert(rescue[l])
		end



		
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
        if(search[1] == nil) then
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


		search[1] = display.newImage("Images/level1.png")
		search[1].anchorX=0
		search[1].anchorY=0
		search[1].height = 153
		search[1].width = 153
		search[1].x = 208
		search[1].y = 433
		search[1].name = 1
		sceneGroup:insert(search[1])
		search[1]:addEventListener( "tap", Searchnum )
		

		for l=2,12,1 do 
			m = l - 1
			if(maxrsc > m)then
				search[l] = display.newImage("Images/level"..l..".png")
				search[l]:addEventListener( "tap", Searchnum )
			else
				search[l] = display.newImage("Images/level_locked.png")
			end
			search[l].anchorX=0
			search[l].anchorY=0
			search[l].height = 153
			search[l].width = 153
			if(l==2 or l==3 or l==4)then
				search[l].x = 208 + (m*174)
				search[l].y = 433
			elseif(l==5 or l==6 or l==7 or l==8)then
				search[l].x = 208 + ((l-5)*174)
				search[l].y = 607
			else
				search[l].x = 208 + ((l-9)*174)
				search[l].y = 781
			end
			search[l].name = l
			sceneGroup:insert(search[l])
		end

		for l=1,12,1 do 
			if(maxsrch > l)then
				rescue[l] = display.newImage("Images/level"..l..".png")
				rescue[l]:addEventListener( "tap", Rescuenum )
			else
				rescue[l] = display.newImage("Images/level_locked.png")
			end
			rescue[l].anchorX=0
			rescue[l].anchorY=0
			rescue[l].height = 153
			rescue[l].width = 153
			if(l==1 or l==2 or l==3 or l==4)then
				rescue[l].x = 1039 + ((l-1)*174)
				rescue[l].y = 433
			elseif(l==5 or l==6 or l==7 or l==8)then
				rescue[l].x = 1039 + ((l-5)*174)
				rescue[l].y = 607
			else
				rescue[l].x = 1039 + ((l-9)*174)
				rescue[l].y = 781
			end
			rescue[l].name = l
			sceneGroup:insert(rescue[l])
		end
		
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
        i = 1
        while(rescue[i] ~= nil) do
			display.remove( rescue[i])
			rescue[i]=nil
			i = i + 1
		end
		i = 1
        while(search[i] ~= nil) do
			display.remove( search[i])
			search[i]=nil
			i = i + 1
		end
		i = 1
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