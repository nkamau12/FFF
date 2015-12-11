local parse = require( "mod_parse" )
local myData = require( "mydata" )
local composer = require( "composer" )
local JSON = require ("json")
local widget = require( "widget" )
local scene = composer.newScene()

require("App42-Lua-API.Operator")
require("App42-Lua-API.Permission")
require("App42-Lua-API.GeoOperator")
require("App42-Lua-API.OrderByType")
require("App42-Lua-API.Operator")
local JSON = require("App42-Lua-API.JSON") 
local queryBuilder = require("App42-Lua-API.QueryBuilder")
local App42API = require("App42-Lua-API.App42API")
local ACL = require("App42-Lua-API.ACL")

App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")

local storageService = App42API:buildStorageService()  


local special_pic
local extra_pic
local extra_title
local extra_cost

local extra_counter = 1
local special_counter = 1

local buyable = {}

local homebutton
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
	myData.purchase = myData.buyable[extra_counter]
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		print(myData.buyable[extra_counter])
		local options = {
			isModal = true
		}
		
		composer.showOverlay( "ConfirmStoreBuy", options )
	end
end

local function buySpecial(event)
	myData.purchase = myData.buyPowerUps[special_counter]
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		print(myData.buyPowerUps[special_counter])
		local options = {
			isModal = true
		}
		
		composer.showOverlay( "ConfirmStoreBuy", options )
	end
end


local function prevSpecial( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		
		if(myData.buyPowerUps[special_counter - 1] == nil) then
			special_counter = table.maxn(myData.buyPowerUps)
		else
			special_counter = special_counter - 1
		end
		if(special_pic ~= nil)then
			display.remove(special_pic)
		end
		if(special_title ~= nil)then
			display.remove(special_title)
		end
		if(special_cost ~= nil)then
			display.remove(special_cost)
		end
		special_title = display.newText(myData.buyPowerUps[special_counter][2], 550, 700)
		special_cost = display.newText("Cost: "..myData.buyPowerUps[special_counter][4], 550,775)
		special_pic = display.newImage(myData.buyPowerUps[special_counter][3],system.ResourceDirectory)
		special_pic.x = 550
		special_pic.y = 550
		special_pic.height = 200
		special_pic.width = 200
	end
end

local function nextSpecial( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		if(myData.buyPowerUps[special_counter + 1] == nil) then
			special_counter = 1
		else
			special_counter = special_counter + 1
		end
		print("Special counter is "..special_counter)
		if(special_pic ~= nil)then
			display.remove(special_pic)
		end
		if(special_title ~= nil)then
			display.remove(special_title)
		end
		if(special_cost ~= nil)then
			display.remove(special_cost)
		end
		special_title = display.newText(myData.buyPowerUps[special_counter][2], 550, 700)
		special_cost = display.newText("Cost: "..myData.buyPowerUps[special_counter][4], 550,775)
		special_pic = display.newImage(myData.buyPowerUps[special_counter][3],system.ResourceDirectory)
		special_pic.x = 550
		special_pic.y = 550
		if(myData.buyPowerUps[special_counter][1] == "theme")then
			special_pic.height = 200
			special_pic.width = 350
		else
			special_pic.height = 200
			special_pic.width = 200
		end
	end
end

local function prevExtra( event )
	if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
		
		if(myData.buyable[extra_counter - 1] == nil) then
			extra_counter = table.maxn(myData.buyable)
		else
			extra_counter = extra_counter - 1
		end
		if(extra_pic ~= nil)then
			extra_pic:removeSelf()
		end
		if(extra_title ~= nil)then
			extra_title:removeSelf()
		end
		if(extra_cost ~= nil)then
			extra_cost:removeSelf()
		end
		extra_title = display.newText(myData.buyable[extra_counter][2], 1400, 700)
		extra_cost = display.newText("Cost: "..myData.buyable[extra_counter][4], 1400,775)
		extra_pic = display.newImage(myData.buyable[extra_counter][3],system.ResourceDirectory)
		extra_pic.x = 1385
		extra_pic.y = 550
		if(myData.buyable[extra_counter][1] == "theme")then
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
		if(myData.buyable[extra_counter + 1] == nil) then
			extra_counter = 1
		else
			extra_counter = extra_counter + 1
		end
		print("Extra counter is "..extra_counter)
		if(extra_pic ~= nil)then
			extra_pic:removeSelf()
		end
		if(extra_title ~= nil)then
			extra_title:removeSelf()
		end
		if(extra_cost ~= nil)then
			extra_cost:removeSelf()
		end
		extra_title = display.newText(myData.buyable[extra_counter][2], 1400, 700)
		extra_cost = display.newText("Cost: "..myData.buyable[extra_counter][4], 1400,775)
		extra_pic = display.newImage(myData.buyable[extra_counter][3],system.ResourceDirectory)
		extra_pic.x = 1385
		extra_pic.y = 550
		if(myData.buyable[extra_counter][1] == "theme")then
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
end


-- "scene:show()"
function scene:show( event )
	
    local sceneGroup = self.view
    local phase = event.phase
	
    if ( phase == "will" ) then
    	print(" ")
        print("start Store")

        myData.purchase = {}
        extra_counter = 1

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


        local leftspecials = widget.newButton{
            x = 240,
            y = 650,
            shape = "polygon",
            vertices = {240,650, 340,550, 340,750},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = prevSpecial
        }
        sceneGroup:insert(leftspecials)
        
        local rightspecials = widget.newButton{
            x = 850,
            y = 650,
            shape = "polygon",
            vertices = {950,650, 850,550, 850,750},
            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
            onEvent = nextSpecial
        }
        sceneGroup:insert(rightspecials)
		
		special_pic = display.newImage(myData.buyPowerUps[special_counter][3],system.ResourceDirectory)
		special_pic.height = 200
		special_pic.width = 200
		special_pic.x = 550
		special_pic.y = 550
		sceneGroup:insert(special_pic)

		local buy_special = widget.newButton{
			x = 550,
			y = 860,
			width = 200,
			height = 100,
			defaultFile = "buttonDefault.png",
			overFile = "buttonOver.png",
			label = "Buy",
			onEvent = buySpecial,
			labelColor = { default={255,255,255}, over={255,255,255} },
			fontSize=40,
			fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
			shape="roundedRect"
		}
		sceneGroup:insert(buy_special)

		special_title = display.newText(myData.buyPowerUps[special_counter][2], 550, 700)
		sceneGroup:insert(special_title)
		
		special_cost = display.newText("Cost: "..myData.buyPowerUps[special_counter][4], 550,775)
		sceneGroup:insert(special_cost)






        if(table.maxn(myData.buyable) >0) then
	        local leftextras = widget.newButton{
	            x = 1070,
	            y = 650,
	            shape = "polygon",
	            vertices = {1070,650, 1170,550, 1170,750},
	            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
	            onEvent = prevExtra
	        }
	        sceneGroup:insert(leftextras)
	    end

        if(table.maxn(myData.buyable) >0) then
	        local rightextras = widget.newButton{
	            x = 1700,
	            y = 650,
	            shape = "polygon",
	            vertices = {1800,650, 1700,550, 1700,750},
	            fillColor = { default={ 0, 104/255, 139/255 }, over={ 1, 0.2, 0.5, 1 } },
	            onEvent = nextExtra
	        }
	        sceneGroup:insert(rightextras)
    	end
		

		if(myData.buyable[1] ~= nil) then
			local buy_extra = widget.newButton{
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

			extra_pic = display.newImage(myData.buyable[extra_counter][3],system.ResourceDirectory)
			extra_pic.height = 200
			extra_pic.width = 200
			extra_pic.x = 1400
			extra_pic.y = 550
			if(myData.buyable[extra_counter][1] == "theme")then
				extra_pic.height = 200
				extra_pic.width = 350
			end
			sceneGroup:insert(extra_pic)
			
			extra_title = display.newText(myData.buyable[extra_counter][2], 1400, 700)
			sceneGroup:insert(extra_title)
			
			extra_cost = display.newText("Cost: "..myData.buyable[extra_counter][4], 1400,775)
			sceneGroup:insert(extra_cost)
		end

		extra_counter = 1
		
    elseif ( phase == "did" ) then
		audio.resume(backgroundMusicplay)
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then


    	homebutton:removeEventListener( "tap", gohome )
        
		if(extra_pic ~= nil)then
			extra_pic:removeSelf()
		end
		if(extra_title ~= nil)then
			extra_title:removeSelf()
		end
		if(extra_cost ~= nil)then
			extra_cost:removeSelf()
		end
		if(special_pic ~= nil)then
			display.remove(special_pic)
		end
		if(special_title ~= nil)then
			display.remove(special_title)
		end
		if(special_cost ~= nil)then
			display.remove(special_cost)
		end
    elseif ( phase == "did" ) then
    	
    end
end


-- "scene:destroy()"
function scene:destroy( event )
    local sceneGroup = self.view
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene