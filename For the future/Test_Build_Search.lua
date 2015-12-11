local myData = require( "mydata" )
local composer = require( "composer" )
local scene = composer.newScene()
local JSON = require ("json")
local loadsave = require( "loadsave" ) 
local App42API = require("App42-Lua-API.App42API") 
App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
require("App42-Lua-API.Operator")
require("App42-Lua-API.Permission")
require("App42-Lua-API.GeoOperator")
require("App42-Lua-API.OrderByType")
require("App42-Lua-API.Operator")
local JSON = require("App42-Lua-API.JSON") 
local queryBuilder = require("App42-Lua-API.QueryBuilder")
local ACL = require("App42-Lua-API.ACL")
local storageService = App42API:buildStorageService()  

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function setupmap()

        --level_map
		i=1
        while(myData.bonusShow.one[i] ~= nil and myData.bonusShow.one[i] ~= 0) do
            currBlock = myData.bonusShow.one[i]
            mapmain[i] = display.newImage("Images/"..currBlock.."_block.png")
            mapmain[i].anchorX=0
            mapmain[i].anchorY=0
            mapmain[i].x=352 + (i-1)*142
            mapmain[i].y=595
            mapmain[i].height=120
            mapmain[i].width=120
            i = i + 1
        end
        i=1
        while(myData.bonusShow.two[i] ~= nil and myData.bonusShow.two[i] ~= 0) do
            currBlock = myData.bonusShow.two[i]
            mapone[i] = display.newImage("Images/"..currBlock.."_block.png")
            mapone[i].anchorX=0
            mapone[i].anchorY=0
            mapone[i].x=352 + (i-1)*142
            mapone[i].y=750
            mapone[i].height=120
            mapone[i].width=120
            i = i + 1
        end
        i=1
        while(myData.bonusShow.three[i] ~= nil and myData.bonusShow.three[i] ~= 0) do
            currBlock = myData.bonusShow.three[i]
            maptwo[i] = display.newImage("Images/"..currBlock.."_block.png")
            maptwo[i].anchorX=0
            maptwo[i].anchorY=0
            maptwo[i].x=352 + (i-1)*142
            maptwo[i].y=903
            maptwo[i].height=120
            maptwo[i].width=120
            i = i + 1
        end
        i=1

        --red_block
        blockred = display.newImage("Images/red_block.png")
        blockred.anchorX=0
        blockred.anchorY=0
        blockred.x=1289
        blockred.y=729
        blockred.height=120
        blockred.width=120

        --green_block
        blockgreen = display.newImage("Images/green_block.png")
        blockgreen.anchorX=0
        blockgreen.anchorY=0
        blockgreen.x=1426
        blockgreen.y=729
        blockgreen.height=120
        blockgreen.width=120

        --blue_block
        blockblue = display.newImage("Images/blue_block.png")
        blockblue.anchorX=0
        blockblue.anchorY=0
        blockblue.x=1564
        blockblue.y=729
        blockblue.height=120
        blockblue.width=120
        
        --yellow_block
        blockyellow = display.newImage("Images/yellow_block.png")
        blockyellow.anchorX=0
        blockyellow.anchorY=0
        blockyellow.x=1700
        blockyellow.y=729
        blockyellow.height=120
        blockyellow.width=120
        
        --run_button
        runbutton = display.newImage("Images/run_button.png")
        runbutton.anchorX=0
        runbutton.anchorY=0
        runbutton.x=1450
        runbutton.y=887
        runbutton.height=120
        runbutton.width=360

        --delete_button
        deletebutton = display.newImage("Images/delete_button.png")
        deletebutton.anchorX=0
        deletebutton.anchorY=0
        deletebutton.x=1289
        deletebutton.y=887
        deletebutton.height=120
        deletebutton.width=120

        --home_button
        homebutton = display.newImage("Images/home.png")
        homebutton.anchorX=0
        homebutton.anchorY=0
        homebutton.x=1766
        homebutton.y=28
        homebutton.height=120
        homebutton.width=120
        
end 

local function addred( event )
    if (countmax < 8) then
        newblock[countmax] = display.newImage("Images/red_block.png")
        newblock[countmax].anchorX=0
        newblock[countmax].anchorY=0
        newblock[countmax].x= spotx
        newblock[countmax].y= spoty
        newblock[countmax].height=120
        newblock[countmax].width=120

        spacecolor[countmax] = "red"

        spotx = spotx + 130
        countmax = countmax + 1
    else
    end
end

local function addgreen( event )
    if (countmax < 8) then
        newblock[countmax] = display.newImage("Images/green_block.png")
        newblock[countmax].anchorX=0
        newblock[countmax].anchorY=0
        newblock[countmax].x= spotx
        newblock[countmax].y= spoty
        newblock[countmax].height=120
        newblock[countmax].width=120

        spacecolor[countmax] = "green"

        spotx = spotx + 130
        countmax = countmax + 1
    else
    end
end

local function addblue( event )
    if (countmax < 8) then
        newblock[countmax] = display.newImage("Images/blue_block.png")
        newblock[countmax].anchorX=0
        newblock[countmax].anchorY=0
        newblock[countmax].x= spotx
        newblock[countmax].y= spoty
        newblock[countmax].height=120
        newblock[countmax].width=120

        spacecolor[countmax] = "blue"

        spotx = spotx + 130
        countmax = countmax + 1
    else
    end
end

local function addyellow( event )
    if (countmax < 8) then
        newblock[countmax] = display.newImage("Images/yellow_block.png")
        newblock[countmax].anchorX=0
        newblock[countmax].anchorY=0
        newblock[countmax].x= spotx
        newblock[countmax].y= spoty
        newblock[countmax].height=120
        newblock[countmax].width=120

        spacecolor[countmax] = "yellow"

        spotx = spotx + 130
        countmax = countmax + 1
    else
    end
end

local function removelast( event )	
    if(countmax > answer)then
        display.remove(newblock[countmax-1])
        countmax = countmax - 1
        spotx = 631 + countmax*130
    else
    end
end

local function gohome( event )
    
    local options = {
            effect = "crossFade",
            time = 500
    }
    for i=8,0,-1 
    do 
        display.remove(newblock[i]) 
    end
    composer.gotoScene("MainMenu",options)
end

local function tryagain()
    countmax=answer
    spotx = 631 + answer*130
    for i=8,answer,-1 
    do 
        display.remove(newblock[i]) 
    end
end



local function checkresult()
    while answer<5 do
        if(spacecolor[answer] == answerkey[answer+1])then
            answer = answer + 1
        else
			local options = 
			{
				isModal = true
			}
            composer.showOverlay( "fail_search", options )
			tryagain()
            answer = 10
        end
    end
    if(answer < 10)then
        local options = {
            isModal = true,
            effect = "crossFade",
            time = 500
        }
        for i=8,0,-1 
        do 
            display.remove(newblock[i]) 
        end
		answer = 0
        spotx = 631
        spoty = 230
        countmax = 0

        myData.newSearchkey = answerkey
        myData.newType = "Search"
		composer.showOverlay("save_game", options)
    else
        answer = countmax
    end
end

local function getKey()
	answerkey = myData.bonusKeyBuilt
end

local function checkLvl(event)
    if ( event.phase == "ended") then
        local dbName  = "USERS"
        local collectionName = "Bonus Levels"

        local key11 = "keyoneone"
        local value11 = myData.("value11 is "..value11)
        local key12 = "keyonetwo"
        local value12 = myData.bonusShow.one[2]
        local key13 = "keyonethree"
        local value13 = myData.bonusShow.one[3]
        local key14 = "keyonefour"
        local value14 = myData.bonusShow.one[4]
        local key15 = "keyonefive"
        local value15 = myData.bonusShow.one[5]

        local key21 = "keytwoone"
        local value21 = myData.bonusShow.two[1]
        local key22 = "keytwotwo"
        local value22 = myData.bonusShow.two[2]
        local key23 = "keytwothree"
        local value23 = myData.bonusShow.two[3]
        local key24 = "keytwofour"
        local value24 = myData.bonusShow.two[4]
        local key25 = "keytwofive"
        local value25 = myData.bonusShow.two[5]

        local key31 = "keythreeone"
        local value31 = myData.bonusShow.three[1]
        local key32 = "keythreetwo"
        local value32 = myData.bonusShow.three[2]
        local key33 = "keythreethree"
        local value33 = myData.bonusShow.three[3]
        local key34 = "keythreefour"
        local value34 = myData.bonusShow.three[4]
        local key35 = "keythreefive"
        local value35 = myData.bonusShow.three[5]

        
        local q11 = queryBuilder:build(key11, value11, Operator.EQUALS) 
        local q12 = queryBuilder:build(key12, value12, Operator.EQUALS) 
        local q13 = queryBuilder:build(key13, value13, Operator.EQUALS) 
        local q14 = queryBuilder:build(key14, value14, Operator.EQUALS) 
        local q15 = queryBuilder:build(key15, value15, Operator.EQUALS) 

        local q21 = queryBuilder:build(key21, value21, Operator.EQUALS) 
        local q22 = queryBuilder:build(key22, value22, Operator.EQUALS) 
        local q23 = queryBuilder:build(key23, value23, Operator.EQUALS) 
        local q24 = queryBuilder:build(key24, value24, Operator.EQUALS) 
        local q25 = queryBuilder:build(key25, value25, Operator.EQUALS) 

        local q31 = queryBuilder:build(key31, value31, Operator.EQUALS) 
        local q32 = queryBuilder:build(key32, value32, Operator.EQUALS) 
        local q33 = queryBuilder:build(key33, value33, Operator.EQUALS) 
        local q34 = queryBuilder:build(key34, value34, Operator.EQUALS) 
        local q35 = queryBuilder:build(key35, value35, Operator.EQUALS) 

        local query11 = queryBuilder:compoundOperator(q11,Operator.AND, q12)  
        local query12 = queryBuilder:compoundOperator(q13,Operator.AND, q14)
        local query13 = queryBuilder:compoundOperator(q15,Operator.AND, q21)
        local query14 = queryBuilder:compoundOperator(q22,Operator.AND, q23)
        local query15 = queryBuilder:compoundOperator(q24,Operator.AND, q25)
        local query16 = queryBuilder:compoundOperator(q31,Operator.AND, q32)
        local query17 = queryBuilder:compoundOperator(q33,Operator.AND, q34)

        local query21 = queryBuilder:compoundOperator(query11,Operator.AND, query12)
        local query22 = queryBuilder:compoundOperator(query13,Operator.AND, query14)
        local query23 = queryBuilder:compoundOperator(query15,Operator.AND, query16)
        local query24 = queryBuilder:compoundOperator(query17,Operator.AND, q35)

        local query31 = queryBuilder:compoundOperator(query21,Operator.AND, query22)
        local query32 = queryBuilder:compoundOperator(query23,Operator.AND, query24)

        local query41 = queryBuilder:compoundOperator(query31,Operator.AND, query32)


        local App42CallBack = {}
        storageService = App42API:buildStorageService()  
        storageService:findDocumentsByQuery(dbName, collectionName,query41,App42CallBack)  
        function App42CallBack:onSuccess(object)
                for i=1,table.getn(object:getJsonDocList()) do
                    local options = {
                        isModal = true,
                        effect = "crossFade",
                        time = 500
                    }
                    composer.showOverlay("repeated_key", options)
                end
        end
        function App42CallBack:onException(exception)
            local errorCode = exception:getAppErrorCode()

            if(errorCode == 2608) then
                checkresult()
            end
        end
    end
end

-- "scene:create()"
function scene:create( event )

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
	mapmain = {}
	mapone = {}
	maptwo = {}
	
	local sceneGroup = self.view
	
    local background = display.newImage("Images/theme_"..myData.theme.."/search_background.png")
        background.anchorX=0.5
        background.anchorY=0.5
        background.height=1080
        background.width=1920
        background.x= display.contentCenterX
        background.y=display.contentCenterY
        sceneGroup:insert(background)
        
        setupmap()
        newblock = {}
        spacecolor = {}
        answer = 0
        undosearch = 0
        homesearch = 0
        runsearch = 0

        getKey()

        sceneGroup:insert(blockred)
        sceneGroup:insert(blockgreen)
        sceneGroup:insert(blockblue)
        sceneGroup:insert(blockyellow)
        sceneGroup:insert(runbutton)
        sceneGroup:insert(deletebutton)
        sceneGroup:insert(homebutton)
		
		i=1
        while(mapmain[i] ~= nil) do
                sceneGroup:insert(mapmain[i])
                i = i + 1
        end
        i = 1
        while(mapone[i] ~= nil) do
                sceneGroup:insert(mapone[i])
                i = i + 1
        end
        i = 1
        while(maptwo[i] ~= nil) do
                sceneGroup:insert(maptwo[i])
                i = i + 1
        end
        i = 1


        blockred:addEventListener( "tap", addred )
        blockgreen:addEventListener( "tap", addgreen )
        blockblue:addEventListener( "tap", addblue )
        blockyellow:addEventListener( "tap", addyellow )
        deletebutton:addEventListener("tap",removelast)
        homebutton:addEventListener("tap",gohome)
        runbutton:addEventListener("touch",checkLvl)
        spotx = 631
        spoty = 230
        countmax = 0
end


-- "scene:show()"
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        
        
    elseif ( phase == "did" ) then
        getKey()
        
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
        for i=8,0,-1 
        do 
            display.remove(newblock[i]) 
        end

    elseif ( phase == "did" ) then
        

        display.remove( levelmap)
        levelmap=nil
        
        currLvl = nil

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