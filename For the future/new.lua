local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local direction = "scientist.png"
local widget = require( "widget" )
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
		
		--invis button
		Accept = widget.newButton
		{
		width = 200,
		height = 100,
		onEvent = addimg11,
		defaultFile= direction
		}	
		
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
		
		--robot
		physics.addBody( robot,"dynamic",{bounce=0,friction=.8})
		robot.isFixedRotation = true
		robo=robot
		--Misc
		local robotX, robotY = robo:localToContent( -70, -70 )
		myrectu = display.newRect( robotX, robotY-240, 1, 1)
		--{26,74,94}
		physics.addBody( myrectu, "static",{bounce=0})
		myrectd = display.newRect( robotX, robotY+240, 1, 1)
		physics.addBody( myrectd, "static",{bounce=0})
		myrectl = display.newRect( robotX-240, robotY, 1, 1)
		physics.addBody( myrectl, "static",{bounce=0})
		myrectr = display.newRect( robotX+240, robotY, 1, 1)
		physics.addBody( myrectr, "static",{bounce=0})
		
		--scientist
		physics.addBody( science, "static",{bounce=0})
end 

local function moveu()
		robo:applyForce( 0, -200, robo.x+70, robo.y+70 )
end

local function setvarup()
	if (direction=="up_arrow.png") then
		direction="scientist.png"
	else
		direction="up_arrow.png"
	end
end 

local function moveup()
		
		setvarup()
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
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectr, { time=16, x=robotX+310, y=robotY} )
		
		timer.performWithDelay(20,moveri)
end

local function movedo()
		robo:applyForce( 0, 200, robo.x+70, robo.y+70 )
end

local function moved()
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectd, { time=16, x=robotX, y=robotY+380} )
		
		timer.performWithDelay(20,movedo)
		
end

local function movele()
		robo:applyForce( -200, 0, robo.x+70, robo.y+70 )
end

local function movel()
		local robotX, robotY = robo:localToContent( 0, -70 )
		transition.to( myrectl, { time=16, x=robotX-310, y=robotY} )
		
		timer.performWithDelay(20,movele)
end

local function onCollision( event )
		if (event.object2==myrectu or event.object2==myrectd or event.object2==myrectl or event.object2==myrectr) then
		
		elseif (event.object2==science) then
			print("Scientist")
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

function scene:resetrobot()
		local robotX, robotY = robo:localToContent( -70, -70 )
		transition.to( robo, { time=16, x=109, y=819} )
		transition.to( myrectu, { time=16, x=robotX, y=robotY-240} )
		transition.to( myrectl, { time=16, x=robotX-240, y=robotY} )
		transition.to( myrectd, { time=16, x=robotX, y=robotY+240} )
		transition.to( myrectr, { time=16, x=robotX+240, y=robotY} )
end


 
local function setvard()
	if (direction=="down_arrow.png") then
		direction=""
	else
		direction="down_arrow.png"
	end
end 
local function setvarr()
	if (direction=="right_arrow.png") then
		direction=""
	else
		direction="right_arrow.png"
	end
end 
local function setvarl()
	if (direction=="left_arrow.png") then
		direction=""
	else
		direction="left_arrow.png"
	end
end 

local function addimg11()
	Accept:removeSelf()
	Accept = widget.newButton
		{
		width = 200,
		height = 100,
		onEvent = addimg11,
		defaultFile=direction
		}
	Accept.x=520
	Accept.y=500
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    --local backgroundMusic = audio.loadStream( "bensound-theelevatorbossanova.mp3")
	--local backgroundMusicplay = audio.play( backgroundMusic, {  loops=-1 } )
    

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
		
		setupmap()
		sceneGroup:insert(Accept)
		--robo.collision = onLocalCollision
		--robo:addEventListener( "collision", robo )
		Runtime:addEventListener( "collision", onCollision )
		upa:addEventListener( "tap", moveup )
		
		downa:addEventListener( "tap", moved )
		lefta:addEventListener( "tap", movel )
		righta:addEventListener( "tap", mover )
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
		sceneGroup:insert(robo)
		sceneGroup:insert(science)
		sceneGroup:insert(walla)
		sceneGroup:insert(wallb)
		sceneGroup:insert(wallc)
		sceneGroup:insert(walld)
		sceneGroup:insert(wallf)
		sceneGroup:insert(wallj)
		sceneGroup:insert(wall7)
		sceneGroup:insert(wall8)
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