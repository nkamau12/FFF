local parse = require( "mod_parse" )
local myData = require( "mydata" )
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local widget = require("widget")

local picToAdd=""

local table1 = {}
local table2 = {}
local table3 = {}
local fintable = {}
local counter = 1;
local robo
local buttonTable = {}
local picTable = {}
local pics = 
{	11,12,13,14,15,21,22,23,24,25,31,32,33,34,35
}
local setupItems2 = {}

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function setupPic(name, pic, xVal, yVal, hVal,wVal)

	setupItems2[name] = display.newImage(pic)
	setupItems2[name].anchorX = 0
	setupItems2[name].anchorY =0
	setupItems2[name].x = xVal
	setupItems2[name].y = yVal
	setupItems2[name].height = hVal
	setupItems2[name].width= wVal

end

local function setupmap()
		--grid
		setupPic("grida", "rescue_grid.png", 43.01, 41.93, 993.04, 993.04)

		--left_wall
		setupPic("leftwall", "side_wall.png", 43.01, 41.93, 993.04, 10)
		
		--right_wall
		setupPic("rightwall", "side_wall.png", 1026.05, 41.93, 993.04, 10)

		--top_wall
		setupPic("topwall", "topbottom_wall.png", 43.01, 41.93, 10, 993.04)
		
		--bottom_wall
		setupPic("bottomwall", "topbottom_wall.png", 43.01, 1024.97, 10, 993.04)
				
		--one_loop
		setupPic("onel", "one_loop.png", 1063.96, 625, 133, 805)
				
		--two_loop
		setupPic("twol", "two_loop.png", 1063.96, 768, 133, 805)
				
		--three_loop
		setupPic("threel", "three_loop.png", 1063.96, 910, 133, 805)
		
		--up_arrow
		setupPic("upa", "up_arrow.png", 1192, 186, 122, 122)
				
		--down_arrow
		setupPic("downa", "down_arrow.png", 1330, 186, 122, 122)
				
		--left_arrow
		setupPic("lefta", "left_arrow.png", 1468, 186, 122, 122)
				
		--right_arrow
		setupPic("righta", "right_arrow.png", 1606, 186, 122, 122)
				
		--one_button
		setupPic("oneb", "one_button.png", 1261, 332, 122, 122)
				
		--two_button
		setupPic("twob", "two_button.png", 1399, 332, 122, 122)
				
		--three_button
		setupPic("threeb", "three_button.png", 1538, 332, 122, 122)
				
		--start_button
		setupPic("start", "start_button.png", 46, 968, 66, 246)

		--start_button
		setupPic("home", "home.png", 1766, 28, 120, 120)
		

		--scientist
		science3= display.newImage("scientist.png")
		science3.anchorX=0
		science3.anchorY=0
		science3.x=843
		science3.y=348
		science3.height=140
		science3.width=140

		--robot
		local robot= display.newImage("robot.png")
		robot.anchorX=0
		robot.anchorY=0
		robot.x=109
		robot.y=819
		robot.height=140
		robot.width=140
		robot.myName="robot"
		
		--physics add bodies
		physics.start()
		physics.setGravity( 0, 0 )
		--walls
		
		physics.addBody( setupItems2["leftwall"], "static",{bounce=0})
		physics.addBody( setupItems2["rightwall"], "static",{bounce=0})
		physics.addBody( setupItems2["topwall"], "static",{bounce=0})
		physics.addBody( setupItems2["bottomwall"], "static",{bounce=0})
		--robot
		physics.addBody( robot,"dynamic",{bounce=0,friction=.8})
		robot.isFixedRotation = true
		robo=robot
		--Misc
		local robotX, robotY = robo:localToContent( -70, -70 )
		myrectu = display.newRect( robotX, robotY-248, 1, 1)
		physics.addBody( myrectu, "static",{bounce=0})
		myrectd = display.newRect( robotX, robotY+248, 1, 1)
		physics.addBody( myrectd, "static",{bounce=0})
		myrectl = display.newRect( robotX-248, robotY, 1, 1)
		physics.addBody( myrectl, "static",{bounce=0})
		myrectr = display.newRect( robotX+248, robotY, 1, 1)
		physics.addBody( myrectr, "static",{bounce=0})
		
		--scientist
		physics.addBody( science3, "static",{bounce=0})
end 


local function handleButtonEvent( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        if(event.target.id == "oneloopBtn1") then
			table1[1] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 1)
		end
		if(event.target.id == "oneloopBtn2") then
			table1[2] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 2)
		end
		if(event.target.id == "oneloopBtn3") then
			table1[3] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 3)
		end
		if(event.target.id == "oneloopBtn4") then
			table1[4] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 4)
		end
		if(event.target.id == "oneloopBtn5") then
			table1[5] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 5)
		end
		if(event.target.id == "twoloopBtn1") then
			table2[1] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 6)
		end
		if(event.target.id == "twoloopBtn2") then
			table2[2] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 7)
		end
		if(event.target.id == "twoloopBtn3") then
			table2[3] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 8)
		end
		if(event.target.id == "twoloopBtn4") then
			table2[4] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 9)
		end
		if(event.target.id == "twoloopBtn5") then
			table2[5] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 10)
		end
		if(event.target.id == "threeloopBtn1") then
			table3[1] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 11)
		end
		if(event.target.id == "threeloopBtn2") then
			table3[2] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 12)
		end
		if(event.target.id == "threeloopBtn3") then
			table3[3] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 13)
		end
		if(event.target.id == "threeloopBtn4") then
			table3[4] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 14)
		end
		if(event.target.id == "threeloopBtn5") then
			table3[5] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 15)
		end
    end
end

function addPicTo(position, name, xVal, yVal)
	picTable[position] = display.newImage(name)
	picTable[position].anchorX = 0.5
	picTable[position].anchorY = 0.5
	picTable[position].x = xVal
	picTable[position].y = yVal
	picTable[position].height = 120
	picTable[position].width = 120
	picTable[position].id = name

end


function addPic(xVal,yVal,name,spot)

	if((picTable[spot]== nil) and (picToAdd == ""))then
		emptyloop = emptyloop + 1
		local function onEmptyRescue( event )
        	if not event.error then
            	print( event.response.updatedAt )
        	end
    	end
    	local dataTable = {["Rescue3"] = emptyloop }
    	parse:updateObject("EmptyCount", myData.emptyid, dataTable, onEmptyRescue)

	elseif(picTable[spot] == nil) then
		addPicTo(spot, name, xVal, yVal)
	elseif (picToAdd == "") then
		picTable[spot]:removeSelf()
		picTable[spot] = nil

		undoloop = undoloop + 1
		local function onUndoSearch( event )
        	if not event.error then
            	print( event.response.updatedAt )
        	end
    	end
    	local dataTable = {["Rescue3"] = undoloop }
    	parse:updateObject("UndoCount", myData.undoid, dataTable, onUndoSearch)
		
	else
		picTable[spot]:removeSelf()
		addPicTo(spot, name, xVal, yVal)	
		undoloop = undoloop + 1
		local function onUndoSearch( event )
        	if not event.error then
            	print( event.response.updatedAt )
        	end
    	end
    	local dataTable = {["Rescue3"] = undoloop }
    	parse:updateObject("UndoCount", myData.undoid, dataTable, onUndoSearch)

		
	end
	picToAdd = ""
	
end

local function moveu()
		robo:applyForce( 0, -200, robo.x+300, robo.y+70 )
end

local function moveup()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectu, { time=16, x=robotX, y=robotY-250} )
		--transition.to( myrectl, { time=16, x=robotX, y=robotY-240} )
		timer.performWithDelay(20,moveu)
end

local function moveri()
		robo:applyForce( 200, 0, robo.x+70, robo.y+70 )	
end

local function mover()
		--local robotX, robotY = robot:localToContent( -70, -70 )
		--transition.to( robot, { time=500, x=robotX+240, y=robotY} )
		--physics.removeBody( myrect )
		--myrect:removeSelf()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectr, { time=16, x=robotX+320, y=robotY} )
		
		timer.performWithDelay(20,moveri)
end

local function movedo()
		robo:applyForce( 0, 200, robo.x+70, robo.y+70 )
end

local function moved()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectd, { time=16, x=robotX, y=robotY+390} )
		
		timer.performWithDelay(20,movedo)	
end

local function movele()
		robo:applyForce( -200, 0, robo.x+70, robo.y+70 )
end

local function movel()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, { loops=0 } )
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectl, { time=16, x=robotX-320, y=robotY} )
		
		timer.performWithDelay(20,movele)	
end



local function mdtap()
	picToAdd = "down_arrow.png"
end

local function mutap()
	picToAdd = "up_arrow.png"
end

local function mrtap()
	picToAdd = "right_arrow.png"
end

local function mltap()
	picToAdd = "left_arrow.png"
end

local function onetap()
	picToAdd = "one_button.png"
end

local function twotap()
	picToAdd = "two_button.png"
end

local function threetap()
	picToAdd = "three_button.png"
end

function scene:resetrobot()
		
		transition.moveTo( robo, { time=0, x=109, y=819} )
		timer.performWithDelay(20,restartr)	
end


function restartr()
	
		local robotX, robotY = robo:localToContent( -70, -70 )
		transition.to( myrectu, { time=16, x=robotX, y=robotY-240} )
		transition.to( myrectl, { time=16, x=robotX-240, y=robotY} )
		transition.to( myrectd, { time=16, x=robotX, y=robotY+240} )
		transition.to( myrectr, { time=16, x=robotX+240, y=robotY} )
		fintable=nil
		fintable={}
		counter=1
end


local function findsize()
	if (fintable~=nil) then
	local count =1;
	while (fintable[count]~=nil) do
		count=count+1
	end
	return count
	else
	return 0
	end
end

local function moverobot()
	local max = findsize()
	--[[for i = 1, max,1 do
		if (fintable[i]=="up_arrow.png") then
			--moveup()
			timer.performWithDelay(50,moveup)
		elseif (fintable[i]=="down_arrow.png") then
			--moved()
			timer.performWithDelay(50,moved)
		elseif (fintable[i]=="left_arrow.png") then
			--movel()
			timer.performWithDelay(50,movel)
		elseif (fintable[i]=="right_arrow.png") then
			--mover()
			timer.performWithDelay(50,mover)
		else
		end
		
	end]]--
	if not (counter>max) then
		if (fintable[counter]=="up_arrow.png") then
			moveup()
			--timer.performWithDelay(50,moveup)
		elseif (fintable[counter]=="down_arrow.png") then
			moved()
			--timer.performWithDelay(50,moved)
		elseif (fintable[counter]=="left_arrow.png") then
			movel()
			--timer.performWithDelay(50,movel)
		elseif (fintable[counter]=="right_arrow.png") then
			mover()
			--timer.performWithDelay(50,mover)
		else
			local options = {
			isModal = true,
			
			params = {
			sampleVar = "my sample variable"
				}
			}
			composer.showOverlay( "fail1", options )
		end
		counter=counter+1
	else
		local options = {
			isModal = true,
			
			params = {
			sampleVar = "my sample variable"
				}
			}
			composer.showOverlay( "fail", options )
	end	
end
local function onCollision( event )
		if (event.object2==myrectu or event.object2==myrectd or event.object2==myrectl or event.object2==myrectr) then
			if ( event.phase == "began" ) then
				moverobot()
			end
		elseif (event.object2==science3) then
			print("Scientist")
			local options = {
				effect = "crossFade",
				time = 500
			}
			audio.stop(elevatorMusicplay)
			audio.pause(backgroundMusicplay)
			physics.stop()
			composer.gotoScene("Credits",options)
		elseif (event.object2==setupItems2["bottomwall"] or
		event.object2==setupItems2["topwall"] or event.object2==setupItems2["leftwall"] or event.object2==setupItems2["rightwall"]) then
			local options = {
			isModal = true,
			
			params = {
			sampleVar = "my sample variable"
				}
			}
			composer.showOverlay( "fail", options )
		end

end 



local function merge(tablel)
	
	for i=1,5,1 do
		print(tablel[i])
		if (tablel[i]=="one_button.png") then
			merge(table1)
		elseif (tablel[i]=="two_button.png") then
			merge(table2)
		elseif (tablel[i]=="three_button.png") then
			merge(table3)
		elseif ( tablel[i]=="up_arrow.png" or tablel[i]=="down_arrow.png" or tablel[i]=="left_arrow.png" or tablel[i]=="right_arrow.png") then
			table.insert(fintable,tablel[i])
		else
		end
	end
end


local function pass()
	runrescue = runrescue + 1
    local function onRunningObject( event )
        if not event.error then
            print( event.response.updatedAt )
        end
    end
    local runsearchTable = {["Rescue3"] = runrescue }
    parse:updateObject("RunCount", myData.runid, runsearchTable, onRunningObject)

	merge(table1)
	moverobot()
	
end

local function gohome()
	homerescue = homerescue + 1

    local function onUpdateObject( event )
        if not event.error then
            print( event.response.updatedAt )
        end
    end
    local dataTable = {["Rescue3"] = homerescue }
    parse:updateObject("HomeCount", myData.homeid, dataTable, onUpdateObject)

    local options = {
				effect = "crossFade",
				time = 500
			}
			audio.stop(elevatorMusicplay)
			audio.pause(backgroundMusicplay)
			composer.gotoScene("MainMenu",optionsh)
end

local function addButton(position, xPos, yPos,idName)
	
	buttonTable[position] = widget.newButton
	{
		width = 120,
	    height = 120,
		x = xPos ,
		y = yPos ,
		id = idName,
		onEvent = handleButtonEvent
	}

end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    elevatorMusic = audio.loadStream( "bensound-theelevatorbossanova.mp3")
	elevatorMusicplay = audio.play( elevatorMusic, {  fadein = 4000, loops=-1 } )
    

	homerescue = 0
	runrescue = 0
	undoloop = 0
	emptyloop = 0

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
	local background = display.newImage("rescue_background.png",system.ResourceDirectory)
	background.anchorX=0.5
	background.anchorY=0.5
	background.height=1080
	background.width=1920
	background.x= display.contentCenterX
	background.y=display.contentCenterY
	sceneGroup:insert(background)
	
	--buttons
	
	--one loop button
	addButton(11, 1270.21, 690.86, "oneloopBtn1")
	addButton(12, 1402.21, 690.86, "oneloopBtn2")
	addButton(13, 1530.21, 690.86, "oneloopBtn3")
	addButton(14, 1660.21, 690.86, "oneloopBtn4")
	addButton(15, 1790.21, 690.86, "oneloopBtn5")
	
	--two loop buttons
	addButton(21, 1270.21, 835.86, "twoloopBtn1")
	addButton(22, 1402.21, 835.86, "twoloopBtn2")
	addButton(23, 1530.21, 835.86, "twoloopBtn3")
	addButton(24, 1660.21, 835.86, "twoloopBtn4")
	addButton(25, 1790.21, 835.86, "twoloopBtn5")
	
	--three loop buttons
	addButton(31, 1270.21, 980.86, "threeloopBtn1")
	addButton(32, 1402.21, 980.86, "threeloopBtn2")
	addButton(33, 1530.21, 980.86, "threeloopBtn3")
	addButton(34, 1660.21, 980.86, "threeloopBtn4")
	addButton(35, 1790.21, 980.86, "threeloopBtn5")
	
	setupmap()
		
	--robo.collision = onLocalCollision
	--robo:addEventListener( "collision", robo )
	Runtime:addEventListener( "collision", onCollision )
	
	setupItems2["upa"]:addEventListener( "tap", mutap )
	setupItems2["downa"]:addEventListener( "tap", mdtap )
	setupItems2["lefta"]:addEventListener( "tap", mltap )
	setupItems2["righta"]:addEventListener( "tap", mrtap )
	setupItems2["oneb"]:addEventListener("tap", onetap)
	setupItems2["twob"]:addEventListener("tap", twotap)
	setupItems2["threeb"]:addEventListener("tap", threetap)
	setupItems2["start"]:addEventListener("tap", pass)
	setupItems2["home"]:addEventListener("tap", gohome)
	
	--add buttons
	sceneGroup:insert(buttonTable[11])
	sceneGroup:insert(buttonTable[12])
	sceneGroup:insert(buttonTable[13])
	sceneGroup:insert(buttonTable[14])
	sceneGroup:insert(buttonTable[15])
	
	sceneGroup:insert(buttonTable[21])
	sceneGroup:insert(buttonTable[22])
	sceneGroup:insert(buttonTable[23])
	sceneGroup:insert(buttonTable[24])
	sceneGroup:insert(buttonTable[25])
	
	sceneGroup:insert(buttonTable[31])
	sceneGroup:insert(buttonTable[32])
	sceneGroup:insert(buttonTable[33])
	sceneGroup:insert(buttonTable[34])
	sceneGroup:insert(buttonTable[35])
	
	--add grid
	sceneGroup:insert(setupItems2["grida"])
	sceneGroup:insert(setupItems2["onel"])
	sceneGroup:insert(setupItems2["twol"])
	sceneGroup:insert(setupItems2["threel"])
	sceneGroup:insert(setupItems2["upa"])
	sceneGroup:insert(setupItems2["downa"])
	sceneGroup:insert(setupItems2["lefta"])
	sceneGroup:insert(setupItems2["righta"])
	sceneGroup:insert(setupItems2["oneb"])
	sceneGroup:insert(setupItems2["twob"])
	sceneGroup:insert(setupItems2["threeb"])
	sceneGroup:insert(setupItems2["start"])
	sceneGroup:insert(setupItems2["home"])
	
	--add character
	sceneGroup:insert(robo)
	sceneGroup:insert(science3)
	
	--add walls

	sceneGroup:insert(setupItems2["bottomwall"])
	sceneGroup:insert(setupItems2["topwall"])
	sceneGroup:insert(setupItems2["leftwall"])
	sceneGroup:insert(setupItems2["rightwall"])
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
		
		
		
    elseif ( phase == "did" ) then
        
		
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
		for i = 15, 1, -1 do
			if(not(picTable[i]== nil)) then
				picTable[i]:removeSelf()
			end
		end
		restartr()
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