local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local widget = require("widget")

local picToAdd
local pic11 
local pic12
local pic13
local pic14
local pic15

local pic21
local pic22
local pic23
local pic24
local pic25

local pic31
local pic32
local pic33
local pic34
local pic35

local table1 = {}
local table2 = {}
local table3 = {}
local fintable = {}
local counter = 1;

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function setupmap()
		--grid
		grida = display.newImage("rescue_grid.png")
		grida.anchorX=0
		grida.anchorY=0
		grida.x=43.01
		grida.y=41.93
		grida.height=993.04
		grida.width=993.04
		
		--left_wall
		leftwall = display.newImage("side_wall.png")
		leftwall.anchorX=0
		leftwall.anchorY=0
		leftwall.x=43.01
		leftwall.y=41.93
		leftwall.height=993.04
		leftwall.width=10

		--right_wall
		rightwall = display.newImage("side_wall.png")
		rightwall.anchorX=0
		rightwall.anchorY=0
		rightwall.x=1026.05
		rightwall.y=41.93
		rightwall.height=993.04
		rightwall.width=10

		--top_wall
		topwall = display.newImage("topbottom_wall.png")
		topwall.anchorX=0
		topwall.anchorY=0
		topwall.x=43.01
		topwall.y=41.93
		topwall.height=10
		topwall.width=993.04
		
		--bottom_wall
		bottomwall = display.newImage("topbottom_wall.png")
		bottomwall.anchorX=0
		bottomwall.anchorY=0
		bottomwall.x=43.01
		bottomwall.y=1024.97
		bottomwall.height=10
		bottomwall.width=993.04
		
		--one_loop
		onel = display.newImage("one_loop.png")
		onel.anchorX=0
		onel.anchorY=0
		onel.x=1063.96
		onel.y=625
		onel.height=133
		onel.width=805
		
		--two_loop
		twol = display.newImage("two_loop.png")
		twol.anchorX=0
		twol.anchorY=0
		twol.x=1063.96
		twol.y=768
		twol.height=133
		twol.width=805
		
		
		--three_loop
		threel = display.newImage("three_loop.png")
		threel.anchorX=0
		threel.anchorY=0
		threel.x=1063.96
		threel.y=910
		threel.height=133
		threel.width=805
		
		--up_arrow
		upa = display.newImage("up_arrow.png")
		upa.anchorX=0
		upa.anchorY=0
		upa.x=1192
		upa.y=186
		upa.height=122
		upa.width=122
		
		--down_arrow
		downa = display.newImage("down_arrow.png")
		downa.anchorX=0
		downa.anchorY=0
		downa.x=1330
		downa.y=186
		downa.height=122
		downa.width=122
		
		--left_arrow
		lefta = display.newImage("left_arrow.png")
		lefta.anchorX=0
		lefta.anchorY=0
		lefta.x=1468
		lefta.y=186
		lefta.height=122
		lefta.width=122
		
		--right_arrow
		righta = display.newImage("right_arrow.png")
		righta.anchorX=0
		righta.anchorY=0
		righta.x=1606
		righta.y=186
		righta.height=122
		righta.width=122
		
		--one_button
		oneb = display.newImage("one_button.png")
		oneb.anchorX=0
		oneb.anchorY=0
		oneb.x=1261
		oneb.y=332
		oneb.height=122
		oneb.width=122
		
		--two_button
		twob = display.newImage("two_button.png")
		twob.anchorX=0
		twob.anchorY=0
		twob.x=1399
		twob.y=332
		twob.height=122
		twob.width=122
		
		--three_button
		threeb = display.newImage("three_button.png")
		threeb.anchorX=0
		threeb.anchorY=0
		threeb.x=1538
		threeb.y=332
		threeb.height=122
		threeb.width=122
		
		--start_button
		start= display.newImage("start_button.png")
		start.anchorX=0
		start.anchorY=0
		start.x=46
		start.y=968
		start.height=66
		start.width=246

		--wall_a
		walla= display.newImage("locked_door_horizontal.png")
		walla.anchorX=0
		walla.anchorY=0
		walla.x=110
		walla.y=288
		walla.height=10
		walla.width=124

		--wall_b
		wallb= display.newImage("locked_door_horizontal.png")
		wallb.anchorX=0
		wallb.anchorY=0
		wallb.x=359
		wallb.y=288
		wallb.height=11
		wallb.width=124

		--wall_c
		wallc= display.newImage("locked_door_horizontal.png")
		wallc.anchorX=0
		wallc.anchorY=0
		wallc.x=598
		wallc.y=288
		wallc.height=11
		wallc.width=124

		--wall_d
		walld= display.newImage("locked_door_horizontal.png")
		walld.anchorX=0
		walld.anchorY=0
		walld.x=839
		walld.y=288
		walld.height=11
		walld.width=124

		--wall_f
		wallf= display.newImage("locked_door_horizontal.png")
		wallf.anchorX=0
		wallf.anchorY=0
		wallf.x=359
		wallf.y=533
		wallf.height=11
		wallf.width=124

		--wall_j
		wallj= display.newImage("locked_door_horizontal.png")
		wallj.anchorX=0
		wallj.anchorY=0
		wallj.x=359
		wallj.y=777
		wallj.height=11
		wallj.width=124

		--wall_7
		wall7= display.newImage("locked_door_vertical.png")
		wall7.anchorX=0
		wall7.anchorY=0
		wall7.x=290
		wall7.y=602
		wall7.height=124
		wall7.width=11

		--wall_8
		wall8= display.newImage("locked_door_vertical.png")
		wall8.anchorX=0
		wall8.anchorY=0
		wall8.x=534
		wall8.y=602
		wall8.height=124
		wall8.width=12

		--scientist
		science= display.newImage("scientist.png")
		science.anchorX=0
		science.anchorY=0
		science.x=843
		science.y=348
		science.height=140
		science.width=140

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
		physics.addBody( wall8, "static",{bounce=0})
		physics.addBody( wall7, "static",{bounce=0})
		physics.addBody( walla, "static",{bounce=0})
		physics.addBody( wallb, "static",{bounce=0})
		physics.addBody( wallc, "static",{bounce=0})
		physics.addBody( walld, "static",{bounce=0})
		physics.addBody( wallf, "static",{bounce=0})
		physics.addBody( wallj, "static",{bounce=0})
		physics.addBody( leftwall, "static",{bounce=0})
		physics.addBody( rightwall, "static",{bounce=0})
		physics.addBody( topwall, "static",{bounce=0})
		physics.addBody( bottomwall, "static",{bounce=0})
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
		physics.addBody( science, "static",{bounce=0})
end 

local function handleButtonEvent( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        if(event.target.id == "oneloopBtn1") then
			table1[1] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 11)
		end
		if(event.target.id == "oneloopBtn2") then
			table1[2] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 12)
		end
		if(event.target.id == "oneloopBtn3") then
			table1[3] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 13)
		end
		if(event.target.id == "oneloopBtn4") then
			table1[4] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 14)
		end
		if(event.target.id == "oneloopBtn5") then
			table1[5] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 15)
		end
		if(event.target.id == "twoloopBtn1") then
			table2[1] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 21)
		end
		if(event.target.id == "twoloopBtn2") then
			table2[2] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 22)
		end
		if(event.target.id == "twoloopBtn3") then
			table2[3] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 23)
		end
		if(event.target.id == "twoloopBtn4") then
			table2[4] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 24)
		end
		if(event.target.id == "twoloopBtn5") then
			table2[5] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 25)
		end
		if(event.target.id == "threeloopBtn1") then
			table3[1] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 31)
		end
		if(event.target.id == "threeloopBtn2") then
			table3[2] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 32)
		end
		if(event.target.id == "threeloopBtn3") then
			table3[3] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 33)
		end
		if(event.target.id == "threeloopBtn4") then
			table3[4] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 34)
		end
		if(event.target.id == "threeloopBtn5") then
			table3[5] = picToAdd
			addPic(event.target.x, event.target.y,picToAdd, 35)
		end
    end
end




function addPic(xVal,yVal,name,spot)

	if(spot == 11) then
	
		if(pic11 == nil) then
			pic11 = display.newImage(name)
			pic11.anchorX = 0.5
			pic11.anchorY = 0.5
			pic11.x = xVal
			pic11.y = yVal
			pic11.height = 120
			pic11.width = 120
		else
			pic11:removeSelf()
			pic11 = display.newImage(name)
			pic11.anchorX = 0.5
			pic11.anchorY = 0.5
			pic11.x = xVal
			pic11.y = yVal
			pic11.height = 120
			pic11.width = 120
		end
	end
	if(spot == 12) then
		if(pic12 == nil) then
			pic12 = display.newImage(name)
			pic12.anchorX = 0.5
			pic12.anchorY = 0.5
			pic12.x = xVal
			pic12.y = yVal
			pic12.height = 120
			pic12.width = 120
		else
			pic12:removeSelf()
			pic12 = display.newImage(name)
			pic12.anchorX = 0.5
			pic12.anchorY = 0.5
			pic12.x = xVal
			pic12.y = yVal
			pic12.height = 120
			pic12.width = 120
			
			
		end
	end
	if(spot == 13) then
		if(pic13 == nil) then
			pic13 = display.newImage(name)
			pic13.anchorX = 0.5
			pic13.anchorY = 0.5
			pic13.x = xVal
			pic13.y = yVal
			pic13.height = 120
			pic13.width = 120
			
		else
			pic13:removeSelf()
			pic13 = display.newImage(name)
			pic13.anchorX = 0.5
			pic13.anchorY = 0.5
			pic13.x = xVal
			pic13.y = yVal
			pic13.height = 120
			pic13.width = 120
		end
	end
	if(spot == 14) then
		if(pic14 == nil) then
			pic14 = display.newImage(name)
			pic14.anchorX = 0.5
			pic14.anchorY = 0.5
			pic14.x = xVal
			pic14.y = yVal
			pic14.height = 120
			pic14.width = 120
		else
			pic14:removeSelf()
			pic14 = display.newImage(name)
			pic14.anchorX = 0.5
			pic14.anchorY = 0.5
			pic14.x = xVal
			pic14.y = yVal
			pic14.height = 120
			pic14.width = 120
			
			
		end
	end
	if(spot == 15) then
		if(pic15 == nil) then
			pic15 = display.newImage(name)
			pic15.anchorX = 0.5
			pic15.anchorY = 0.5
			pic15.x = xVal
			pic15.y = yVal
			pic15.height = 120
			pic15.width = 120
		else
			pic15:removeSelf()
			pic15 = display.newImage(name)
			pic15.anchorX = 0.5
			pic15.anchorY = 0.5
			pic15.x = xVal
			pic15.y = yVal
			pic15.height = 120
			pic15.width = 120
			
			
		end
	end
	if(spot == 21) then
		if(pic21 == nil) then
			pic21 = display.newImage(name)
			pic21.anchorX = 0.5
			pic21.anchorY = 0.5
			pic21.x = xVal
			pic21.y = yVal
			pic21.height = 120
			pic21.width = 120
		else
			pic21:removeSelf()
			pic21 = display.newImage(name)
			pic21.anchorX = 0.5
			pic21.anchorY = 0.5
			pic21.x = xVal
			pic21.y = yVal
			pic21.height = 120
			pic21.width = 120
		end
	end
	if(spot == 22) then
		if(pic22 == nil) then
			pic22 = display.newImage(name)
			pic22.anchorX = 0.5
			pic22.anchorY = 0.5
			pic22.x = xVal
			pic22.y = yVal
			pic22.height = 120
			pic22.width = 120
		else
			pic22:removeSelf()
			pic22 = display.newImage(name)
			pic22.anchorX = 0.5
			pic22.anchorY = 0.5
			pic22.x = xVal
			pic22.y = yVal
			pic22.height = 120
			pic22.width = 120
		end
	end
	if(spot == 23) then
		if(pic23 == nil) then
			pic23 = display.newImage(name)
			pic23.anchorX = 0.5
			pic23.anchorY = 0.5
			pic23.x = xVal
			pic23.y = yVal
			pic23.height = 120
			pic23.width = 120
		else
			pic23:removeSelf()
			pic23 = display.newImage(name)
			pic23.anchorX = 0.5
			pic23.anchorY = 0.5
			pic23.x = xVal
			pic23.y = yVal
			pic23.height = 120
			pic23.width = 120
		end
	end
	if(spot == 24) then
		if(pic24 == nil) then
			pic24 = display.newImage(name)
			pic24.anchorX = 0.5
			pic24.anchorY = 0.5
			pic24.x = xVal
			pic24.y = yVal
			pic24.height = 120
			pic24.width = 120
		else
			pic24:removeSelf()
			pic24 = display.newImage(name)
			pic24.anchorX = 0.5
			pic24.anchorY = 0.5
			pic24.x = xVal
			pic24.y = yVal
			pic24.height = 120
			pic24.width = 120
		end
	end
	if(spot == 25) then
		if(pic25 == nil) then
			pic25 = display.newImage(name)
			pic25.anchorX = 0.5
			pic25.anchorY = 0.5
			pic25.x = xVal
			pic25.y = yVal
			pic25.height = 120
			pic25.width = 120
		else
			pic25:removeSelf()
			pic25 = display.newImage(name)
			pic25.anchorX = 0.5
			pic25.anchorY = 0.5
			pic25.x = xVal
			pic25.y = yVal
			pic25.height = 120
			pic25.width = 120
		end
	end
	if(spot == 31) then
		if(pic31 == nil) then
			pic31 = display.newImage(name)
			pic31.anchorX = 0.5
			pic31.anchorY = 0.5
			pic31.x = xVal
			pic31.y = yVal
			pic31.height = 120
			pic31.width = 120
		else
			pic31:removeSelf()
			pic31 = display.newImage(name)
			pic31.anchorX = 0.5
			pic31.anchorY = 0.5
			pic31.x = xVal
			pic31.y = yVal
			pic31.height = 120
			pic31.width = 120
		end
	end
	if(spot == 32) then
		if(pic32 == nil) then
			pic32 = display.newImage(name)
			pic32.anchorX = 0.5
			pic32.anchorY = 0.5
			pic32.x = xVal
			pic32.y = yVal
			pic32.height = 120
			pic32.width = 120
		else
			pic32:removeSelf()
			pic32 = display.newImage(name)
			pic32.anchorX = 0.5
			pic32.anchorY = 0.5
			pic32.x = xVal
			pic32.y = yVal
			pic32.height = 120
			pic32.width = 120
		end
	end
	if(spot == 33) then
		if(pic33 == nil) then
			pic33 = display.newImage(name)
			pic33.anchorX = 0.5
			pic33.anchorY = 0.5
			pic33.x = xVal
			pic33.y = yVal
			pic33.height = 120
			pic33.width = 120
		else
			pic33:removeSelf()
			pic33 = display.newImage(name)
			pic33.anchorX = 0.5
			pic33.anchorY = 0.5
			pic33.x = xVal
			pic33.y = yVal
			pic33.height = 120
			pic33.width = 120
		end
	end
	if(spot == 34) then
		if(pic34 == nil) then
			pic34 = display.newImage(name)
			pic34.anchorX = 0.5
			pic34.anchorY = 0.5
			pic34.x = xVal
			pic34.y = yVal
			pic34.height = 120
			pic34.width = 120
		else
			pic34:removeSelf()
			pic34 = display.newImage(name)
			pic34.anchorX = 0.5
			pic34.anchorY = 0.5
			pic34.x = xVal
			pic34.y = yVal
			pic34.height = 120
			pic34.width = 120
		end
	end
	if(spot == 35) then
		if(pic35 == nil) then
			pic35 = display.newImage(name)
			pic35.anchorX = 0.5
			pic35.anchorY = 0.5
			pic35.x = xVal
			pic35.y = yVal
			pic35.height = 120
			pic35.width = 120
		else
			pic35:removeSelf()
			pic35 = display.newImage(name)
			pic35.anchorX = 0.5
			pic35.anchorY = 0.5
			pic35.x = xVal
			pic35.y = yVal
			pic35.height = 120
			pic35.width = 120
		end
	end
	picToAdd = ""
	
end

local function moveu()
		robo:applyForce( 0, -200, robo.x+70, robo.y+70 )
		--get command
		
		
end

local function moveup()
		
		
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectu, { time=16, x=robotX, y=robotY-240} )
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
		transition.to( myrectr, { time=16, x=robotX+310, y=robotY} )
		
		timer.performWithDelay(20,moveri)
end

local function movedo()
		robo:applyForce( 0, 200, robo.x+70, robo.y+70 )
end

local function moved()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectd, { time=16, x=robotX, y=robotY+380} )
		
		timer.performWithDelay(20,movedo)
		
		
		
		
end

local function movele()
		robo:applyForce( -200, 0, robo.x+70, robo.y+70 )
		
end

local function movel()
		local robotMusic = audio.loadStream( "Pew_Pew.mp3")
		local robotMusicplay = audio.play( robotMusic, { loops=0 } )
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectl, { time=16, x=robotX-310, y=robotY} )
		
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
function scene:resetrobot()
		
		transition.to( robo, { time=16, x=109, y=819} )
		local robotX, robotY = robo:localToContent( -70, -70 )
		transition.to( myrectu, { time=16, x=robotX, y=robotY-240} )
		transition.to( myrectl, { time=16, x=robotX-240, y=robotY} )
		transition.to( myrectd, { time=16, x=robotX, y=robotY+240} )
		transition.to( myrectr, { time=16, x=robotX+240, y=robotY} )
		fintable=nil
		fintable={}
		counter=1
end
function restartrobot()
	
		transition.to( robo, { time=16, x=109, y=819} )
		local robotX, robotY = robo:localToContent( -70, -70 )
		transition.to( myrectu, { time=16, x=robotX, y=robotY-240} )
		transition.to( myrectl, { time=16, x=robotX-240, y=robotY} )
		transition.to( myrectd, { time=16, x=robotX, y=robotY+240} )
		transition.to( myrectr, { time=16, x=robotX+240, y=robotY} )
		fintable=nil
		fintable={}
		counter=1
end

local function threetap()
	picToAdd = "three_button.png"

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
		elseif (event.object2==science) then
			print("Scientist")
			local options = {
				effect = "crossFade",
				time = 500
			}
			audio.pause(backgroundMusicplay)
			composer.gotoScene("Credits",options)
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
	merge(table1)
	moverobot()
end







-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    local backgroundMusic = audio.loadStream( "bensound-theelevatorbossanova.mp3")
	local backgroundMusicplay = audio.play( backgroundMusic, {  fadein = 4000, loops=-1 } )
    

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
	local one_loop_btn1 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1270.21 ,
		y = 690.86 ,
	    label = "",
		id = "oneloopBtn1",
		onEvent = handleButtonEvent
		
		
	}
	
	local one_loop_btn2 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1402.21 ,
		y = 690.86 ,
	    label = "",
		id = "oneloopBtn2",
		onEvent = handleButtonEvent
		
		
	}
	
	local one_loop_btn3 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1530.21  ,
		y = 690.86 ,
	    label = "",
		id = "oneloopBtn3",
		onEvent = handleButtonEvent
		
		
	}
	
	
	local one_loop_btn4 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1660.21 ,
		y = 690.86 ,
	    label = "",
		id = "oneloopBtn4",
		onEvent = handleButtonEvent
		
		
	}
	
	local one_loop_btn5 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1790.21 ,
		y = 690.86,
	    label = "",
		id = "oneloopBtn5",
		onEvent = handleButtonEvent
		
	}
	
	--two loop buttons
	
	local two_loop_btn1 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1270.21 ,
		y = 835.86 ,
	    label = "",
		id = "twoloopBtn1",
		onEvent = handleButtonEvent
		
		
	}
	
	local two_loop_btn2 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1402.21 ,
		y = 835.86  ,
	    label = "",
		id = "twoloopBtn2",
		onEvent = handleButtonEvent
		
		
	}
	
	local two_loop_btn3 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1530.21  ,
		y = 835.86  ,
	    label = "",
		id = "twoloopBtn3",
		onEvent = handleButtonEvent
		
		
	}
	
	
	local two_loop_btn4 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1660.21 ,
		y = 835.86 ,
	    label = "",
		id = "twoloopBtn4",
		onEvent = handleButtonEvent
		
		
	}
	
	local two_loop_btn5 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1790.21 ,
		y = 835.86 ,
	    label = "",
		id = "twoloopBtn5",
		onEvent = handleButtonEvent
		
		
	}
	
	--three loop buttons
	
	local three_loop_btn1 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1270.21 ,
		y = 980.86 ,
	    label = "",
		id = "threeloopBtn1",
		onEvent = handleButtonEvent
		
		
	}
	
	local three_loop_btn2 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1402.21 ,
		y = 980.86  ,
	    label = "",
		id = "threeloopBtn2",
		onEvent = handleButtonEvent
		
		
	}
	
	local three_loop_btn3 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1530.21  ,
		y = 980.86  ,
	    label = "",
		id = "threeloopBtn3",
		onEvent = handleButtonEvent
		
		
	}
	
	
	local three_loop_btn4 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1660.21 ,
		y = 980.86 ,
	    label = "",
		id = "threeloopBtn4",
		onEvent = handleButtonEvent
		
		
	}
	
	local three_loop_btn5 = widget.newButton
	{
		width = 120,
	    height = 120,
		x = 1790.21 ,
		y = 980.86 ,
	    label = "",
		id = "threeloopBtn5",
		onEvent = handleButtonEvent
		
		
	}
	
	
		
		
		
	setupmap()
		
	--robo.collision = onLocalCollision
	--robo:addEventListener( "collision", robo )
	Runtime:addEventListener( "collision", onCollision )
	upa:addEventListener( "tap", mutap )
		
	downa:addEventListener( "tap", mdtap )
	lefta:addEventListener( "tap", mltap )
	righta:addEventListener( "tap", mrtap )
	oneb:addEventListener("tap", onetap)
	twob:addEventListener("tap", twotap)
	threeb:addEventListener("tap", threetap)
	start:addEventListener("tap", pass)
	
	--add buttons
	sceneGroup:insert(one_loop_btn1)
	sceneGroup:insert(one_loop_btn2)
	sceneGroup:insert(one_loop_btn3)
	sceneGroup:insert(one_loop_btn4)
	sceneGroup:insert(one_loop_btn5)
	
	sceneGroup:insert(two_loop_btn1)
	sceneGroup:insert(two_loop_btn2)
	sceneGroup:insert(two_loop_btn3)
	sceneGroup:insert(two_loop_btn4)
	sceneGroup:insert(two_loop_btn5)
	
	sceneGroup:insert(three_loop_btn1)
	sceneGroup:insert(three_loop_btn2)
	sceneGroup:insert(three_loop_btn3)
	sceneGroup:insert(three_loop_btn4)
	sceneGroup:insert(three_loop_btn5)
	
	--add grid
	sceneGroup:insert(grida)
	sceneGroup:insert(onel)
	sceneGroup:insert(twol)
	sceneGroup:insert(threel)
	sceneGroup:insert(upa)
	sceneGroup:insert(downa)
	sceneGroup:insert(lefta)
	sceneGroup:insert(righta)
	sceneGroup:insert(oneb)
	sceneGroup:insert(twob)
	sceneGroup:insert(threeb)
	sceneGroup:insert(start)
	
	--add character
	sceneGroup:insert(robo)
	sceneGroup:insert(science)
	
	--add walls
	sceneGroup:insert(walla)
	sceneGroup:insert(wallb)
	sceneGroup:insert(wallc)
	sceneGroup:insert(walld)
	sceneGroup:insert(wallf)
	sceneGroup:insert(wallj)
	sceneGroup:insert(wall7)
	sceneGroup:insert(wall8)
	sceneGroup:insert(bottomwall)
	sceneGroup:insert(topwall)
	sceneGroup:insert(leftwall)
	sceneGroup:insert(rightwall)
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
		pic11:removeSelf()
		pic12:removeSelf()
		pic13:removeSelf()
		pic14:removeSelf()
		pic15:removeSelf()
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