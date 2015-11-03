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
local robot
local buttonTable = {}
local picTable = {}
local pics = 
{	11,12,13,14,15,21,22,23,24,25,31,32,33,34,35
}
local setupItems = {}
local myrectd
local myrectu
local myrectl
local myrectr

local currwall

local i = 1

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function setupPic(name, pic, xVal, yVal, hVal,wVal)

	setupItems[name] = display.newImage(pic)
	setupItems[name].anchorX = 0
	setupItems[name].anchorY =0
	setupItems[name].x = xVal
	setupItems[name].y = yVal
	setupItems[name].height = hVal
	setupItems[name].width= wVal

end

local function setupmap()

	--grid & outer walls
	setupPic("grida", myData.grida[5], myData.grida[1], myData.grida[2], myData.grida[3], myData.grida[4])
	setupPic("leftwall", myData.leftwall[5], myData.leftwall[1], myData.leftwall[2], myData.leftwall[3], myData.leftwall[4])
	setupPic("rightwall", myData.rightwall[5], myData.rightwall[1], myData.rightwall[2], myData.rightwall[3], myData.rightwall[4])
	setupPic("topwall", myData.topwall[5], myData.topwall[1], myData.topwall[2], myData.topwall[3], myData.topwall[4])
	setupPic("bottomwall", myData.bottomwall[5], myData.bottomwall[1], myData.bottomwall[2], myData.bottomwall[3], myData.bottomwall[4])

	--loops
	setupPic("onel", myData.oneloop[5], myData.oneloop[1], myData.oneloop[2], myData.oneloop[3], myData.oneloop[4])
	setupPic("twol", myData.twoloop[5], myData.twoloop[1], myData.twoloop[2], myData.twoloop[3], myData.twoloop[4])
	setupPic("threel", myData.threeloop[5], myData.threeloop[1], myData.threeloop[2], myData.threeloop[3], myData.threeloop[4])

	--buttons
	setupPic("upa", myData.uparrow[5], myData.uparrow[1], myData.uparrow[2], myData.uparrow[3], myData.uparrow[4])
	setupPic("downa", myData.downarrow[5], myData.downarrow[1], myData.downarrow[2], myData.downarrow[3], myData.downarrow[4])
	setupPic("lefta", myData.leftarrow[5], myData.leftarrow[1], myData.leftarrow[2], myData.leftarrow[3], myData.leftarrow[4])
	setupPic("righta", myData.rightarrow[5], myData.rightarrow[1], myData.rightarrow[2], myData.rightarrow[3], myData.rightarrow[4])
	setupPic("oneb", myData.onebutton[5], myData.onebutton[1], myData.onebutton[2], myData.onebutton[3], myData.onebutton[4])
	setupPic("twob", myData.twobutton[5], myData.twobutton[1], myData.twobutton[2], myData.twobutton[3], myData.twobutton[4])
	setupPic("threeb", myData.threebutton[5], myData.threebutton[1], myData.threebutton[2], myData.threebutton[3], myData.threebutton[4])
	setupPic("start", myData.startbutton[5], myData.startbutton[1], myData.startbutton[2], myData.startbutton[3], myData.startbutton[4])
	setupPic("home", myData.homebutton[5], myData.homebutton[1], myData.homebutton[2], myData.homebutton[3], myData.homebutton[4])

	--robot
	robot = display.newImage("robot.png")
	robot.anchorX=0
	robot.anchorY=0
	robot.x=109
	robot.y=819
	robot.height=140
	robot.width=140
	robot.myName="robot"

	--scientist
	setscience(currResc)
	science = display.newImage("scientist.png")
	science.anchorX=0
	science.anchorY=0
	science.x=myData.science[1]
	science.y=myData.science[2]
	science.height=140
	science.width=140

	--walls
	i = 1
	while(myData.levelkey[currResc].walls[i] ~= nil) do
		currwall = "wall"..(myData.levelkey[currResc].walls[i])
		print(currwall)
		currdata = myData[currwall]
		print(currdata)
		setupPic(currwall, currdata[5], currdata[1], currdata[2], currdata[3], currdata[4])
		i = i + 1
	end
	i = 1

		

	--PHYSICS:
	--physics add bodies
	physics.start()
	physics.setGravity( 0, 0 )

	--walls physics
	physics.addBody( setupItems["leftwall"], "static",{bounce=0})
	physics.addBody( setupItems["rightwall"], "static",{bounce=0})
	physics.addBody( setupItems["topwall"], "static",{bounce=0})
	physics.addBody( setupItems["bottomwall"], "static",{bounce=0})
	while(myData.levelkey[currResc].walls[i] ~= nil) do
		currwall = "wall"..(myData.levelkey[currResc].walls[i])
		physics.addBody( setupItems[currwall], "static",{bounce=0})
		i = i + 1
	end
	i = 1
		
	--robot
	physics.addBody(robot,"dynamic",{bounce=0,friction=.8})
	robot.isFixedRotation = true
		
	--Misc
	local robotX, robotY = robot:localToContent( -70, -70 )
	myrectu = display.newRect( robotX, robotY-248, 1, 1)
	physics.addBody( myrectu, "static",{bounce=0})
	myrectd = display.newRect( robotX, robotY+248, 1, 1)
	physics.addBody( myrectd, "static",{bounce=0})
	myrectl = display.newRect( robotX-248, robotY, 1, 1)
	physics.addBody( myrectl, "static",{bounce=0})
	myrectr = display.newRect( robotX+248, robotY, 1, 1)
	physics.addBody( myrectr, "static",{bounce=0})
		
	--scientist
	physics.addBody(science, "static",{bounce=0})
end 



local function addPicTo(position, name, xVal, yVal)
	picTable[position] = display.newImage(name)
	picTable[position].anchorX = 0.5
	picTable[position].anchorY = 0.5
	picTable[position].x = xVal
	picTable[position].y = yVal
	picTable[position].height = 120
	picTable[position].width = 120
	picTable[position].id = name
end



local function addPic(xVal,yVal,name,spot)
	if((picTable[spot]== nil) and (picToAdd == ""))then
		emptyloop = emptyloop + 1
		local function onEmptyRescue( event )
        	if not event.error then
            	print( event.response.updatedAt )
        	end
    	end
    	local dataTable = {["Rescue"..currResc] = emptyloop }
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
    	local dataTable = {["Rescue"..currResc] = undoloop }
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
    	local dataTable = {["Rescue"..currResc] = undoloop }
    	parse:updateObject("UndoCount", myData.undoid, dataTable, onUndoSearch)
	end
	picToAdd = ""
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



local function moveu()
		robot:applyForce( 0, -200, robot.x+300, robot.y+70 )
end

local function moveup()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		
		local robotX, robotY = robot:localToContent( 0, -70 )
		transition.to( myrectu, { time=16, x=robotX, y=robotY-250} )
		timer.performWithDelay(20,moveu)
end


local function moveri()
		robot:applyForce( 200, 0, robot.x+70, robot.y+70 )	
end

local function mover()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		local robotX, robotY = robot:localToContent( 0, -70 )
		transition.to( myrectr, { time=16, x=robotX+320, y=robotY} )
		timer.performWithDelay(20,moveri)
end


local function movedo()
		robot:applyForce( 0, 200, robot.x+70, robot.y+70 )
end

local function moved()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		local robotX, robotY = robot:localToContent( 0, -70 )
		transition.to( myrectd, { time=16, x=robotX, y=robotY+390} )
		timer.performWithDelay(20,movedo)	
end


local function movele()
		robot:applyForce( -200, 0, robot.x+70, robot.y+70 )
end

local function movel()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, { loops=0 } )
		local robotX, robotY = robot:localToContent( 0, -70 )
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
	picToAdd = "one_button_white.png"
end

local function twotap()
	picToAdd = "two_button_white.png"
end

local function threetap()
	picToAdd = "three_button_white.png"
end



function scene:resetrobot()
		transition.moveTo( robot, { time=0, x=109, y=819} )
		timer.performWithDelay(20,restartr)	
end



local function restartr()
		local robotX, robotY = robot:localToContent( -70, -70 )
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
	
	if not (counter>max) then
		if (fintable[counter]=="up_arrow.png") then
			moveup()
		elseif (fintable[counter]=="down_arrow.png") then
			moved()
		elseif (fintable[counter]=="left_arrow.png") then
			movel()
		elseif (fintable[counter]=="right_arrow.png") then
			mover()
		else
			local options = {
			isModal = true
			}
			composer.showOverlay( "fail1", options )
		end
		counter=counter+1
	else
		local options = {
			isModal = true
			}
			composer.showOverlay( "fail", options )
	end	
end



local function onCollision( event )
	if ( event.phase == "began" ) then
		if (event.object2==myrectu or event.object2==myrectd or event.object2==myrectl or event.object2==myrectr) then
			if ( event.phase == "began" ) then
				moverobot()
			end
		elseif (event.object2==science) then
			print("Scientist")
			local options = {
				effect = "crossFade",
				time = 500
			}
			
			audio.stop(elevatorMusicplay)
			audio.pause(backgroundMusicplay)
			physics.stop()

			if(currResc ~= 3) then
				composer.gotoScene("Search",options)
				myData.rescueLvl = currResc + 1
			else
				composer.gotoScene("Credits",options)
			end

		elseif (event.object2==setupItems["bottomwall"] or event.object2==setupItems["topwall"] 
				or event.object2==setupItems["leftwall"] or event.object2==setupItems["rightwall"] ) then
			local options = {
			isModal = true,
			
			params = {
			sampleVar = "my sample variable"
				}
			}
			composer.showOverlay( "fail", options )
			print("why1")

		else
			while(myData.levelkey.walls[i] ~= nil) do
				currwall = "wall"..myData.levelkey.walls[i]
				if(event.object2==setupItems[currwall]) then
					local options = {
					isModal = true
					}
					composer.showOverlay( "fail", options )
					print("why1")
				end
				i = i + 1
			end
			i = 1
		end
	end 
end



local function merge(tablel)
	
	for i=1,5,1 do
		print(tablel[i])
		if (tablel[i]=="one_button_white.png") then
			merge(table1)
		elseif (tablel[i]=="two_button_white.png") then
			merge(table2)
		elseif (tablel[i]=="three_button_white.png") then
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
    local runsearchTable = {["Rescue"..currResc] = runrescue }
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
    local dataTable = {["Rescue"..currResc] = homerescue }
    parse:updateObject("HomeCount", myData.homeid, dataTable, onUpdateObject)

    local options = {
				effect = "crossFade",
				time = 500
			}
			audio.stop(elevatorMusicplay)
			audio.pause(backgroundMusicplay)
			composer.gotoScene("MainMenu",optionsh)
			myData.rescue = 1
			picTable = {}
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
	currResc = myData.rescueLvl
	myData.rescue = 1

	setscience(currResc)

    local sceneGroup = self.view
    elevatorMusic = audio.loadStream( "bensound-theelevatorbossanova.mp3")
	elevatorMusicplay = audio.play( elevatorMusic, {  fadein = 4000, loops=-1 } )
    
	picTable = {}
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
		
	--robot.collision = onLocalCollision
	--robot:addEventListener( "collision", robot )
	Runtime:addEventListener( "collision", onCollision )
	
	setupItems["upa"]:addEventListener( "tap", mutap )
	setupItems["downa"]:addEventListener( "tap", mdtap )
	setupItems["lefta"]:addEventListener( "tap", mltap )
	setupItems["righta"]:addEventListener( "tap", mrtap )
	setupItems["oneb"]:addEventListener("tap", onetap)
	setupItems["twob"]:addEventListener("tap", twotap)
	setupItems["threeb"]:addEventListener("tap", threetap)
	setupItems["start"]:addEventListener("tap", pass)
	setupItems["home"]:addEventListener("tap", gohome)
	
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
	sceneGroup:insert(setupItems["grida"])
	sceneGroup:insert(setupItems["onel"])
	sceneGroup:insert(setupItems["twol"])
	sceneGroup:insert(setupItems["threel"])
	sceneGroup:insert(setupItems["upa"])
	sceneGroup:insert(setupItems["downa"])
	sceneGroup:insert(setupItems["lefta"])
	sceneGroup:insert(setupItems["righta"])
	sceneGroup:insert(setupItems["oneb"])
	sceneGroup:insert(setupItems["twob"])
	sceneGroup:insert(setupItems["threeb"])
	sceneGroup:insert(setupItems["start"])
	sceneGroup:insert(setupItems["home"])
	
	--add character
	sceneGroup:insert(robot)
	sceneGroup:insert(science)
	
	--add walls
	sceneGroup:insert(setupItems["bottomwall"])
	sceneGroup:insert(setupItems["topwall"])
	sceneGroup:insert(setupItems["leftwall"])
	sceneGroup:insert(setupItems["rightwall"])
	while(myData.levelkey[currResc].walls[i] ~= nil) do
		currwall = "wall"..myData.levelkey[currResc].walls[i]
		sceneGroup:insert(setupItems[currwall])
		i = i + 1
	end
	i = 1
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
		picTable = {}
    	setObjects()
    	currResc = myData.rescueLvl
        myData.rescue = 1
        if(robot == nil) then
			elevatorMusic = audio.loadStream( "bensound-theelevatorbossanova.mp3")
			elevatorMusicplay = audio.play( elevatorMusic, {  fadein = 4000, loops=-1 } )

			--robot
			robot = display.newImage("robot.png")
			robot.anchorX=0
			robot.anchorY=0
			robot.x=109
			robot.y=819
			robot.height=140
			robot.width=140
			robot.myName="robot"

			--scientist
			setscience(currResc)
			science = display.newImage("scientist.png")
			science.anchorX=0
			science.anchorY=0
			science.x=myData.science[1]
			science.y=myData.science[2]
			science.height=140
			science.width=140

			setupPic("leftwall", myData.leftwall[5], myData.leftwall[1], myData.leftwall[2], myData.leftwall[3], myData.leftwall[4])
			setupPic("rightwall", myData.rightwall[5], myData.rightwall[1], myData.rightwall[2], myData.rightwall[3], myData.rightwall[4])
			setupPic("topwall", myData.topwall[5], myData.topwall[1], myData.topwall[2], myData.topwall[3], myData.topwall[4])
			setupPic("bottomwall", myData.bottomwall[5], myData.bottomwall[1], myData.bottomwall[2], myData.bottomwall[3], myData.bottomwall[4])
			while(myData.levelkey[currResc].walls[i] ~= nil) do
				currwall = "wall"..myData.levelkey[currResc].walls[i]
				print(currwall)
				currdata = myData[currwall]
				print(currdata)
				setupPic(currwall, currdata[5], currdata[1], currdata[2], currdata[3], currdata[4])
				i = i + 1
			end
			i = 1

			physics.start()
			physics.setGravity( 0, 0 )

			--walls physics
			physics.addBody( setupItems["leftwall"], "static",{bounce=0})
			physics.addBody( setupItems["rightwall"], "static",{bounce=0})
			physics.addBody( setupItems["topwall"], "static",{bounce=0})
			physics.addBody( setupItems["bottomwall"], "static",{bounce=0})
			while(myData.levelkey[currResc].walls[i] ~= nil) do
				currwall = "wall"..myData.levelkey[currResc].walls[i]
				physics.addBody( setupItems[currwall], "static",{bounce=0})
				i = i + 1
			end
			i = 1
		
			--robot
			physics.addBody(robot,"dynamic",{bounce=0,friction=.8})
			robot.isFixedRotation = true
		
			--Misc
			local robotX, robotY = robot:localToContent( -70, -70 )
			myrectu = display.newRect( robotX, robotY-248, 1, 1)
			physics.addBody( myrectu, "static",{bounce=0})
			myrectd = display.newRect( robotX, robotY+248, 1, 1)
			physics.addBody( myrectd, "static",{bounce=0})
			myrectl = display.newRect( robotX-248, robotY, 1, 1)
			physics.addBody( myrectl, "static",{bounce=0})
			myrectr = display.newRect( robotX+248, robotY, 1, 1)
			physics.addBody( myrectr, "static",{bounce=0})
		
			--scientist
			physics.addBody(science, "static",{bounce=0})
		end	
		
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
        for h = 15, 1, -1 do
			if(picTable[h] ~= nil) then
				picTable[h]:removeSelf()
			end
		end
		display.remove( robot)
		robot=nil
		display.remove( myrectu)
		myrectu=nil
		display.remove( myrectd)
		myrectd=nil
		display.remove( myrectl)
		myrectl=nil
		display.remove( myrectr)
		myrectr=nil
		display.remove( science)
		science=nil
		display.remove( setupItems["leftwall"])
		display.remove( setupItems["rightwall"])
		display.remove( setupItems["topwall"])
		display.remove( setupItems["bottomwall"])
		while(myData.levelkey[currResc].walls[i] ~= nil) do
			currwall = "wall"..myData.levelkey[currResc].walls[i]
			display.remove( setupItems[currwall])
			setupItems[currwall]=nil
			i = i + 1
			end
		i = 1
		physics.stop()
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