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
		science.x=843-(3*240)
		science.y=348-240
		science.height=140
		science.width=140

		--robot
		robot= display.newImage("robot.png")
		robot.anchorX=0
		robot.anchorY=0
		robot.x=109
		robot.y=819
		robot.height=140
		robot.width=140
		robot.myName="robot"
end 




function scene:runsomestuff()
	composer.removeScene( "RescueTutorial1over" )
	composer.removeScene( "RescueTutorial2over" )
	composer.removeScene( "RescueTutorial3over" )
	composer.removeScene( "RescueTutorial4over" )
	composer.removeScene( "RescueTutorial5over" )
	composer.removeScene( "RescueTutorial7over" )
	composer.removeScene( "RescueTutorial8over" )
	composer.removeScene( "RescueTutorial9over" )
	composer.removeScene( "RescueTutorial10over" )
	composer.gotoScene( "MainMenu" )
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
	
	--buttons
	
	--one loop button
	
	
		
		
		
	setupmap()
		

	
	
	
	
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
	sceneGroup:insert(robot)
	sceneGroup:insert(science)
	
	--add walls
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
		
		local options = {
			isModal = true,
			
			params = {
			sampleVar = "my sample variable"
				}
			}
			composer.showOverlay( "RescueTutorial1over", options )
		
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
		--pic11:removeSelf()
		--pic12:removeSelf()
		--pic13:removeSelf()
		--pic14:removeSelf()
		--pic15:removeSelf()
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