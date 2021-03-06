local myData = require( "mydata" )
local composer = require( "composer" )
local JSON = require ("json")
local loadsave = require( "loadsave" ) 
local scene = composer.newScene()

local secondsLeft
local clockText
local countDownTimer

local JSON = require("App42-Lua-API.JSON") 
local App42API = require("App42-Lua-API.App42API")
local userName = myData.user
local gameScore = nil
local dbName = "USERS"  
local jsonDoc = {}  
jsonDoc.name =  myData.user
jsonDoc.level = nil 
local App42CallBack = {}

App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
local storageService = App42API:buildStorageService()  

local scoreKey
local jdocKey
require("App42-Lua-API.Operator")
require("App42-Lua-API.Permission")
require("App42-Lua-API.GeoOperator")
require("App42-Lua-API.OrderByType")
require("App42-Lua-API.Operator")
local queryBuilder = require("App42-Lua-API.QueryBuilder")
local ACL = require("App42-Lua-API.ACL")

local newmax
local oldscore
local globalscore



-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function setupPic(name, pic, xVal, yVal, hVal,wVal)

    setupItems[name] = display.newImage(pic)
    setupItems[name].anchorX = 0
    setupItems[name].anchorY =0
    setupItems[name].x = xVal
    setupItems[name].y = yVal
    setupItems[name].height = hVal
    setupItems[name].width= wVal

end


local function setupmap()
    i=1
    while(myData.bonusSearchLvlOne[i] ~= nil and myData.bonusSearchLvlOne[i] ~= 0) do
        currBlock = myData.bonusSearchLvlOne[i]
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
    while(myData.bonusSearchLvlTwo[i] ~= nil and myData.bonusSearchLvlTwo[i] ~= 0) do
        currBlock = myData.bonusSearchLvlTwo[i]
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
    while(myData.bonusSearchLvlThree[i] ~= nil and myData.bonusSearchLvlThree[i] ~= 0) do
        currBlock = myData.bonusSearchLvlThree[i]
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
    end
end

local function removelast( event )
    undosearch = undosearch + 1

    if(countmax > answer)then
        display.remove(newblock[countmax-1])
        countmax = countmax - 1
        spotx = 631 + countmax*130
    end
end

local function gohome( event )
    homesearch = homesearch + 1

    audio.stop(searchMusicplay)
    audio.dispose( searchMusic )
    local options = {
        isModal = true,
        effect = "crossFade",
        time = 500
    }
    for i=8,0,-1 do 
        display.remove(newblock[i]) 
    end
    answer = 0
    spotx = 631
    countmax = 0
    composer.gotoScene("MainMenu",options)
end

local function tryagain()
    countmax=answer
    spotx = 631 + answer*130
    for i=8,answer,-1 do 
        display.remove(newblock[i]) 
    end  
end

local function addTokens()
    local dbName  = "USERS"
    local collectionName = "GameInfo"
    local key = "user"
    local value = myData.user
    local jsonDoc = {}

    jsonDoc.user = myData.user
    jsonDoc.search = myData.maxsrch
    jsonDoc.rescue = myData.maxrsc
    jsonDoc.theme = myData.theme
    jsonDoc.volume = myData.musicVol
    local tokens = myData.currScore / 100
    myData.credits = myData.credits + tokens
    jsonDoc.credits = myData.credits
    jsonDoc.sfx = myData.sfx
    jsonDoc.robot = myData.roboSprite
    jsonDoc.scientist = myData.scienceSprite
    jsonDoc.keys = myData.savedkeys
    jsonDoc.stopwatch = myData.savedclocks

    local App42CallBack = {}
    storageService:saveOrupdateDocumentByKeyValue(dbName,collectionName,key,value,jsonDoc,App42CallBack)
    function App42CallBack:onSuccess(object)
        for i=1,table.getn(object:getJsonDocList()) do
        end
    end
    function App42CallBack:onException(exception)
    end
end

local function updateCount()
    local dbName  = "USERS"
    local collectionName = "Bonus Levels"
    local key = "level"
    local value = myData.bonusTitle
    local jsonDoc = {}

    jsonDoc.user = myData.bonusUser
    jsonDoc.level = myData.bonusTitle
    jsonDoc.type = "Search"
    jsonDoc.key = myData.bonusSearchLvlKey
    jsonDoc.keyoneone = myData.bonusSearchLvlOne[1]
    jsonDoc.keyonetwo = myData.bonusSearchLvlOne[2]
    jsonDoc.keyonethree = myData.bonusSearchLvlOne[3]
    jsonDoc.keyonefour = myData.bonusSearchLvlOne[4]
    jsonDoc.keyonefive = myData.bonusSearchLvlOne[5]
    jsonDoc.keytwoone = myData.bonusSearchLvlTwo[1]
    jsonDoc.keytwotwo = myData.bonusSearchLvlTwo[2]
    jsonDoc.keytwothree = myData.bonusSearchLvlTwo[3]
    jsonDoc.keytwofour = myData.bonusSearchLvlTwo[4]
    jsonDoc.keytwofive = myData.bonusSearchLvlTwo[5]
    jsonDoc.keythreeone = myData.bonusSearchLvlThree[1]
    jsonDoc.keythreetwo = myData.bonusSearchLvlThree[2]
    jsonDoc.keythreethree = myData.bonusSearchLvlThree[3]
    jsonDoc.keythreefour = myData.bonusSearchLvlThree[4]
    jsonDoc.keythreefive = myData.bonusSearchLvlThree[5]
    jsonDoc.playcount = myData.bonusCount + 1

    App42CallBack = {}
    storageService:saveOrupdateDocumentByKeyValue(dbName,collectionName,key,value,jsonDoc,App42CallBack)
    function App42CallBack:onSuccess(object)
        for i=1,table.getn(object:getJsonDocList()) do
        end
    end
    function App42CallBack:onException(exception)
    end
end


local function checkresult( event )
    runsearch = runsearch + 1
    


    while answer<5 do
        if(spacecolor[answer] == answerkey[answer+1])then
            answer = answer + 1
        else
            timer.pause(countDownTimer)
    		local options = {
    			isModal = true }
            composer.showOverlay( "fail_search", options )
    		tryagain()
            answer = 10
        end

    end

    if(answer < 10)then
        audio.pause(searchMusicplay)
        local options = {
            effect = "crossFade",
            time = 500
        }
        for i=8,0,-1 do 
            display.remove(newblock[i]) 
        end

        answer = 0
        spotx = 631
        spoty = 230
        countmax = 0

        myData.currScore = secondsLeft * 10
        addTokens()
        myData.currTokens = myData.currScore / 100
        local attribute = "Search"..currLvl
    	composer.showOverlay("pass_bonus_search", options)
        updateCount()
        timer.pause(countDownTimer)
        gameScore = secondsLeft * 10
        
    else
        answer = countmax
    end
    
end

local function getKey()
    answerkey = myData.bonusSearchLvlKey
end

local function updateTime(event)
    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1

    -- time is tracked in seconds.  We need to convert it to minutes and seconds
    local minutes = math.floor( secondsLeft / 60 )
    local seconds = secondsLeft % 60

    -- make it a string using string format.  
    local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
    if(clockText == nil) then
        timer.cancel( event.source )
    else
        clockText.text = timeDisplay
    end

end


-- Custom function for resuming the game (from pause state)
function scene:resumeGame()
    --code to resume game
    secondsLeft = secondsLeft - 9
    timer.resume(countDownTimer)
end


-- "scene:create()"
function scene:create( event )

    currLvl = myData.bonusSearchLvl

    mapmain = {}
    mapone = {}
    maptwo = {}
    answerkey = {}

    local sceneGroup = self.view
    searchMusic = audio.loadStream( "Music/bensound-slowmotion.mp3")
    searchMusicplay = audio.play( searchMusic, {  channel = 1, fadein = 4000, loops=-1 } )


    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

    local background = display.newImage("Images/theme_"..myData.theme.."/search_background.png")
        background.anchorX=0.5
        background.anchorY=0.5
        background.height=1080
        background.width=1920
        background.x= display.contentCenterX
        background.y=display.contentCenterY
        sceneGroup:insert(background)
        

    getKey()


    setupmap()
    newblock = {}
    spacecolor = {}
    answer = 0
    undosearch = 0
    homesearch = 0
    runsearch = 0
    

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
    runbutton:addEventListener("tap",checkresult)
    spotx = 631
    spoty = 230
    countmax = 0
end


-- "scene:show()"
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase


    currLvl = myData.bonusSearchLvl

    if ( phase == "will" ) then

        getKey()

        if(mapmain[1] == nil) then
            undosearch = 0
            homesearch = 0
            runsearch = 0
            searchMusic = audio.loadStream( "Music/bensound-slowmotion.mp3")
            searchMusicplay = audio.play( searchMusic, {  channel = 1, fadein = 4000, loops=-1 } )

            i=1
            while(myData.bonusSearchLvlOne[i] ~= nil and myData.bonusSearchLvlOne[i] ~= 0) do
                currBlock = myData.bonusSearchLvlOne[i]
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
            while(myData.bonusSearchLvlTwo[i] ~= nil and myData.bonusSearchLvlTwo[i] ~= 0) do
                currBlock = myData.bonusSearchLvlTwo[i]
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
            while(myData.bonusSearchLvlThree[i] ~= nil and myData.bonusSearchLvlThree[i] ~= 0) do
                currBlock = myData.bonusSearchLvlThree[i]
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
        end

        --time: minutes * seconds
        secondsLeft = 2 * 60 

        clockText = display.newText("2:00", display.contentCenterX, 80, native.systemFontBold, 80)
        clockText:setFillColor( 1, 1, 1 )
        sceneGroup:insert(clockText)
        -- run them timer
        countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
                
    elseif ( phase == "did" ) then

        
    end
end



-- "scene:hide()"
function scene:hide( event )

local sceneGroup = self.view
local phase = event.phase

    if ( phase == "will" ) then

        for i=8,0,-1 do 
            display.remove(newblock[i]) 
        end

        i=1
        while(mapmain[i] ~= nil) do
            display.remove(mapmain[i])
            mapmain[i] = nil
            i = i + 1
        end

        i = 1
        while(mapone[i] ~= nil) do
            display.remove(mapone[i])
            mapone[i] = nil
            i = i + 1
        end

        i = 1
        while(maptwo[i] ~= nil) do
            display.remove(maptwo[i])
            maptwo[i] = nil
            i = i + 1
        end

        i = 1
        currLvl = nil

        display.remove(clockText)
        countDownTimer = nil
        clockText = nil

        answerkey = {}
        newblock = {}
        spacecolor = {}
        answer = 0
        undosearch = 0
        homesearch = 0
        runsearch = 0


    elseif ( phase == "did" ) then 
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