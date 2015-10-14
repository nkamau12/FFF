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
		grida.x=119.17
		grida.y=82.17
		grida.height=900
		grida.width=900
		
		
		--one_loop
		onel = display.newImage("one_loop.png")
		onel.anchorX=0
		onel.anchorY=0
		onel.x=1063.96
		onel.y=613.61
		onel.height=117.03
		onel.width=709.42
		
		--two_loop
		twol = display.newImage("two_loop.png")
		twol.anchorX=0
		twol.anchorY=0
		twol.x=1063.96
		twol.y=741.17
		twol.height=117.03
		twol.width=709.42
		
		
		--three_loop
		threel = display.newImage("three_loop.png")
		threel.anchorX=0
		threel.anchorY=0
		threel.x=1063.96
		threel.y=868.57
		threel.height=117.03
		threel.width=709.42
		
		--up_arrow
		 upa = display.newImage("up_arrow.png")
		upa.anchorX=0
		upa.anchorY=0
		upa.x=1190.95
		upa.y=219.17
		upa.height=106.04
		upa.width=106.04
		
		--down_arrow
		downa = display.newImage("down_arrow.png")
		downa.anchorX=0
		downa.anchorY=0
		downa.x=1311.31
		downa.y=219.17
		downa.height=106.04
		downa.width=106.04
		
		--left_arrow
		lefta = display.newImage("left_arrow.png")
		lefta.anchorX=0
		lefta.anchorY=0
		lefta.x=1551.8
		lefta.y=219.17
		lefta.height=106.04
		lefta.width=106.04
		
		--right_arrow
		righta = display.newImage("right_arrow.png")
		righta.anchorX=0
		righta.anchorY=0
		righta.x=1432.05
		righta.y=219.17
		righta.height=106.04
		righta.width=106.04
		
		--one_button
		oneb = display.newImage("one_button.png")
		oneb.anchorX=0
		oneb.anchorY=0
		oneb.x=1251.21
		oneb.y=346.86
		oneb.height=106.04
		oneb.width=106.04
		
		--two_button
		twob = display.newImage("two_button.png")
		twob.anchorX=0
		twob.anchorY=0
		twob.x=1371.77
		twob.y=346.86
		twob.height=106.04
		twob.width=106.04
		
		--three_button
		threeb = display.newImage("three_button.png")
		threeb.anchorX=0
		threeb.anchorY=0
		threeb.x=1492.56
		threeb.y=346.86
		threeb.height=106.04
		threeb.width=106.04
		
		--start_button
		start= display.newImage("start_button.png")
		start.anchorX=0
		start.anchorY=0
		start.x=123
		start.y=918
		start.height=60
		start.width=223

		--wall_a
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=181
		start.y=305
		start.height=10
		start.width=110.5

		--wall_b
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=408
		start.y=305
		start.height=10
		start.width=110.5

		--wall_c
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=621
		start.y=305
		start.height=10
		start.width=110.5

		--wall_d
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=842
		start.y=305
		start.height=10
		start.width=110.5

		--wall_f
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=408
		start.y=527
		start.height=10
		start.width=110.5

		--wall_j
		start= display.newImage("locked_door_horizontal.png")
		start.anchorX=0
		start.anchorY=0
		start.x=408
		start.y=750
		start.height=10
		start.width=110.5

		--wall_7
		start= display.newImage("locked_door_vertical.png")
		start.anchorX=0
		start.anchorY=0
		start.x=341
		start.y=590
		start.height=110.5
		start.width=10

		--wall_8
		start= display.newImage("locked_door_vertical.png")
		start.anchorX=0
		start.anchorY=0
		start.x=564
		start.y=590
		start.height=110.5
		start.width=10

		--scientist
		start= display.newImage("scientist.png")
		start.anchorX=0
		start.anchorY=0
		start.x=859
		start.y=363
		start.height=126
		start.width=126
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