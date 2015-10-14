local composer = require( "composer" )

local scene = composer.newScene()

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
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=110
		start.y=288
		start.height=10
		start.width=124

		--wall_b
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=359
		start.y=288
		start.height=11
		start.width=124

		--wall_c
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=598
		start.y=288
		start.height=11
		start.width=124

		--wall_d
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=839
		start.y=288
		start.height=11
		start.width=124

		--wall_f
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=359
		start.y=533
		start.height=11
		start.width=124

		--wall_j
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=359
		start.y=777
		start.height=11
		start.width=124

		--wall_7
		start= display.newImage("locked_door_vertical.png")
		start.anchorX=0
		start.anchorY=0
		start.x=290
		start.y=602
		start.height=124
		start.width=11

		--wall_8
		start= display.newImage("locked_door_vertical.png")
		start.anchorX=0
		start.anchorY=0
		start.x=534
		start.y=602
		start.height=124
		start.width=12

		--scientist
		start= display.newImage("scientist.png")
		start.anchorX=0
		start.anchorY=0
		start.x=843
		start.y=348
		start.height=140
		start.width=140

		--robot
		start= display.newImage("robot.png")
		start.anchorX=0
		start.anchorY=0
		start.x=109
		start.y=819
		start.height=140
		start.width=140
end 

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    local backgroundMusic = audio.loadStream( "bensound-theelevatorbossanova.mp3")
	local backgroundMusicplay = audio.play( backgroundMusic, {  loops=-1 } )
    

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
		--sceneGroup:insert(start)
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