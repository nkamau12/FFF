local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local pic11
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
function handleButtonEvent()
		pic11.alpha=1
end 
local function nextspeech()
		display.remove(pic11)
		pic11:removeSelf()
		pic11=nil
			composer.hideOverlay( "fade", 400 )
end
-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
	
	speech1= display.newImage("tutorial_rescue_5.png")
		speech1.anchorX=0
		speech1.anchorY=1
		speech1.x=109
		speech1.y=819+20
		speech1.myName="speech1"
		local speech1X, speech1Y = speech1:localToContent( -70, -70 )
		nextb = display.newImage("next.png")
		nextb.anchorX=0
		nextb.anchorY=0
		nextb.x=speech1X-20
		nextb.y=speech1Y+150
		nextb.myName="nextb"
	arrow = display.newImage("alert_arrow.png")
	arrow.anchorX=1
	arrow.anchorY=0.5
	arrow.x=1192
	arrow.y=705
	sceneGroup:insert(arrow)
	
	pic11 = display.newImage("up_arrow.png")
			pic11.anchorX = 0.5
			pic11.anchorY = 0.5
			pic11.x = 1270.21
			pic11.y = 690.86
			pic11.height = 120
			pic11.width = 120
			pic11.alpha=0
	sceneGroup:insert(pic11)
	
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
	
	sceneGroup:insert(speech1)
	sceneGroup:insert(nextb)
	nextb:addEventListener("tap",nextspeech)
	
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
	
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
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
	
			local options = {
			isModal = true,
			
			params = {
			sampleVar = "my sample variable"
				}
			}
			composer.showOverlay( "RescueTutorial7over", options )
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