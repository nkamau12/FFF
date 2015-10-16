local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local upa1
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local function nextspeech()
			
end

local function handleButtonEvent()
		upa1.alpha=1
end 

local function endtutorial()
		composer.hideOverlay( "fade", 400 )
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
	
	speech1= display.newImage("tutorial_rescue_10.png")
		speech1.anchorX=0
		speech1.anchorY=1
		speech1.x=109
		speech1.y=819+20
		speech1.myName="speech1"
		
	
	arrow = display.newImage("alert_arrow.png")
	arrow.anchorX=1
	arrow.anchorY=0.5
	arrow.x=1192
	arrow.y=246
	sceneGroup:insert(arrow)
	
	arrow2 = display.newImage("alert_arrow_v.png")
	arrow2.anchorX=0.5
	arrow2.anchorY=0
	arrow2.x=1530.21  
	arrow2.y=750.86
	sceneGroup:insert(arrow2)
	
	arrow3 = display.newImage("alert_arrowl.png")
	arrow3.anchorX=0
	arrow3.anchorY=0.5
	arrow3.x=46 +246
	arrow3.y=968+33
	sceneGroup:insert(arrow3)
	
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
	local endall = widget.newButton
	{	
		anchorX=0,
		anchorY=0,
		width = 246,
	    height = 66,
		x = 46 ,
		y = 968 ,
	    label = "",
		id = "endall",
		onEvent = endtutorial
		
		
	}
	sceneGroup:insert(speech1)
	nextb:addEventListener("tap",nextspeech)
	
    -- Initialize the scene here.
	pic1 = display.newImage("up_arrow.png")
			pic1.anchorX = 0.5
			pic1.anchorY = 0.5
			pic1.x = 1270.21
			pic1.y = 690.86
			pic1.height = 120
			pic1.width = 120
		sceneGroup:insert(pic1)
		
		pic11 = display.newImage("two_button.png")
			pic11.anchorX = 0.5
			pic11.anchorY = 0.5
			pic11.x = 1402.21
			pic11.y = 690.86
			pic11.height = 120
			pic11.width = 120
			pic11.alpha=1
		sceneGroup:insert(pic11)
		
		upa2 = display.newImage("right_arrow.png")
		upa2.anchorX=0.5
		upa2.anchorY=0.5
		upa2.x=1270.21 
		upa2.y=835.86
		upa2.height=120
		upa2.width=120
		sceneGroup:insert(upa2)
		
		upa = display.newImage("up_arrow.png")
		upa.anchorX=0.5
		upa.anchorY=0.5
		upa.x=1270.21 
		upa.y=835.86
		upa.height=120
		upa.width=120
		upa.alpha=1
		sceneGroup:insert(upa)
		
		upa1 = display.newImage("up_arrow.png")
		upa1.anchorX=0.5
		upa1.anchorY=0.5
		upa1.x=1530.21
		upa1.y=690.86 
		upa1.height=120
		upa1.width=120
		upa1.alpha=0
		sceneGroup:insert(upa1)
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
			
			--composer.showOverlay( "RescueTutorial11over", options )
			local parent = event.parent
			parent:runsomestuff()
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
	display.remove(upa1)
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