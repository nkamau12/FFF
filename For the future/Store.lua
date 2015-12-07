local parse = require( "mod_parse" )
local myData = require( "mydata" )
local composer = require( "composer" )
local JSON = require ("json")
local widget = require( "widget" )
local scene = composer.newScene()


local special_pic
local extra_pic
local extra_title
local extra_cost
local extra_table = {
	"Images/robot_santa.png",
	"Images/robot_potato.png",
	"Images/scientist_present.png",
	"Images/scientist_sadface.png",
	"Images/theme_yellow/splash_main.png",
	"Images/theme_red/splash_main.png",
	"Images/theme_green/splash_main.png"
}

local extra_title_table = {
	"Santa Robot",
	"Potato Robot",
	"Present Scientist",
	"Sad Scientist",
	"Yellow Theme",
	"Red Theme",
	"Green Theme"
}

local extra_cost_table = {
	"Cost: 100",
	"Cost: 200",
	"Cost: 100",
	"Cost: 200",
	"Cost: 50",
	"Cost: 100",
	"Cost: 150"
}

local extra_counter = 1
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function gohome( event )
    local options = {
            isModal = true,
            effect = "crossFade",
            time = 500
    }
    composer.gotoScene("MainMenu",options)
end

local function buy()
	print("buy")
end

local function notBuy()
	print("decline")
end

local function buyExtra(event)
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		print(extra_table[extra_counter])
		local options = {
			isModal = true
		}
		composer.showOverlay( "ConfirmStoreBuy", options )
	end
end


local function prevSpecial( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		
	end
end

local function nextSpecial( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
	end
end

local function prevExtra( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		extra_counter = extra_counter - 1
		if(extra_counter == 0) then
			extra_counter = 7
		end
		
		extra_pic:removeSelf()
		extra_title:removeSelf()
		extra_cost:removeSelf()
		extra_title = display.newText(extra_title_table[extra_counter], 1400, 700)
		extra_cost = display.newText(extra_cost_table[extra_counter], 1400,775)
		extra_pic = display.newImage(extra_table[extra_counter],system.ResourceDirectory)
		extra_pic.anchorX = 0.5
		extra_pic.anchorY = 0.5
		extra_pic.x = 1385
		extra_pic.y = 550
		if(extra_counter > 4 and extra_counter < 8) then
			extra_pic.height = 200
			extra_pic.width = 350
		else
			extra_pic.height = 200
			extra_pic.width = 200
		end
	end
end

local function nextExtra( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		extra_counter = extra_counter + 1
		if(extra_table[extra_counter + 1] == nil) then
			extra_counter = 1
		end
		
		extra_pic:removeSelf()
		extra_title:removeSelf()
		extra_cost:removeSelf()
		extra_title = display.newText(extra_title_table[extra_counter], 1400, 700)
		extra_cost = display.newText(extra_cost_table[extra_counter], 1400,775)
		extra_pic = display.newImage(extra_table[extra_counter],system.ResourceDirectory)
		extra_pic.anchorX = 0.5
		extra_pic.anchorY = 0.5
		extra_pic.x = 1385
		extra_pic.y = 550
		if(extra_counter > 4 and extra_counter < 8) then
			extra_pic.height = 200
			extra_pic.width = 350
		else
			extra_pic.height = 200
			extra_pic.width = 200
		end
	end
end



-- "scene:create()"
function scene:create( event )
	
	--update()
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    local sceneGroup = self.view
    local phase = event.phase



    local background = display.newImage("Images/theme_"..myData.theme.."/store.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080
		background.width=1920
		background.x= display.contentCenterX
		background.y=display.contentCenterY
		sceneGroup:insert(background)
		
		--home_button
        homebutton = display.newImage("Images/home.png")
        homebutton.anchorX=0
        homebutton.anchorY=0
        homebutton.x=1699
        homebutton.y=122
        homebutton.height=120
        homebutton.width=120
        sceneGroup:insert(homebutton)
		homebutton:addEventListener( "tap", gohome )


		
		audio.resume(backgroundMusicplay)
end


-- "scene:show()"
function scene:show( event )
	
    local sceneGroup = self.view
    local phase = event.phase
	
    if ( phase == "will" ) then
        local background = display.newImage("Images/theme_"..myData.theme.."/store.png",system.ResourceDirectory)
		background.anchorX=0.5
		background.anchorY=0.5
		background.height=1080
		background.width=1920
		background.x= display.contentCenterX
		background.y=display.contentCenterY
		sceneGroup:insert(background)

		--home_button
        homebutton = display.newImage("Images/home.png")
        homebutton.anchorX=0
        homebutton.anchorY=0
        homebutton.x=1699
        homebutton.y=122
        homebutton.height=120
        homebutton.width=120
        sceneGroup:insert(homebutton)
		homebutton:addEventListener( "tap", gohome )

        local optionsText = {
            text = "Your tokens: "..myData.credits,     
            x = display.contentCenterX - 600,
            y = display.contentCenterY - 350,
            width = 1920-940,     --required for multi-line and alignment
            font = native.systemFontBold,   
            fontSize = 48,
            align = "center"  --new alignment parameter
        }
        trial=display.newText(optionsText)
        sceneGroup:insert(trial) 


        local leftspecials = widget.newButton
            {
            x = 240,
            y = 650,
            shape = "polygon",
            vertices = {240,650, 340,550, 340,750},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = prevSpecial
        }
        sceneGroup:insert(leftspecials)
        
        local rightspecials = widget.newButton
            {
            x = 850,
            y = 650,
            shape = "polygon",
            vertices = {950,650, 850,550, 850,750},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = nextSpecial
        }
        sceneGroup:insert(rightspecials)

        local leftextras = widget.newButton
            {
            x = 1070,
            y = 650,
            shape = "polygon",
            vertices = {1070,650, 1170,550, 1170,750},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = prevExtra
        }
        sceneGroup:insert(leftextras)

        local rightextras = widget.newButton
            {
            x = 1700,
            y = 650,
            shape = "polygon",
            vertices = {1800,650, 1700,550, 1700,750},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = nextExtra
        }
        sceneGroup:insert(rightextras)
		
		local buy_extra = widget.newButton
		{
			x = 1400,
			y = 860,
			width = 200,
			height = 100,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Buy",
			onEvent = buyExtra,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize=40,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
		}
		sceneGroup:insert(buy_extra)
		
		
		special_pic = display.newImage("Images/key.png",system.ResourceDirectory)
		special_pic.anchorX = 0.5
		special_pic.anchorY = 0.5
		special_pic.height = 200
		special_pic.width = 200
		special_pic.x = 550
		special_pic.y = 550
		
		sceneGroup:insert(special_pic)
		
		extra_pic = display.newImage("Images/robot_santa.png",system.ResourceDirectory)
		extra_pic.anchorX = 0.5
		extra_pic.anchorY = 0.5
		extra_pic.height = 200
		extra_pic.width = 200
		extra_pic.x = 1400
		extra_pic.y = 550
		sceneGroup:insert(extra_pic)
		
		
		extra_title = display.newText("Robot Santa", 1400, 700)
		sceneGroup:insert(extra_title)
		
		extra_cost = display.newText("Cost: 100", 1400,775)
		sceneGroup:insert(extra_cost)

        mx = 0
        scores = {}
        rankbox = {}
        userbox = {}
        scorebox = {}
        tempuser = nil
        ranknum = {}
        userranked = {}
        rankscore = {}
        App42CallBack = {}
        myData.leader = 0
		
		extra_counter = 1
		
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        

		
		audio.resume(backgroundMusicplay)
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
    	display.remove( homebutton)
		homebutton=nil
		extra_pic:removeSelf()
		extra_title:removeSelf()
		extra_cost:removeSelf()
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