local parse = require( "mod_parse" )
local myData = require( "mydata" )
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

local picToAdd= ""
local testpic = ""
local buttonTable = {}
local picTableBonus = {}
local table1 = {}
local table2 = {}
local table3 = {}
local fintable = {}
local counter = 1;
local bonuskey ={} 
local popupPic
local one = {}
local two = {}
local three = {}

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function setupmap()
		
		
		
        --red_block
        blockred = display.newImage("Images/red_block.png")
        blockred.anchorX=0
        blockred.anchorY=0
        blockred.x=1289
        blockred.y=729
        blockred.height=120
        blockred.width=120

        --green_block
        blockgreen = display.newImage("Images/green_block.png")
        blockgreen.anchorX=0
        blockgreen.anchorY=0
        blockgreen.x=1426
        blockgreen.y=729
        blockgreen.height=120
        blockgreen.width=120

        --blue_block
        blockblue = display.newImage("Images/blue_block.png")
        blockblue.anchorX=0
        blockblue.anchorY=0
        blockblue.x=1564
        blockblue.y=729
        blockblue.height=120
        blockblue.width=120
        
        --yellow_block
        blockyellow = display.newImage("Images/yellow_block.png")
        blockyellow.anchorX=0
        blockyellow.anchorY=0
        blockyellow.x=1700
        blockyellow.y=729
        blockyellow.height=120
        blockyellow.width=120
        
        --home_button
        homebutton = display.newImage("Images/home.png")
        homebutton.anchorX=0
        homebutton.anchorY=0
        homebutton.x=1766
        homebutton.y=28
        homebutton.height=120
        homebutton.width=120
		
		--one_ button
		onebutton = display.newImage("Images/1_block.png")
		onebutton.anchorX=0
        onebutton.anchorY=0
        onebutton.x=1426
        onebutton.y=865
        onebutton.height=120
        onebutton.width=120

		--two_ button
		twobutton = display.newImage("Images/2_block.png")
		twobutton.anchorX=0
        twobutton.anchorY=0
        twobutton.x=1564
        twobutton.y=865
        twobutton.height=120
        twobutton.width=120
		
		 --run_button
        runbutton = display.newImage("Images/test_button.png")
        runbutton.anchorY=0
        runbutton.x=display.contentCenterX
        runbutton.y=50
        runbutton.height=120
        runbutton.width=360

        
end 

local function addPicTo(position, name, xVal, yVal)
	picTableBonus[position] = display.newImage(name)
	picTableBonus[position].anchorX = 0.5
	picTableBonus[position].anchorY = 0.5
	picTableBonus[position].x = xVal
	picTableBonus[position].y = yVal
	picTableBonus[position].height = 120
	picTableBonus[position].width = 120
	picTableBonus[position].id = name
end

local function	popup(x,y,height,width)
	
	if(popupPic == nil) then
		popupPic = display.newRect(x,y,height,width)
		popupPic.anchorX = 0
		popupPic.anchorY = 0	
		popupPic:setFillColor(grey, 0.2)
	elseif(x ~= popupPic.x)then
		popupPic:removeSelf()
		popupPic = display.newRect(x,y,height,width)
		popupPic.anchorX = 0
		popupPic.anchorY = 0	
		popupPic:setFillColor(grey, 0.2)
	end
end

local function addPic(xVal,yVal,name,spot)
	if((picTableBonus[spot]== nil) and (picToAdd == ""))then
		
	elseif(picTableBonus[spot] == nil) then
		addPicTo(spot, name, xVal, yVal)

	elseif (picToAdd == "") then
		picTableBonus[spot]:removeSelf()
		picTableBonus[spot] = nil

	else
		print("in")
		print(picTableBonus[spot])
		picTableBonus[spot]:removeSelf()
		addPicTo(spot, name, xVal, yVal)
			
	end
	picToAdd = ""
	testpic = ""
	if(popupPic~=nil)then
		popupPic:removeSelf()
		popupPic = nil
	end
end

local function handleButtonEvent(event)
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        if(event.target.id == "oneloopBtn1") then
			table1[1] = picToAdd
			one[1] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 1)
		end
		if(event.target.id == "oneloopBtn2") then
			table1[2] = picToAdd
			one[2] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 2)
		end
		if(event.target.id == "oneloopBtn3") then
			table1[3] = picToAdd
			one[3] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 3)
		end
		if(event.target.id == "oneloopBtn4") then
			table1[4] = picToAdd
			one[4] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 4)
		end
		if(event.target.id == "oneloopBtn5") then
			table1[5] = picToAdd
			one[5] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 5)
		end
		if(event.target.id == "twoloopBtn1") then
			table2[1] = picToAdd
			two[1] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 6)
		end
		if(event.target.id == "twoloopBtn2") then
			table2[2] = picToAdd
			two[2] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 7)
		end
		if(event.target.id == "twoloopBtn3") then
			table2[3] = picToAdd
			two[3] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 8)
		end
		if(event.target.id == "twoloopBtn4") then
			table2[4] = picToAdd
			two[4] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 9)
		end
		if(event.target.id == "twoloopBtn5") then
			table2[5] = picToAdd
			two[5] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 10)
		end
		if(event.target.id == "threeloopBtn1") then
			table3[1] = picToAdd
			three[1] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 11)
		end
		if(event.target.id == "threeloopBtn2") then
			table3[2] = picToAdd
			three[2] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 12)
		end
		if(event.target.id == "threeloopBtn3") then
			table3[3] = picToAdd
			three[3] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 13)
		end
		if(event.target.id == "threeloopBtn4") then
			table3[4] = picToAdd
			three[4] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 14)
		end
		if(event.target.id == "threeloopBtn5") then
			table3[5] = picToAdd
			three[5] = testpic
			addPic(event.target.x, event.target.y,picToAdd, 15)
		end
    end
end



local function gohome( event )
    homesearch = homesearch + 1
	print("in")
    local function onUpdateObject( event )
        if not event.error then
            print( event.response.updatedAt )
        end
    end
    --local dataTable = {["Search"..currLvl] = homesearch }

    local options = {
    	isModal = true,
        effect = "crossFade",
        time = 500
    }
    
    composer.gotoScene("MainMenu",options)
end

local function tryagain()
    countmax=answer
    spotx = 631 + answer*130
    for i=8,answer,-1 
    do 
        display.remove(newblock[i]) 
    end
end

local function addred()
	picToAdd = "Images/red_block.png"
	testpic = "red"
	popup(1289,729,120,120)
end

local function addgreen()
	picToAdd = "Images/green_block.png"
	testpic = "green"
	popup(1426,729,120,120)
end

local function addblue()
	picToAdd = "Images/blue_block.png"
	testpic = "blue"
	popup(1564,729,120,120)
end

local function addyellow()
	picToAdd = "Images/yellow_block.png"
	testpic = "yellow"
	popup(1700,729,120,120)
end

local function addtwo()
	picToAdd = "Images/1_block.png"
	testpic = 1
	popup(1426,865,120,120)
end

local function addthree()
	picToAdd = "Images/2_block.png"
	testpic = 2
	popup(1564,865,120,120)
end

local function merge(tablel)
	
	for i=1,5,1 do
		if (tablel[i]=="Images/1_block.png") then
			merge(table2)
		elseif (tablel[i]=="Images/2_block.png") then
			merge(table3)
		elseif ( tablel[i]=="Images/red_block.png") then
			table.insert(fintable,tablel[i])
			table.insert(bonuskey,"red")
			print(fintable[i])
		elseif (tablel[i]=="Images/green_block.png") then
			table.insert(fintable,tablel[i])
			table.insert(bonuskey,"green")
			print(fintable[i])
		elseif (tablel[i]=="Images/blue_block.png") then
			table.insert(fintable,tablel[i])
			table.insert(bonuskey,"blue")
			print(fintable[i])
		elseif (tablel[i]=="Images/yellow_block.png") then
			table.insert(fintable,tablel[i])
			table.insert(bonuskey,"yellow")
			print(fintable[i])
		else
		end
	end
end

local function test()
	
	merge(table1)
	for h = 15, 1, -1 do
		if(picTableBonus[h] ~= nil) then
			picTableBonus[h]:removeSelf()
		end
	end
	picTableBonus = {}
	table1 = {}
	table2 = {}
	table3 = {}
	fintable = {}
	buttonTable = {}
	
	local show = {
		one = {},
		two = {}, 
		three = {}
		}
		
	show.one = one
	i = 1
	for i=1, 5, 1 do
		if(show.one[i] == nil) then
			show.one[i] = 0
		end
	end

	show.two = two
	i = 1
	for i=1, 5, 1 do
		if(show.two[i] == nil) then
			show.two[i] = 0
		end
	end

	show.three = three
	i = 1
	for i=1, 5, 1 do
		if(show.three[i] == nil) then
			show.three[i] = 0
		end
	end
	
	myData.bonusShow = show
	
	one = {}
	two = {}
	three = {}
	show = {}
	
	myData.bonusKeyBuilt = bonuskey
	bonuskey = {}
	
	local options = {
		isModal = true,
		effect = "crossFade",
		time = 500
	}
	local popupPic = nil
	composer.showOverlay("Test_Build_Search",options)
end

local function addButton(position, xPos, yPos,idName)
	buttonTable[position] = widget.newButton
	{
		width = 160,
	    height = 160,
		x = xPos ,
		y = yPos ,
		id = idName,
		onEvent = handleButtonEvent
	}
end



-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

    local background = display.newImage("Images/theme_"..myData.theme.."/search_background.png")
        background.anchorX=0.5
        background.anchorY=0.5
        background.height=1080
        background.width=1920
        background.x= display.contentCenterX
        background.y=display.contentCenterY
        sceneGroup:insert(background)
        
        setupmap()
        newblock = {}
        spacecolor = {}
        answer = 0
        undosearch = 0
        homesearch = 0
        runsearch = 0
		--buttons
		addButton(11,410,653,"oneloopBtn1")
		addButton(12,555,653,"oneloopBtn2")
		addButton(13,695,653,"oneloopBtn3")
		addButton(14,835,653,"oneloopBtn4")
		addButton(15,980,653,"oneloopBtn5")
		
		addButton(21,410,810,"twoloopBtn1")
		addButton(22,555,810,"twoloopBtn2")
		addButton(23,695,810,"twoloopBtn3")
		addButton(24,835,810,"twoloopBtn4")
		addButton(25,980,810,"twoloopBtn5")
		
		addButton(31,410,960,"threeloopBtn1")
		addButton(32,555,960,"threeloopBtn2")
		addButton(33,695,960,"threeloopBtn3")
		addButton(34,835,960,"threeloopBtn4")
		addButton(35,980,960,"threeloopBtn5")
		
		

        sceneGroup:insert(blockred)
        sceneGroup:insert(blockgreen)
        sceneGroup:insert(blockblue)
        sceneGroup:insert(blockyellow)
        sceneGroup:insert(homebutton)
		sceneGroup:insert(onebutton)
		sceneGroup:insert(twobutton)
		sceneGroup:insert(runbutton)
		
		
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
		


        blockred:addEventListener( "tap", addred )
        blockgreen:addEventListener( "tap", addgreen )
        blockblue:addEventListener( "tap", addblue )
        blockyellow:addEventListener( "tap", addyellow )
		onebutton:addEventListener("tap", addtwo)
		twobutton:addEventListener("tap", addthree)
        homebutton:addEventListener("tap",gohome)
		runbutton:addEventListener("tap",test)
  
end


-- "scene:show()"
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        
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