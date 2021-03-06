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
local popupPic 
local setupItems = {}
local myrectd
local myrectu
local myrectl
local myrectr
local currResc
local currwall

local i = 1

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function setupPic(name, pic, xVal, yVal, hVal,wVal,alpha,xpos,ypos)

    setupItems[name] = display.newImage(pic)
    if(xpos==nil) then
        setupItems[name].anchorX = 0
    else
        setupItems[name].anchorX = xpos
    end
    if(ypos==nil) then
        setupItems[name].anchorY = 0
    else
        setupItems[name].anchorY = ypos
    end
    setupItems[name].x = xVal
    setupItems[name].y = yVal
    setupItems[name].alpha=alpha
    if(hVal~=nil) then
        setupItems[name].height = hVal
    end
    if(wVal~=nil) then
        setupItems[name].width= wVal
    end
    if(alpha==nil) then
        setupItems[name].alpha=1
    else
        setupItems[name].alpha=alpha
    end
end

local function setupmap()

	--grid & outer walls
	setupPic("grida", myData.grida[5], myData.grida[1], myData.grida[2], myData.grida[3], myData.grida[4])
	setupPic("leftwall", myData.leftwall[5], myData.leftwall[1], myData.leftwall[2], myData.leftwall[3], myData.leftwall[4])
	setupPic("rightwall", myData.rightwall[5], myData.rightwall[1], myData.rightwall[2], myData.rightwall[3], myData.rightwall[4])
	setupPic("topwall", myData.topwall[5], myData.topwall[1], myData.topwall[2], myData.topwall[3], myData.topwall[4])
	setupPic("bottomwall", myData.bottomwall[5], myData.bottomwall[1], myData.bottomwall[2], myData.bottomwall[3], myData.bottomwall[4])

	--loops
	setupPic("mainl", myData.mainloop[5], myData.mainloop[1], myData.mainloop[2], myData.mainloop[3], myData.mainloop[4])
	setupPic("onel", myData.oneloop[5], myData.oneloop[1], myData.oneloop[2], myData.oneloop[3], myData.oneloop[4])
	setupPic("twol", myData.twoloop[5], myData.twoloop[1], myData.twoloop[2], myData.twoloop[3], myData.twoloop[4])

	--buttons
	setupPic("upa", myData.uparrow[5], myData.uparrow[1], myData.uparrow[2], myData.uparrow[3], myData.uparrow[4])
	setupPic("downa", myData.downarrow[5], myData.downarrow[1], myData.downarrow[2], myData.downarrow[3], myData.downarrow[4])
	setupPic("lefta", myData.leftarrow[5], myData.leftarrow[1], myData.leftarrow[2], myData.leftarrow[3], myData.leftarrow[4])
	setupPic("righta", myData.rightarrow[5], myData.rightarrow[1], myData.rightarrow[2], myData.rightarrow[3], myData.rightarrow[4])
	setupPic("oneb", myData.onebutton[5], myData.onebutton[1], myData.onebutton[2], myData.onebutton[3], myData.onebutton[4])
	setupPic("twob", myData.twobutton[5], myData.twobutton[1], myData.twobutton[2], myData.twobutton[3], myData.twobutton[4])
	setupPic("start", myData.startbutton[5], myData.startbutton[1], myData.startbutton[2], myData.startbutton[3], myData.startbutton[4])
	setupPic("home", myData.homebutton[5], myData.homebutton[1], myData.homebutton[2], myData.homebutton[3], myData.homebutton[4])

	--robot
	robot = display.newImage("Images/robot_santa.png")
	robot.anchorX=0
	robot.anchorY=0
	robot.x=109
	robot.y=819
	robot.height=140
	robot.width=140
	robot.myName="robot"

	--scientist
	setscience(1)
	science = display.newImage("Images/scientist_present.png")
	science.anchorX=0
	science.anchorY=0
	science.x=myData.science[1]
	science.y=myData.science[2]
	science.height=140
	science.width=140



	--walls
	i = 1
	while(myData.levelkey[1].walls[i] ~= nil) do
		currwall = "wall"..(myData.levelkey[1].walls[i])
		currdata = myData[currwall]
		setupPic(currwall, currdata[5], currdata[1], currdata[2], currdata[3], currdata[4])
		i = i + 1
	end
	i = 1

		

	--PHYSICS:
	--physics add bodies
	physics.start()
	physics.setGravity( 0, 0 )
		
	--robot
	physics.addBody(robot,"dynamic",{bounce=0,friction=.8})
	robot.isFixedRotation = true
		
	--Misc
	local robotX, robotY = robot:localToContent( -70, -70 )
	myrectu = display.newRect( robotX, robotY-248, 1, 1)
	myrectu:setFillColor( 0.5 , 0.1 )
	physics.addBody( myrectu, "static",{bounce=0})
	myrectd = display.newRect( robotX, robotY+248, 1, 1)
	myrectd:setFillColor( 0.5 , 0.1 )
	physics.addBody( myrectd, "static",{bounce=0})
	myrectl = display.newRect( robotX-248, robotY, 1, 1)
	myrectl:setFillColor( 0.5 , 0.1 )
	physics.addBody( myrectl, "static",{bounce=0})
	myrectr = display.newRect( robotX+248, robotY, 1, 1)
	myrectr:setFillColor( 0.5 , 0.1 )
	physics.addBody( myrectr, "static",{bounce=0})
	--walls physics
	physics.addBody( setupItems["leftwall"], "static",{bounce=0})
	physics.addBody( setupItems["rightwall"], "static",{bounce=0})
	physics.addBody( setupItems["topwall"], "static",{bounce=0})
	physics.addBody( setupItems["bottomwall"], "static",{bounce=0})
	while(myData.levelkey[1].walls[i] ~= nil) do
		currwall = "wall"..(myData.levelkey[1].walls[i])
		physics.addBody( setupItems[currwall], "static",{bounce=0})
		i = i + 1
	end
	i = 1

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

local function	popup(x,y,height,width)
	
	if(popupPic == nil) then
		popupPic = display.newRect(x,y,height,width)
		popupPic.anchorX = 0
		popupPic.anchorY = 0	
		popupPic:setFillColor(grey, 0.2)
	elseif(x ~= popupPic.x)then
		display.remove(popupPic)
		popupPic = display.newRect(x,y,height,width)
		popupPic.anchorX = 0
		popupPic.anchorY = 0	
		popupPic:setFillColor(grey, 0.2)
	end
end



local function addPic(xVal,yVal,name,spot)
	if((picTable[spot]== nil) and (picToAdd == ""))then
		emptyloop = emptyloop + 1

	elseif(picTable[spot] == nil) then
		addPicTo(spot, name, xVal, yVal)

	elseif (picToAdd == "") then
		picTable[spot]:removeSelf()
		picTable[spot] = nil

		undoloop = undoloop + 1
		
	else
		picTable[spot]:removeSelf()
		addPicTo(spot, name, xVal, yVal)
			
		undoloop = undoloop + 1
	end
	picToAdd = ""
	if(popupPic~=nil)then
		popupPic:removeSelf()
		popupPic = nil
	end
end



local function handleButtonEvent( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        if(event.target.id == "mainloopBtn1") then
			table1[1] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 1)
		end
		if(event.target.id == "mainloopBtn2") then
			table1[2] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 2)
		end
		if(event.target.id == "mainloopBtn3") then
			table1[3] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 3)
		end
		if(event.target.id == "mainloopBtn4") then
			table1[4] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 4)
		end
		if(event.target.id == "mainloopBtn5") then
			table1[5] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 5)
		end
		if(event.target.id == "oneloopBtn1") then
			table2[1] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 6)
		end
		if(event.target.id == "oneloopBtn2") then
			table2[2] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 7)
		end
		if(event.target.id == "oneloopBtn3") then
			table2[3] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 8)
		end
		if(event.target.id == "oneloopBtn4") then
			table2[4] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 9)
		end
		if(event.target.id == "oneloopBtn5") then
			table2[5] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 10)
		end
		if(event.target.id == "twoloopBtn1") then
			table3[1] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 11)
		end
		if(event.target.id == "twoloopBtn2") then
			table3[2] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 12)
		end
		if(event.target.id == "twoloopBtn3") then
			table3[3] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 13)
		end
		if(event.target.id == "twoloopBtn4") then
			table3[4] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 14)
		end
		if(event.target.id == "twoloopBtn5") then
			table3[5] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 15)
		end
    end
end



local function moveu()
		robot:applyForce( 0, -200, robot.x+300, robot.y+70 )
end

local function moveup()
		local robotMusic = audio.loadStream( "Music/Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		
		local robotX, robotY = robot:localToContent( 0, -70 )
		transition.to( myrectu, { time=16, x=robotX, y=robotY-250} )
		timer.performWithDelay(20,moveu)
end


local function moveri()
		robot:applyForce( 200, 0, robot.x+70, robot.y+70 )	
end

local function mover()
		local robotMusic = audio.loadStream( "Music/Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		local robotX, robotY = robot:localToContent( 0, -70 )
		transition.to( myrectr, { time=16, x=robotX+320, y=robotY} )
		timer.performWithDelay(20,moveri)
end


local function movedo()
		robot:applyForce( 0, 200, robot.x+70, robot.y+70 )
end

local function moved()
		local robotMusic = audio.loadStream( "Music/Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		local robotX, robotY = robot:localToContent( 0, -70 )
		transition.to( myrectd, { time=16, x=robotX, y=robotY+390} )
		timer.performWithDelay(20,movedo)	
end


local function movele()
		robot:applyForce( -200, 0, robot.x+70, robot.y+70 )
end

local function movel()
		local robotMusic = audio.loadStream( "Music/Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, { loops=0 } )
		local robotX, robotY = robot:localToContent( 0, -70 )
		transition.to( myrectl, { time=16, x=robotX-320, y=robotY} )
		timer.performWithDelay(20,movele)	
end



local function mdtap()
	picToAdd = "Images/down_arrow.png"
	popup(myData.downarrow[1], myData.downarrow[2], myData.downarrow[3], myData.downarrow[4])
	
end

local function mutap()
	picToAdd = "Images/up_arrow.png"
	popup(myData.uparrow[1], myData.uparrow[2], myData.uparrow[3], myData.uparrow[4])
end

local function mrtap()
	picToAdd = "Images/right_arrow.png"
	popup(myData.rightarrow[1], myData.rightarrow[2], myData.rightarrow[3], myData.rightarrow[4])
end

local function mltap()
	picToAdd = "Images/left_arrow.png"
	popup(myData.leftarrow[1], myData.leftarrow[2], myData.leftarrow[3], myData.leftarrow[4])
end



local function onetap()
	picToAdd = "Images/1_block.png"
	popup(myData.onebutton[1], myData.onebutton[2], myData.onebutton[3], myData.onebutton[4])
end

local function twotap()
	picToAdd = "Images/2_block.png"
	popup(myData.twobutton[1], myData.twobutton[2], myData.twobutton[3], myData.twobutton[4])
end



function scene:resetrobot()
		transition.moveTo( robot, { time=0, x=109, y=819} )
		fintable=nil
		fintable={}
		counter=1
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




local function moverobot()
	local max = table.maxn(fintable)
	
	if not (counter>max) then
		if (fintable[counter]=="Images/up_arrow.png") then
			moveup()
		elseif (fintable[counter]=="Images/down_arrow.png") then
			moved()
		elseif (fintable[counter]=="Images/left_arrow.png") then
			movel()
		elseif (fintable[counter]=="Images/right_arrow.png") then
			mover()
		else
			local options = {
			isModal = true
			}
			composer.showOverlay( "fail_rescue_scientist", options )
		end
		counter=counter+1
	else
		local options = {
			isModal = true
			}
			composer.showOverlay( "fail_rescue_path", options )
	end	
end

function scene:resumeGame()
end
local function onCollision( event )
	if ( event.phase == "began" ) then
		if (event.object2==myrectu or event.object2==myrectd or event.object2==myrectl or event.object2==myrectr) then
			if ( event.phase == "began" ) then
				moverobot()
			end

		elseif (event.object2==science) then
				local options = {
					isModal = true,
					effect = "crossFade",
					time = 500
				}
				audio.stop(elevatorMusicplay)
				audio.pause(backgroundMusicplay)
					for h = 15, 1, -1 do
						if(picTable[h] ~= nil) then
							picTable[h]:removeSelf()
						end
					end
					composer.showOverlay("pass_tutorial",options)
					
		elseif (event.object2==setupItems["bottomwall"] or event.object2==setupItems["topwall"] 
				or event.object2==setupItems["leftwall"] or event.object2==setupItems["rightwall"] ) then
			local options = {
			isModal = true,
			
			}
			composer.showOverlay( "fail", options )

		else
			while(myData.levelkey[1].walls[i] ~= nil) do
				currwall = "wall"..myData.levelkey[1].walls[i]
				if(event.object2==setupItems[currwall]) then
					
						local options = {
						isModal = true
						}
						composer.showOverlay( "fail", options )
					
				end
				i = i + 1
			end
			i = 1
		end
	end 
end

local function merge(tablel)
	
	for i=1,5,1 do
		if (tablel[i]=="Images/main_block.png") then
			merge(table1)
		elseif (tablel[i]=="Images/1_block.png") then
			merge(table2)
		elseif (tablel[i]=="Images/2_block.png") then
			merge(table3)
		elseif ( tablel[i]=="Images/up_arrow.png" or tablel[i]=="Images/down_arrow.png" 
				or tablel[i]=="Images/left_arrow.png" or tablel[i]=="Images/right_arrow.png") then
			table.insert(fintable,tablel[i])
		else
		end
	end
end



local function pass()
	runrescue = runrescue + 1

    counter=1
	merge(table1)
	moverobot()
	
end



local function gohome()
	homerescue = homerescue + 1
	display.remove(popupPic)
    local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
	audio.stop(elevatorMusicplay)
	audio.pause(backgroundMusicplay)
	composer.gotoScene("MainMenu",optionsh)
	picTable = {}
	physics.stop()
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

local function ShowSpeech( CurrSpeech )

    local function nextSpeech( event )
        myData.SpeechR=myData.SpeechR + 1
        if(myData.SpeechR==15) then

            setupItems["start"]:addEventListener("tap", pass)
            
        end
        ShowSpeech(myData.SpeechR)
    end
    i=1
    while setupItems["speech"..i]~=nil do
        display.remove( setupItems["speech"..i] )
        i=i+1
    end
    j=1
    if (myData.SRImages[CurrSpeech]~=nil) then
        im=myData.SRImages[CurrSpeech].images
        while im[j]~=nil do
            setupPic("speech"..j, im[j][1], im[j][2], im[j][3], im[j][4], im[j][5], im[j][6] , im[j][7] , im[j][8] )
            j=j+1
        end
        setupItems["speech"..1]:toFront()
        setupItems["speech"..1]:addEventListener( "tap", nextSpeech )
    end

end


-- "scene:create()"
function scene:create( event )
	currResc = 1
	
	setscience(1)

    local sceneGroup = self.view
    ShowSpeech(myData.SpeechR)
    elevatorMusic = audio.loadStream( "Music/bensound-theelevatorbossanova.mp3")
	elevatorMusicplay = audio.play( elevatorMusic, {  fadein = 4000, loops=-1 } )
    
	picTable = {}
	homerescue = 0
	runrescue = 0
	undoloop = 0
	emptyloop = 0
	keyscount = 0

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
	local background = display.newImage("Images/theme_default/rescue_background.png",system.ResourceDirectory)
	background.anchorX=0.5
	background.anchorY=0.5
	background.height=1080
	background.width=1920
	background.x= display.contentCenterX
	background.y=display.contentCenterY
	sceneGroup:insert(background)
	
	--buttons
	
	--one loop button
	addButton(11, 1270.21, 690.86, "mainloopBtn1")
	addButton(12, 1402.21, 690.86, "mainloopBtn2")
	addButton(13, 1530.21, 690.86, "mainloopBtn3")
	addButton(14, 1660.21, 690.86, "mainloopBtn4")
	addButton(15, 1790.21, 690.86, "mainloopBtn5")
	
	--two loop buttons
	addButton(21, 1270.21, 835.86, "oneloopBtn1")
	addButton(22, 1402.21, 835.86, "oneloopBtn2")
	addButton(23, 1530.21, 835.86, "oneloopBtn3")
	addButton(24, 1660.21, 835.86, "oneloopBtn4")
	addButton(25, 1790.21, 835.86, "oneloopBtn5")
	
	--three loop buttons
	addButton(31, 1270.21, 980.86, "twoloopBtn1")
	addButton(32, 1402.21, 980.86, "twoloopBtn2")
	addButton(33, 1530.21, 980.86, "twoloopBtn3")
	addButton(34, 1660.21, 980.86, "twoloopBtn4")
	addButton(35, 1790.21, 980.86, "twoloopBtn5")
	
	setupmap()
		
	--robot.collision = onLocalCollision
	--robot:addEventListener( "collision", robot )
	
	
	setupItems["upa"]:addEventListener( "tap", mutap )
	setupItems["downa"]:addEventListener( "tap", mdtap )
	setupItems["lefta"]:addEventListener( "tap", mltap )
	setupItems["righta"]:addEventListener( "tap", mrtap )
	setupItems["oneb"]:addEventListener("tap", onetap)
	setupItems["twob"]:addEventListener("tap", twotap)
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
	sceneGroup:insert(setupItems["mainl"])
	sceneGroup:insert(setupItems["onel"])
	sceneGroup:insert(setupItems["twol"])
	sceneGroup:insert(setupItems["upa"])
	sceneGroup:insert(setupItems["downa"])
	sceneGroup:insert(setupItems["lefta"])
	sceneGroup:insert(setupItems["righta"])
	sceneGroup:insert(setupItems["oneb"])
	sceneGroup:insert(setupItems["start"])
	sceneGroup:insert(setupItems["twob"])
	sceneGroup:insert(setupItems["home"])
	
	--add character
	sceneGroup:insert(robot)
	sceneGroup:insert(science)
	
	--add walls
	sceneGroup:insert(setupItems["bottomwall"])
	sceneGroup:insert(setupItems["topwall"])
	sceneGroup:insert(setupItems["leftwall"])
	sceneGroup:insert(setupItems["rightwall"])
	while(myData.levelkey[1].walls[i] ~= nil) do
		currwall = "wall"..myData.levelkey[1].walls[i]
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
    	currResc = 1
        if(robot == nil) then

    		ShowSpeech(myData.SpeechR)
			elevatorMusic = audio.loadStream( "Music/bensound-theelevatorbossanova.mp3")
			elevatorMusicplay = audio.play( elevatorMusic, {  fadein = 4000, loops=-1 } )

			--robot
			robot = display.newImage("Images/robot_santa.png")
			robot.anchorX=0
			robot.anchorY=0
			robot.x=109
			robot.y=819
			robot.height=140
			robot.width=140
			robot.myName="robot"

			--scientist
			setscience(1)
			science = display.newImage("Images/scientist_present.png")
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
			i=1
			while(myData.levelkey[1].walls[i] ~= nil) do
				currwall = "wall"..myData.levelkey[1].walls[i]
				currdata = myData[currwall]
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
			while(myData.levelkey[1].walls[i] ~= nil) do
				currwall = "wall"..myData.levelkey[1].walls[i]
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
			myrectu:setFillColor( 0.5 , 0.1 )
			physics.addBody( myrectu, "static",{bounce=0})
			myrectd = display.newRect( robotX, robotY+248, 1, 1)
			myrectd:setFillColor( 0.5 , 0.1 )
			physics.addBody( myrectd, "static",{bounce=0})
			myrectl = display.newRect( robotX-248, robotY, 1, 1)
			myrectl:setFillColor( 0.5 , 0.1 )
			physics.addBody( myrectl, "static",{bounce=0})
			myrectr = display.newRect( robotX+248, robotY, 1, 1)
			myrectr:setFillColor( 0.5 , 0.1 )
			physics.addBody( myrectr, "static",{bounce=0})
		
			--scientist
			physics.addBody(science, "static",{bounce=0})


			--sceneGroup:insert(setupItems["grida"])
			--sceneGroup:insert(setupItems["mainl"])
			--sceneGroup:insert(setupItems["onel"])
			--sceneGroup:insert(setupItems["twol"])
			--sceneGroup:insert(setupItems["upa"])
			--sceneGroup:insert(setupItems["downa"])
			--sceneGroup:insert(setupItems["lefta"])
			--sceneGroup:insert(setupItems["righta"])
			--sceneGroup:insert(setupItems[""])
			--sceneGroup:insert(setupItems["oneb"])
			--sceneGroup:insert(setupItems["twob"])
			--sceneGroup:insert(setupItems["start"])
			--sceneGroup:insert(setupItems["home"])
			sceneGroup:insert(robot)
			sceneGroup:insert(science)
			sceneGroup:insert(setupItems["bottomwall"])
			sceneGroup:insert(setupItems["topwall"])
			sceneGroup:insert(setupItems["leftwall"])
			sceneGroup:insert(setupItems["rightwall"])
			while(myData.levelkey[1].walls[i] ~= nil) do
				currwall = "wall"..myData.levelkey[1].walls[i]
				sceneGroup:insert(setupItems[currwall])
				i = i + 1
			end
			i = 1
		end	
		Runtime:addEventListener( "collision", onCollision )
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
        --restartr()
        fintable = nil
        fintable = {}
        table1=nil
        table2=nil
        table3=nil
        table1={}
        table2={}
        table3={}
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
		while(myData.levelkey[1].walls[i] ~= nil) do
			currwall = "wall"..myData.levelkey[1].walls[i]
			display.remove( setupItems[currwall])
			setupItems[currwall]=nil
			i = i + 1
		end
		i = 1
		physics.stop()
		currResc = nil
		i = 1
		for h = 15, 1, -1 do
			if(picTable[h] ~= nil) then
				display.remove(picTable[h])
			end
		end
		while setupItems["speech"..i]~=nil do
    		display.remove( setupItems["speech"..i] )
    		i=i+1
		end
		--setupItems={}
		myData.SpeechR=1
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
		
        Runtime:removeEventListener( "collision", onCollision )
		
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