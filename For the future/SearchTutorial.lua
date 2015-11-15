local parse = require( "mod_parse" )
local myData = require( "mydata" )
local composer = require( "composer" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function setupmap()

        --level_map
        levelmap = display.newImage("Images/search"..currLvl..".png")
        levelmap.anchorX=0
        levelmap.anchorY=0
        levelmap.x=194
        levelmap.y=583
        levelmap.height=447
        levelmap.width=862

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
    undosearch = undosearch + 1

    local function onUndoSearch( event )
        if not event.error then
            print( event.response.updatedAt )
        end
    end
    local dataTable = {["Search"..currLvl] = undosearch }
    parse:updateObject("UndoCount", myData.undoid, dataTable, onUndoSearch)

    if(countmax > answer)then
        display.remove(newblock[countmax-1])
        countmax = countmax - 1
        spotx = 631 + countmax*130
    else
    end
end

local function gohome( event )
    homesearch = homesearch + 1

    local function onUpdateObject( event )
        if not event.error then
            print( event.response.updatedAt )
        end
    end
    local dataTable = {["Search"..currLvl] = homesearch }
    parse:updateObject("HomeCount", myData.homeid, dataTable, onUpdateObject)

    audio.stop(searchMusicplay)
    audio.dispose( searchMusic )
    local options = {
            effect = "crossFade",
            time = 500
    }
    for i=8,0,-1 
    do 
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
    for i=8,answer,-1 
    do 
        display.remove(newblock[i]) 
    end
end
local setupItems = {}

local function checkresult( event )
    runsearch = runsearch + 1
    local function onRunningObject( event )
        if not event.error then
            print( event.response.updatedAt )
        end
    end
    local runsearchTable = {["Search"..currLvl] = runsearch }
    parse:updateObject("RunCount", myData.runid, runsearchTable, onRunningObject)

    while answer<5 do
        print(answer)
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
        audio.pause(searchMusicplay)
        local options = {
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
        local attribute = "Search"..currLvl
        parse:updateObject("LevelTime", myData.timeid, {[attribute] = endTime})
        i=1
        while setupItems[i]~=nil do
            display.remove( setupItems[i] )
            i=i+1
        end
        setupItems={}
        composer.showOverlay("pass_tutorial", options)
        print("Current level: "..myData.searchLvl)
    else
        answer = countmax
    end
end

local function getKey()
        answerkey = {"red","green","blue","green","yellow"}
end


local function setupPic(name, pic, xVal, yVal, hVal,wVal,alpha)

    setupItems[name] = display.newImage(pic)
    setupItems[name].anchorX = 0
    setupItems[name].anchorY =1
    setupItems[name].x = xVal
    setupItems[name].y = yVal
    setupItems[name].alpha=alpha
    if(hVal~=nil) then
        setupItems[name].height = hVal
    end
    if(wVal~=nil) then
        setupItems[name].width= wVal
    end
    if(alpha==nil) then
        setupItems[name].alpha=1
    end
end

local function ShowSpeech( CurrSpeech )

    local function nextSpeech( event )
        myData.SpeechS=myData.SpeechS + 1
        if(myData.SpeechS>=11) then

            runbutton:addEventListener("tap",checkresult)
            
        end
        ShowSpeech(myData.SpeechS)
    end
    i=1
    while setupItems[i]~=nil do
        display.remove( setupItems[i] )
        i=i+1
    end
    setupItems={}
    j=1
    if (myData.SSImages[CurrSpeech]~=nil) then
        im=myData.SSImages[CurrSpeech].images
        while im[j]~=nil do
            setupPic(j, im[j][1], im[j][2], im[j][3], im[j][4], im[j][5], im[j][6])
            j=j+1
        end
        setupItems[1]:toFront()
        setupItems[1]:addEventListener( "tap", nextSpeech )
    end

end

-- "scene:create()"
function scene:create( event )

    currLvl = myData.searchLvl
    myData.rescue = 0

    local sceneGroup = self.view
    searchMusic = audio.loadStream( "Music/bensound-slowmotion.mp3")
    searchMusicplay = audio.play( searchMusic, {  fadein = 4000, loops=-1 } )
    ShowSpeech(myData.SpeechS)

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

    local background = display.newImage("Images/theme_default/search_background.png")
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
        sceneGroup:insert(levelmap)


        blockred:addEventListener( "tap", addred )
        blockgreen:addEventListener( "tap", addgreen )
        blockblue:addEventListener( "tap", addblue )
        blockyellow:addEventListener( "tap", addyellow )
        deletebutton:addEventListener("tap",removelast)
        homebutton:addEventListener("tap",gohome)
        
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
        currLvl = myData.searchLvl
        myData.rescue = 0
        if(levelmap == nil) then
            undosearch = 0
            homesearch = 0
            runsearch = 0
            searchMusic = audio.loadStream( "Music/bensound-slowmotion.mp3")
            searchMusicplay = audio.play( searchMusic, {  fadein = 4000, loops=-1 } )
            levelmap = display.newImage("Images/search"..currLvl..".png")
            levelmap.anchorX=0
            levelmap.anchorY=0
            levelmap.x=194
            levelmap.y=583
            levelmap.height=447
            levelmap.width=862

            sceneGroup:insert(levelmap)
        end
        

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
        i=1
        while setupItems[i]~=nil do
            display.remove( setupItems[i] )
            i=i+1
        end
        setupItems={}
        myData.SpeechS=1
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