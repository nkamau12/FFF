local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function setupmap()

        --red_block
        blockred = display.newImage("red_block.png")
        blockred.anchorX=0
        blockred.anchorY=0
        blockred.x=1289
        blockred.y=729
        blockred.height=120
        blockred.width=120

        --green_block
        blockgreen = display.newImage("green_block.png")
        blockgreen.anchorX=0
        blockgreen.anchorY=0
        blockgreen.x=1426
        blockgreen.y=729
        blockgreen.height=120
        blockgreen.width=120

        --blue_block
        blockblue = display.newImage("blue_block.png")
        blockblue.anchorX=0
        blockblue.anchorY=0
        blockblue.x=1564
        blockblue.y=729
        blockblue.height=120
        blockblue.width=120
        
        --yellow_block
        blockyellow = display.newImage("yellow_block.png")
        blockyellow.anchorX=0
        blockyellow.anchorY=0
        blockyellow.x=1700
        blockyellow.y=729
        blockyellow.height=120
        blockyellow.width=120
        
        --run_button
        runbutton = display.newImage("run_button.png")
        runbutton.anchorX=0
        runbutton.anchorY=0
        runbutton.x=1375
        runbutton.y=887
        runbutton.height=120
        runbutton.width=360
        
end 

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    --local backgroundMusic = audio.loadStream( "bensound-theelevatorbossanova.mp3")
    --local backgroundMusicplay = audio.play( backgroundMusic, {  loops=-1 } )
    

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    local background = display.newImage("search_background.png",system.ResourceDirectory)
        background.anchorX=0.5
        background.anchorY=0.5
        background.height=1080
        background.width=1920
        background.x= display.contentCenterX
        background.y=display.contentCenterY
        sceneGroup:insert(background)
        
        setupmap()

        sceneGroup:insert(blockred)
        sceneGroup:insert(blockgreen)
        sceneGroup:insert(blockblue)
        sceneGroup:insert(blockyellow)
        sceneGroup:insert(runbutton)
        
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