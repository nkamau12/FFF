local composer = require( "composer" )
local myData = require( "mydata" )
local physics = require("physics")
local widget = require("widget")
local scene = composer.newScene()

local setupItems={}
local levelkeys=0
local key = {{},{},{}}
local picToAdd=""

local table1 = {}
local table2 = {}
local table3 = {}
local fintable = {}
local counter = 1;
local robot
local buttonTable = {}
local picTable = {}
local popupPic 
local setupItems = {}
local myrectd
local myrectu
local numkeys
local myrectl
local myrectr
local currResc
local currwall
local scoreKey
local keyscount
local removedImage={}

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------
-- local forward references should go here
-- -------------------------------------------------------------------------------
local function setupPic(name, pic, xVal, yVal, hVal,wVal,alpha,xpos,ypos)

    local setupItems = display.newImage(pic)
    if(xpos==nil) then
        setupItems.anchorX = 0
    else
        setupItems.anchorX = xpos
    end
    if(ypos==nil) then
        setupItems.anchorY = 0
    else
        setupItems.anchorY = ypos
    end
    setupItems.x = xVal
    setupItems.y = yVal
    if(hVal~=nil) then
        setupItems.height = hVal
    end
    if(wVal~=nil) then
        setupItems.width= wVal
    end
    if(alpha==nil) then
        setupItems.alpha=1
    else
        setupItems.alpha=alpha
    end
    setupItems.myName=name
    return setupItems
end

function setkeys(index)
    ind = index
    if(myData.Build_Rescue.key[ind][1] ~= nil)then
      keyx = myData.Build_Rescue.key[ind][1]
      if(keyx == 0) then
        key[ind][1] = 0
      elseif(keyx == 1) then
        key[ind][1] = 100
      elseif(keyx == 2) then
        key[ind][1] = 347
      elseif(keyx == 3) then
        key[ind][1] = 595
      elseif(keyx == 4) then
        key[ind][1] = 843
      end
    end

    if(myData.Build_Rescue.key[ind][1] ~= nil)then
      keyy = myData.Build_Rescue.key[ind][2]
      if(keyy == 0) then
        key[ind][2] = 0
      elseif(keyy == 'w') then
        key[ind][2] = 100
      elseif(keyy == 'x') then
        key[ind][2] = 348
      elseif(keyy == 'y') then
        key[ind][2] = 596
      elseif(keyy == 'z') then
        key[ind][2] = 840
      end
    end
end

local function addPicTo(position, name, xVal, yVal)
    picTable[position] = display.newImage(name)
    picTable[position].anchorX = 0.5
    picTable[position].anchorY = 0.5
    picTable[position].x = xVal
    picTable[position].y = yVal
    picTable[position].height = 120
    picTable[position].width = 120
    picTable[position].id = name
end

local function  popup(x,y,height,width)
    
    if(popupPic == nil) then
        popupPic = display.newRect(x,y,height,width)
        popupPic.anchorX = 0
        popupPic.anchorY = 0    
        popupPic:setFillColor(grey, 0.2)
    elseif(x ~= popupPic.x)then
        display.remove(popupPic)
        popupPic = display.newRect(x,y,height,width)
        popupPic.anchorX = 0
        popupPic.anchorY = 0    
        popupPic:setFillColor(grey, 0.2)
    end
end
local function addPic(xVal,yVal,name,spot)
    if((picTable[spot]== nil) and (picToAdd == ""))then
        emptyloop = emptyloop + 1
        local function onEmptyRescue( event )
            if not event.error then
            end
        end

    elseif(picTable[spot] == nil) then
        addPicTo(spot, name, xVal, yVal)

    elseif (picToAdd == "") then
        display.remove(picTable[spot])
        picTable[spot] = nil

        undoloop = undoloop + 1
        local function onUndoSearch( event )
            if not event.error then
            end
        end     
    else
        display.remove(picTable[spot])
        addPicTo(spot, name, xVal, yVal)
            
        undoloop = undoloop + 1
        local function onUndoSearch( event )
            if not event.error then
            end
        end
    end
    picToAdd = ""
    if(popupPic~=nil)then
        display.remove(popupPic)
        popupPic = nil
    end
end



local function handleButtonEvent( event )
    if ( "moved" == event.phase ) then
    elseif ( "ended" == event.phase ) then
        if(event.target.id == "mainloopBtn1") then
            table1[1] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 1)
        end
        if(event.target.id == "mainloopBtn2") then
            table1[2] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 2)
        end
        if(event.target.id == "mainloopBtn3") then
            table1[3] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 3)
        end
        if(event.target.id == "mainloopBtn4") then
            table1[4] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 4)
        end
        if(event.target.id == "mainloopBtn5") then
            table1[5] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 5)
        end
        if(event.target.id == "oneloopBtn1") then
            table2[1] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 6)
        end
        if(event.target.id == "oneloopBtn2") then
            table2[2] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 7)
        end
        if(event.target.id == "oneloopBtn3") then
            table2[3] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 8)
        end
        if(event.target.id == "oneloopBtn4") then
            table2[4] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 9)
        end
        if(event.target.id == "oneloopBtn5") then
            table2[5] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 10)
        end
        if(event.target.id == "twoloopBtn1") then
            table3[1] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 11)
        end
        if(event.target.id == "twoloopBtn2") then
            table3[2] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 12)
        end
        if(event.target.id == "twoloopBtn3") then
            table3[3] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 13)
        end
        if(event.target.id == "twoloopBtn4") then
            table3[4] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 14)
        end
        if(event.target.id == "twoloopBtn5") then
            table3[5] = picToAdd
            addPic(event.target.x, event.target.y,picToAdd, 15)
        end
    end
end

local function moveu()
        setupItems["robot"]:applyForce( 0, -200, setupItems["robot"].x+300, setupItems["robot"].y+70 )
end

local function moveup()
        local robotMusic = audio.loadStream( "Music/Pew_Pew.mp3")
        local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
        
        local robotX, robotY = setupItems["robot"]:localToContent( 0, -70 )
        transition.to( myrectu, { time=16, x=robotX, y=robotY-250} )
        timer.performWithDelay(20,moveu)
end


local function moveri()
        setupItems["robot"]:applyForce( 200, 0, setupItems["robot"].x+70, setupItems["robot"].y+70 )  
end

local function mover()
        local robotMusic = audio.loadStream( "Music/Pew_Pew.mp3")
        local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
        local robotX, robotY = setupItems["robot"]:localToContent( 0, 0 )
        transition.to( myrectr, { time=16, x=robotX+320, y=robotY} )
        timer.performWithDelay(20,moveri)
end


local function movedo()
        setupItems["robot"]:applyForce( 0, 200, setupItems["robot"].x+70, setupItems["robot"].y+70 )
end

local function moved()
        local robotMusic = audio.loadStream( "Music/Pew_Pew.mp3")
        local robotMusicplay = audio.play( robotMusic, {  loops=0 } )
        local robotX, robotY = setupItems["robot"]:localToContent( 0, -70 )
        transition.to( myrectd, { time=16, x=robotX, y=robotY+390} )
        timer.performWithDelay(20,movedo)   
end


local function movele()
        setupItems["robot"]:applyForce( -200, 0, setupItems["robot"].x+70, setupItems["robot"].y+70 )
end

local function movel()
        local robotMusic = audio.loadStream( "Music/Pew_Pew.mp3")
        local robotMusicplay = audio.play( robotMusic, { loops=0 } )
        local robotX, robotY = setupItems["robot"]:localToContent( 0, 0 )
        transition.to( myrectl, { time=16, x=robotX-320, y=robotY} )
        timer.performWithDelay(20,movele)   
end



local function mdtap()
    picToAdd = "Images/down_arrow.png"
    popup(myData.downarrow[1], myData.downarrow[2], myData.downarrow[3], myData.downarrow[4])
    
end

local function mutap()
    picToAdd = "Images/up_arrow.png"
    popup(myData.uparrow[1], myData.uparrow[2], myData.uparrow[3], myData.uparrow[4])
end

local function mrtap()
    picToAdd = "Images/right_arrow.png"
    popup(myData.rightarrow[1], myData.rightarrow[2], myData.rightarrow[3], myData.rightarrow[4])
end

local function mltap()
    picToAdd = "Images/left_arrow.png"
    popup(myData.leftarrow[1], myData.leftarrow[2], myData.leftarrow[3], myData.leftarrow[4])
end


local function onetap()
    picToAdd = "Images/1_block.png"
    popup(myData.onebutton[1], myData.onebutton[2], myData.onebutton[3], myData.onebutton[4])
end

local function twotap()
    picToAdd = "Images/2_block.png"
    popup(myData.twobutton[1], myData.twobutton[2], myData.twobutton[3], myData.twobutton[4])
end

local function moverobot()
    local max = table.maxn(fintable)
    
    if not (counter>max) then
        if (fintable[counter]=="Images/up_arrow.png") then
            moveup()
        elseif (fintable[counter]=="Images/down_arrow.png") then
            moved()
        elseif (fintable[counter]=="Images/left_arrow.png") then
            movel()
        elseif (fintable[counter]=="Images/right_arrow.png") then
            mover()
        else
            
        end
        counter=counter+1
    else
        local options = {
            isModal = true
            }
            composer.showOverlay( "fail_rescue_build", options )
    end 
end

local function onCollision( event )
    if ( event.phase == "began" ) then
        if (event.object2==myrectu or event.object2==myrectd or event.object2==myrectl or event.object2==myrectr) then
            moverobot()
        elseif (string.find( event.object2.myName , "key" )~=nil) then
            currkey = event.object2
            Image = {currkey.myName,"Images/key.png",currkey.x,currkey.y,124,140}
            table.insert( removedImage, Image )
            keyscount = keyscount + 1
            display.remove(event.object2)
        elseif (event.object2==setupItems["science"]) then
            local options = {
                isModal = true,
                effect = "crossFade",
                time = 500
            }
            audio.stop(elevatorMusicplay)
            audio.pause(backgroundMusicplay)
            composer.showOverlay("Save_Rescue",options)

        elseif (event.object2==setupItems["bottomwall"] or event.object2==setupItems["topwall"] 
                or event.object2==setupItems["leftwall"] or event.object2==setupItems["rightwall"] ) then
            local options = {
            isModal = true,
            
            }
            composer.showOverlay( "fail_rescue_build", options )
        else
            if(keyscount > 0)then
                currwall = event.object2.myName
                currdata = myData[currwall]
                Image = {currwall, currdata[5], currdata[1], currdata[2], currdata[3], currdata[4]}
                table.insert( removedImage, Image )
                event.object2:removeSelf()
                keyscount = keyscount - 1
                counter = counter - 1
                moverobot()
            else
                local options = {
                isModal = true
                }
                composer.showOverlay( "fail_rescue_build", options )
            end
        end
    end
end

local function merge(tablel)
    
    for i=1,5,1 do
        if (tablel[i]=="Images/main_block.png") then
            merge(table1)
        elseif (tablel[i]=="Images/1_block.png") then
            merge(table2)
        elseif (tablel[i]=="Images/2_block.png") then
            merge(table3)
        elseif ( tablel[i]=="Images/up_arrow.png" or tablel[i]=="Images/down_arrow.png" 
                or tablel[i]=="Images/left_arrow.png" or tablel[i]=="Images/right_arrow.png") then
            table.insert(fintable,tablel[i])
        else
        end
    end
    
end



local function pass()
    keyscount=0
    counter=1
    merge(table1)
    moverobot()
    
end

local function addButton(position, xPos, yPos,idName)
    buttonTable[position] = widget.newButton
    {
        width = 120,
        height = 120,
        x = xPos ,
        y = yPos ,
        id = idName,
        onEvent = handleButtonEvent
    }
end

local function myscientist( )
  sciencex = myData.Build_Rescue.scientist[1]
  if(sciencex == 1) then
    myData.science[1] = 100
  elseif(sciencex == 2) then
    myData.science[1] = 347
  elseif(sciencex == 3) then
    myData.science[1] = 595
  elseif(sciencex == 4) then
    myData.science[1] = 843
  end

  sciencey = myData.Build_Rescue.scientist[2]
  if(sciencey == 'w') then
    myData.science[2] = 100
  elseif(sciencey == 'x') then
    myData.science[2] = 348
  elseif(sciencey == 'y') then
    myData.science[2] = 596
  elseif(sciencey == 'z') then
    myData.science[2] = 840
  end
end

local function resetWallKey()
    while(removedImage[1]~=nil) do
        setupItems[removedImage[1][1]] = setupPic(removedImage[1][1], removedImage[1][2], removedImage[1][3],removedImage[1][4],removedImage[1][5], removedImage[1][6])
        if (string.find( removedImage[1][1], "key" )~=nil) then
            physics.addBody(setupItems[removedImage[1][1]], "static",{ isSensor=true })

        else
            physics.addBody(setupItems[removedImage[1][1]], "static")
        end
        table.remove( removedImage, 1 )
    end
    removedImage={}
end
function scene:resetrobot()
    transition.moveTo( setupItems["robot"], { time=0, x=109, y=819} )
    fintable=nil
    fintable={}
    counter=1
    timer.performWithDelay(20,restartr) 
    timer.performWithDelay(180,resetWallKey()) 
    
    if(myData.trya==true) then
        local options = {
            isModal = true,
            effect = "crossFade",
            time = 500
        } 
        myData.trya=false 
        composer.gotoScene("Build_Rescue",options)
    end
end



local function restartr()
    local robotX, robotY = setupItems["robot"]:localToContent( -70, -70 )
    transition.to( myrectu, { time=16, x=robotX, y=robotY-240} )
    transition.to( myrectl, { time=16, x=robotX-240, y=robotY} )
    transition.to( myrectd, { time=16, x=robotX, y=robotY+240} )
    transition.to( myrectr, { time=16, x=robotX+240, y=robotY} )
    fintable=nil
    fintable={}
    counter=1
end



local function gohome()
    local options = {
        isModal = true,
        effect = "crossFade",
        time = 500
    }
    audio.stop(1)
    audio.stop(2)
    audio.pause(backgroundMusicplay)
    composer.gotoScene("MainMenu",options)   
end

-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    homerescue = 0
    runrescue = 0
    undoloop = 0
    emptyloop = 0
    keyscount = 0
    setupItems["background"]=setupPic("background", myData.background[5], myData.background[1], myData.background[2], myData.background[3], myData.background[4])
    setupItems["grida"]=setupPic("grida", myData.grida[5], myData.grida[1], myData.grida[2], myData.grida[3], myData.grida[4])
    setupItems["start"]=setupPic("run_button", myData.startbutton[5], myData.startbutton[1], myData.startbutton[2], myData.startbutton[3], myData.startbutton[4])
    setupItems["home"]=setupPic("home", myData.homebutton[5], myData.homebutton[1], myData.homebutton[2], myData.homebutton[3], myData.homebutton[4])
    setupItems["robot"] = setupPic("robot", myData.robot[5], myData.robot[1], myData.robot[2], myData.robot[3], myData.robot[4])
    setupItems["leftwall"] = setupPic("leftwall", myData.leftwall[5], myData.leftwall[1], myData.leftwall[2], myData.leftwall[3], myData.leftwall[4])
    setupItems["rightwall"] = setupPic("rightwall", myData.rightwall[5], myData.rightwall[1], myData.rightwall[2], myData.rightwall[3], myData.rightwall[4])
    setupItems["topwall"] = setupPic("topwall", myData.topwall[5], myData.topwall[1], myData.topwall[2], myData.topwall[3], myData.topwall[4])
    setupItems["bottomwall"] = setupPic("bottomwall", myData.bottomwall[5], myData.bottomwall[1], myData.bottomwall[2], myData.bottomwall[3], myData.bottomwall[4])
    --loops
    setupItems["mainl"] =setupPic("mainl", myData.mainloop[5], myData.mainloop[1], myData.mainloop[2], myData.mainloop[3], myData.mainloop[4])
    setupItems["onel"] =setupPic("onel", myData.oneloop[5], myData.oneloop[1], myData.oneloop[2], myData.oneloop[3], myData.oneloop[4])
    setupItems["twol"] =setupPic("twol", myData.twoloop[5], myData.twoloop[1], myData.twoloop[2], myData.twoloop[3], myData.twoloop[4])
    --buttons
    setupItems["upa"] =setupPic("upa", myData.uparrow[5], myData.uparrow[1], myData.uparrow[2], myData.uparrow[3], myData.uparrow[4])
    setupItems["downa"] =setupPic("downa", myData.downarrow[5], myData.downarrow[1], myData.downarrow[2], myData.downarrow[3], myData.downarrow[4])
    setupItems["lefta"] =setupPic("lefta", myData.leftarrow[5], myData.leftarrow[1], myData.leftarrow[2], myData.leftarrow[3], myData.leftarrow[4])
    setupItems["righta"] =setupPic("righta", myData.rightarrow[5], myData.rightarrow[1], myData.rightarrow[2], myData.rightarrow[3], myData.rightarrow[4])
    setupItems["oneb"] =setupPic("oneb", myData.onebutton[5], myData.onebutton[1], myData.onebutton[2], myData.onebutton[3], myData.onebutton[4])
    setupItems["twob"] =setupPic("twob", myData.twobutton[5], myData.twobutton[1], myData.twobutton[2], myData.twobutton[3], myData.twobutton[4])


    sceneGroup:insert(setupItems["leftwall"])
    sceneGroup:insert(setupItems["rightwall"])
    sceneGroup:insert(setupItems["topwall"])
    sceneGroup:insert(setupItems["bottomwall"])
    sceneGroup:insert(setupItems["background"])
    sceneGroup:insert(setupItems["robot"])
    sceneGroup:insert(setupItems["grida"])
    sceneGroup:insert(setupItems["start"])
    sceneGroup:insert(setupItems["home"])
    sceneGroup:insert(setupItems["mainl"])
    sceneGroup:insert(setupItems["onel"])
    sceneGroup:insert(setupItems["twol"])
    sceneGroup:insert(setupItems["upa"])
    sceneGroup:insert(setupItems["downa"])
    sceneGroup:insert(setupItems["lefta"])
    sceneGroup:insert(setupItems["righta"])
    sceneGroup:insert(setupItems["oneb"])
    sceneGroup:insert(setupItems["twob"])

    --one loop button
    addButton(11, 1270.21, 690.86, "mainloopBtn1")
    addButton(12, 1402.21, 690.86, "mainloopBtn2")
    addButton(13, 1530.21, 690.86, "mainloopBtn3")
    addButton(14, 1660.21, 690.86, "mainloopBtn4")
    addButton(15, 1790.21, 690.86, "mainloopBtn5")
    
    --two loop buttons
    addButton(21, 1270.21, 835.86, "oneloopBtn1")
    addButton(22, 1402.21, 835.86, "oneloopBtn2")
    addButton(23, 1530.21, 835.86, "oneloopBtn3")
    addButton(24, 1660.21, 835.86, "oneloopBtn4")
    addButton(25, 1790.21, 835.86, "oneloopBtn5")
    
    --three loop buttons
    addButton(31, 1270.21, 980.86, "twoloopBtn1")
    addButton(32, 1402.21, 980.86, "twoloopBtn2")
    addButton(33, 1530.21, 980.86, "twoloopBtn3")
    addButton(34, 1660.21, 980.86, "twoloopBtn4")
    addButton(35, 1790.21, 980.86, "twoloopBtn5")
    --add buttons to scene
    sceneGroup:insert(buttonTable[11])
    sceneGroup:insert(buttonTable[12])
    sceneGroup:insert(buttonTable[13])
    sceneGroup:insert(buttonTable[14])
    sceneGroup:insert(buttonTable[15])
    
    sceneGroup:insert(buttonTable[21])
    sceneGroup:insert(buttonTable[22])
    sceneGroup:insert(buttonTable[23])
    sceneGroup:insert(buttonTable[24])
    sceneGroup:insert(buttonTable[25])
    
    sceneGroup:insert(buttonTable[31])
    sceneGroup:insert(buttonTable[32])
    sceneGroup:insert(buttonTable[33])
    sceneGroup:insert(buttonTable[34])
    sceneGroup:insert(buttonTable[35])

    --Adding event listeners
    
    setupItems["upa"]:addEventListener( "tap", mutap )
    setupItems["downa"]:addEventListener( "tap", mdtap )
    setupItems["lefta"]:addEventListener( "tap", mltap )
    setupItems["righta"]:addEventListener( "tap", mrtap )
    setupItems["oneb"]:addEventListener("tap", onetap)
    setupItems["twob"]:addEventListener("tap", twotap)
    setupItems["start"]:addEventListener("tap", pass)
    setupItems["home"]:addEventListener("tap", gohome)
end



-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        myscientist()
        setupItems["science"]=setupPic("science", myData.science[5], myData.science[1], myData.science[2], myData.science[3], myData.science[4])
        sceneGroup:insert(setupItems["science"])
        levelkeys=0
        --setting keys
        for i=1,3,1 do
            if(myData.Build_Rescue.key[i][1]~=nil) then
                setkeys(i)
                levelkeys = levelkeys+1
                setupItems["key"..i] = setupPic("key"..i,"Images/key.png",key[i][1],key[i][2],124,140)
                sceneGroup:insert(setupItems["key"..i])
            end
        end

        --setting walls
        i = 1
        while(myData.Build_Rescue.walls[i] ~= nil) do
            currwall = "wall"..(myData.Build_Rescue.walls[i])
            currdata = myData[currwall]
            setupItems[currwall] = setupPic(currwall, currdata[5], currdata[1], currdata[2], currdata[3], currdata[4])
            sceneGroup:insert(setupItems[currwall])
            i = i + 1
        end
        i = 1
        --PHYSICS:
        --physics add bodies
        physics.start()
        physics.setGravity( 0, 0 )
        --robot
        physics.addBody(setupItems["robot"],"dynamic",{bounce=0,friction=.8})
        setupItems["robot"].isFixedRotation = true
            
        --Misc
        local robotX, robotY = setupItems["robot"]:localToContent( -70, -70 )
        myrectu = display.newRect( robotX, robotY-248, 1, 1)
        sceneGroup:insert(myrectu)
        physics.addBody( myrectu, "static",{bounce=0})
        myrectd = display.newRect( robotX, robotY+248, 1, 1)
        sceneGroup:insert(myrectd)
        physics.addBody( myrectd, "static",{bounce=0})
        myrectl = display.newRect( robotX-248, robotY, 1, 1)
        sceneGroup:insert(myrectl)
        physics.addBody( myrectl, "static",{bounce=0})
        myrectr = display.newRect( robotX+248, robotY, 1, 1)
        sceneGroup:insert(myrectr)
        physics.addBody( myrectr, "static",{bounce=0})
            
        --keys
        i=1
        while(setupItems["key"..i]~=nil) do
                physics.addBody(setupItems["key"..i], "static",{ isSensor=true })
                i=i+1
        end
        i=1
        Runtime:addEventListener( "collision", onCollision )
        --walls physics
        physics.addBody( setupItems["leftwall"], "static",{bounce=0})
        physics.addBody( setupItems["rightwall"], "static",{bounce=0})
        physics.addBody( setupItems["topwall"], "static",{bounce=0})
        physics.addBody( setupItems["bottomwall"], "static",{bounce=0})
        i=1
        while(myData.Build_Rescue.walls[i] ~= nil) do
            currwall = "wall"..(myData.Build_Rescue.walls[i])
            physics.addBody( setupItems[currwall], "static",{bounce=0})
            i = i + 1
        end
        i = 1

        --scientist
        physics.addBody(setupItems["science"], "static",{bounce=0})

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
        --reset level
        restartr()
        removedImage={}
        --clear the tables
        display.remove(myrectu)
        display.remove(myrectd)
        display.remove(myrectl)
        display.remove(myrectr)
        table1={}
        table2={}
        table3={}
        --remove all the button overlays
        i = 1
        for h = 15, 1, -1 do
            if(picTable[h] ~= nil) then
                display.remove(picTable[h])
                table.remove(picTable[h])
            end
        end

        display.remove(setupItems["science"])
        --remove keys
        for i=1,3,1 do
            if(myData.Build_Rescue.key[i][1]~=nil) then
                display.remove(setupItems["key"..i])
                setupItems["key"..i]=nil
            end
        end

        --setting walls
        i = 1
        while(myData.Build_Rescue.walls[i] ~= nil) do
            currwall = "wall"..(myData.Build_Rescue.walls[i])
            display.remove( setupItems[currwall] )
            setupItems[currwall] =nil
            i = i + 1
        end
        i = 1
        physics.stop()
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        Runtime:removeEventListener( "collision", onCollision )
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