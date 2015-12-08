local myData = require( "mydata" )
local composer = require( "composer" )
local JSON = require ("json")
local loadsave = require( "loadsave" ) 
local scene = composer.newScene()

-- timer variables
local secondsLeft
local clockText
local countDownTimer

local clock_text


local JSON = require("App42-Lua-API.JSON") 
local App42API = require("App42-Lua-API.App42API")
local gameName = "For The Future"
local userName = myData.user
local gameScore = nil
local dbName = "USERS"  
local collectionName = "Scores"   
local jsonDoc = {}  
jsonDoc.name =  myData.user
jsonDoc.level = nil 
local App42CallBack = {}
App42API:setDbName(dbName)

App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
local scoreBoardService = App42API.buildScoreBoardService() 

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

local setupItems = {}

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

local function setupArray(array, num, pic, xVal, yVal, hVal,wVal)
    array[num] = display.newImage(pic)
    array[num].anchorX = 0
    array[num].anchorY =0
    array[num].x = xVal
    array[num].y = yVal
    array[num].height = hVal
    array[num].width= wVal
end


local function setupmap()
    i=1
    while(myData.searchkey[currLvl].one[i] ~= nil) do
        currBlock = myData.searchkey[currLvl].one[i]
        setupArray(mapmain, i, "Images/"..currBlock.."_block.png", 352+(i-1)*142, 595, 120, 120)
        i = i + 1
    end
    i=1
    while(myData.searchkey[currLvl].two[i] ~= nil) do
        currBlock = myData.searchkey[currLvl].two[i]
        setupArray(mapone, i, "Images/"..currBlock.."_block.png", 352+(i-1)*142, 750, 120, 120)
        i = i + 1
    end
    i=1
    while(myData.searchkey[currLvl].three[i] ~= nil) do
        currBlock = myData.searchkey[currLvl].three[i]
        setupArray(maptwo, i, "Images/"..currBlock.."_block.png", 352+(i-1)*142, 903, 120, 120)
        i = i + 1
    end

    --red_block
    setupPic("blockred", myData.blockred[5], myData.blockred[1], myData.blockred[2], myData.blockred[3], myData.blockred[4])
    setupItems["blockred"].name = myData.blockred[6]
    --green_block
    setupPic("blockgreen", myData.blockgreen[5], myData.blockgreen[1], myData.blockgreen[2], myData.blockgreen[3], myData.blockgreen[4])
    setupItems["blockgreen"].name = myData.blockgreen[6]
    --blue_block
    setupPic("blockblue", myData.blockblue[5], myData.blockblue[1], myData.blockblue[2], myData.blockblue[3], myData.blockblue[4])
    setupItems["blockblue"].name = myData.blockblue[6]
    --yellow_block
    setupPic("blockyellow", myData.blockyellow[5], myData.blockyellow[1], myData.blockyellow[2], myData.blockyellow[3], myData.blockyellow[4])
    setupItems["blockyellow"].name = myData.blockyellow[6]
    
    --run_button
    setupPic("runbutton", myData.searchRun[5], myData.searchRun[1], myData.searchRun[2], myData.searchRun[3], myData.searchRun[4])
    --delete_button
    setupPic("deletebutton", myData.searchDelete[5], myData.searchDelete[1], myData.searchDelete[2], myData.searchDelete[3], myData.searchDelete[4])
    --home_button
    setupPic("homebutton", myData.searchHome[5], myData.searchHome[1], myData.searchHome[2], myData.searchHome[3], myData.searchHome[4])

    setupPic("clockpowerup", myData.searchClock[5], myData.searchClock[1], myData.searchClock[2], myData.searchClock[3], myData.searchClock[4])
end 

local function addcolour( event )
    if (countmax < 8) then
        setupArray(newblock, countmax, "Images/"..event.target.name.."_block.png", spotx, spoty, 120, 120)
        spacecolor[countmax] = event.target.name
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

    App42CallBack = {}
    storageService:saveOrupdateDocumentByKeyValue(dbName,collectionName,key,value,jsonDoc,App42CallBack)
    function App42CallBack:onSuccess(object)
        print("dbName is "..object:getDbName())
        for i=1,table.getn(object:getJsonDocList()) do
            print("Succesful connection")
        end
    end
    function App42CallBack:onException(exception)
        print("Message is : "..exception:getMessage())
    end
end


local function checkresult( event )
    runsearch = runsearch + 1

    while answer<5 do
        print(answer)
        if(spacecolor[answer] == answerkey[answer+1])then
            answer = answer + 1
        else
            timer.pause(countDownTimer)
            print(secondsLeft)
    		local options = {
    			isModal = true }
            composer.showOverlay( "fail_search", options )
			myData.error1_count = myData.error1_count + 1
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
    	composer.showOverlay("pass_search", options)
		myData.error1_count = 0
        timer.pause(countDownTimer)
        print("Finished with "..secondsLeft.." seconds left")
        gameScore = secondsLeft * 10
        print("Score: "..gameScore)
        

        if(gameScore >= oldscore) then
            --update score
            local scoreId = scoreKey
            gameScore = secondsLeft * 10
            newmax = gameScore - oldscore
            App42CallBack = {}
            scoreBoardService:editScoreValueById(scoreId,gameScore,App42CallBack)
            function App42CallBack:onSuccess(object)
                print("userName is : "..object:getScoreList():getUserName())
                print("score is : "..object:getScoreList():getValue())
            end
            function App42CallBack:onException(exception)
                print("Error!")
            end
            --update score json
            local docId = jdocKey
            local jsonDoc = {}
            jsonDoc.name = myData.user
            jsonDoc.level = "Search"..currLvl
            jsonDoc.score = gameScore
            jsonDoc["_$scoreId"] = scoreKey
            App42CallBack = {}
            storageService:updateDocumentByDocId(dbName,collectionName,docId,jsonDoc,App42CallBack)
            function App42CallBack:onSuccess(object)
                for i=1,table.getn(object:getJsonDocList()) do
                    print("DocId is "..object:getJsonDocList()[i]:getDocId())
                end
            end
            function App42CallBack:onException(exception)
                print("Error!")
            end

            -- update max score
            local gameName = "Max Scores"
            local upscore = newmax + globalscore
            App42CallBack = {}
            scoreBoardService:getLastScoreByUser(gameName,userName,App42CallBack)
            function App42CallBack:onSuccess(object)
                print("userName is : "..object:getScoreList():getUserName())
                print("score is : "..object:getScoreList():getValue())
                print("scoreId is : "..object:getScoreList():getScoreId())
                local scoreId = object:getScoreList():getScoreId()
                local gameScore = newmax + globalscore
                App42CallBack = {}
                scoreBoardService:editScoreValueById(scoreId,gameScore,App42CallBack)
                function App42CallBack:onSuccess(object)
                    print("success")
                end
                function App42CallBack:onException(exception)
                    print("Message is : "..exception:getMessage())
                    print("Detail is : "..exception:getDetails())
                end
            end
            function App42CallBack:onException(exception)
                print("Message is : "..exception:getMessage())
                print("Detail is : "..exception:getDetails())
            end

        end

        myData.searchLvl = currLvl + 1
        myData.rescueLvl = currLvl

        local userSettings = {
            user = myData.user,
            search = myData.searchLvl,
            rescue = myData.rescueLvl,
            theme = myData.theme,
            volume = myData.musicVol,
            sfx = myData.sfx,
            robot = myData.roboSprite,
            science = myData.scienceSprite,
            keys = myData.savedkeys,
            stopwatch = myData.savedclocks }
        loadsave.saveTable( userSettings, "user.json" )
        print("Current level: "..myData.searchLvl)
    else
        answer = countmax
    end
    
end

local function getKey()
    answerkey = myData.searchAnswerkey[currLvl]
end

local function updateTime(event)
    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1
    print("Seconds left: "..secondsLeft)
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

    if(secondsLeft == 0) then
        timer.pause(countDownTimer)
        local options = {
            isModal = true }
        composer.showOverlay( "fail_time_search", options )
    end

end

local function updateClocks(event)
    local clocksDisplay = myData.savedclocks
    clock_num.text = clocksDisplay
end
local function useclock()
    myData.savedclocks = myData.savedclocks - 1
    clockscount = clockscount + 1
    hasClock = true
    print("clockscount is "..clockscount)
    updateClocks()
    if(myData.savedclocks == 0) then
        setupItems["clockpowerup"]:removeEventListener("tap", useclock)
    end
    secondsLeft = secondsLeft + 11
    updateTime()
end

local function getScoreDoc()
    local key = "name"
    local value = myData.user
    local collectionName = "Scores"
    local key1 = "level"
    local varname = "_$scoreId"
    local value1 = "Search"..currLvl
    print("curr level "..currLvl)
    local q1 = queryBuilder:build(key, value, Operator.EQUALS)   
    local q2 = queryBuilder:build(key1, value1, Operator.EQUALS)      
    local query = queryBuilder:compoundOperator(q1,Operator.AND, q2)
    App42CallBack = {}
    storageService = App42API:buildStorageService()
    storageService:findDocumentsByQuery(dbName, collectionName,query,App42CallBack)
    function App42CallBack:onSuccess(object)
            for i=1,table.getn(object:getJsonDocList()) do
                scoreKey = object:getJsonDocList()[i]:getJsonDoc()["_$scoreId"]
                jdocKey = object:getJsonDocList()[i]:getDocId()
                oldscore = object:getJsonDocList()[i]:getJsonDoc().score
                print("DocId is "..object:getJsonDocList()[i]:getDocId())
                print("Level is "..object:getJsonDocList()[i]:getJsonDoc().level)
                print("ScoreId is "..object:getJsonDocList()[i]:getJsonDoc()["_$scoreId"])
            end
    end
    function App42CallBack:onException(exception)
        print("Message is : "..exception:getMessage())
        print("Detail is : "..exception:getDetails())
    end

    local gameName = "Max Scores"
    App42CallBack = {}
    scoreBoardService:getLastScoreByUser(gameName,userName,App42CallBack)
    function App42CallBack:onSuccess(object)
        print("Game name is "..object:getName())
        print("userName is : "..object:getScoreList():getUserName())
        print("score is : "..object:getScoreList():getValue())
        globalscore = object:getScoreList():getValue()
        print("scoreId is : "..object:getScoreList():getScoreId())
    end
    function App42CallBack:onException(exception)
        print("Message is : "..exception:getMessage())
        print("Detail is : "..exception:getDetails())
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

    currLvl = myData.searchLvl
    myData.rescue = 0

    mapmain = {}
    mapone = {}
    maptwo = {}

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
    clockscount = 0

    clock_text = display.newText("x", 185, 79)
    sceneGroup:insert(clock_text)
    clock_num = display.newText(myData.savedclocks, 235, 79)
    sceneGroup:insert(clock_num)
    

    sceneGroup:insert(setupItems["blockred"])
    sceneGroup:insert(setupItems["blockgreen"])
    sceneGroup:insert(setupItems["blockblue"])
    sceneGroup:insert(setupItems["blockyellow"])
    sceneGroup:insert(setupItems["runbutton"])
    sceneGroup:insert(setupItems["deletebutton"])
    sceneGroup:insert(setupItems["homebutton"])
    sceneGroup:insert(setupItems["clockpowerup"])
    

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


    setupItems["blockred"]:addEventListener( "tap", addcolour )
    setupItems["blockgreen"]:addEventListener( "tap", addcolour )
    setupItems["blockblue"]:addEventListener( "tap", addcolour )
    setupItems["blockyellow"]:addEventListener( "tap", addcolour )
    setupItems["deletebutton"]:addEventListener("tap",removelast)
    setupItems["homebutton"]:addEventListener("tap",gohome)
    setupItems["runbutton"]:addEventListener("tap",checkresult)

    if(myData.savedclocks > 0) then
        setupItems["clockpowerup"]:addEventListener("tap", useclock)
    end

    spotx = 631
    spoty = 230
    countmax = 0
end


-- "scene:show()"
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase


    currLvl = myData.searchLvl

    if ( phase == "will" ) then
        print(" ")
        print("start Search")
        myData.rescue = 0

        getKey()

        print("This level: "..currLvl)
        if(mapmain[1] == nil) then
            undosearch = 0
            homesearch = 0
            runsearch = 0
            searchMusic = audio.loadStream( "Music/bensound-slowmotion.mp3")
            searchMusicplay = audio.play( searchMusic, {  channel = 1, fadein = 4000, loops=-1 } )

            i=1
            while(myData.searchkey[currLvl].one[i] ~= nil) do
                currBlock = myData.searchkey[currLvl].one[i]
                setupArray(mapmain, i, "Images/"..currBlock.."_block.png", 352+(i-1)*142, 595, 120, 120)
                i = i + 1
            end

            i=1
            while(myData.searchkey[currLvl].two[i] ~= nil) do
                currBlock = myData.searchkey[currLvl].two[i]
                setupArray(mapone, i, "Images/"..currBlock.."_block.png", 352+(i-1)*142, 750, 120, 120)
                i = i + 1
            end

            i=1
            while(myData.searchkey[currLvl].three[i] ~= nil) do
                currBlock = myData.searchkey[currLvl].three[i]
                setupArray(maptwo, i, "Images/"..currBlock.."_block.png", 352+(i-1)*142, 903, 120, 120)
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
        
        getScoreDoc()
        
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
        currLvl = nil

        display.remove(clockText)
        countDownTimer = nil
        clockText = nil

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