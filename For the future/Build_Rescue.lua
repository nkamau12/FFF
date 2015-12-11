local composer = require( "composer" )
local myData = require( "mydata" )
local physics = require("physics")
local widget = require("widget")
local scene = composer.newScene()

local basicItems={}
local level={ walls = {}, scientist = {nil,nil}, key = {{nil,nil},{nil,nil},{nil,nil}}}
local buttonTable = {}
local items = {}
local GridPos = {}
local keycount=0
local wall_buttons={
            wall01=myData.wall1, wall02=myData.wall2, wall03=myData.wall3, wall04=myData.wall4, wall05=myData.wall5, wall06=myData.wall6, 
            wall07=myData.wall7, wall08=myData.wall8, wall09=myData.wall9, wall10=myData.wall10, wall11=myData.wall11, wall12=myData.wall12,
            walla=myData.walla, wallb=myData.wallb, wallc=myData.wallc, walld=myData.walld, walle=myData.walle, wallf=myData.wallf, 
            wallg=myData.wallg, wallh=myData.wallh, walli=myData.walli, wallj=myData.wallj, wallk=myData.wallk, walll=myData.walll
        }

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

local function instructionTap( event )
    if ( event.phase == "began" ) then
        if (string.find( event.target.id, "%d" )==nil) then
            wall = event.target.id:sub( 1 ,5 )
            wallid = event.target.id:sub( 5,5 )
            file = event.target.id:sub( 6 )
        else
            wall = event.target.id:sub( 1 ,6 )
            wallid = tonumber(event.target.id:sub( 5,6 ))
            file = event.target.id:sub( 7 )
        end
        if (table.indexOf( level.walls, wallid)~=nil) then
            display.remove(items[wall])
            table.remove( level.walls, table.indexOf( level.walls, wallid) )

        else
            items[wall] = setupPic(wall,file,buttonTable[wall].x,buttonTable[wall].y,buttonTable[wall].height-20,buttonTable[wall].width-20)
            table.insert(level.walls,wallid)
        end   
        
    end
end



local function move( event )
    self=event.target
    
    if event.phase == "began" then
    
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
    
    elseif event.phase == "moved" then
    
        local x = (event.x - event.xStart) + self.markX
        local y = (event.y - event.yStart) + self.markY
        self.x, self.y = x, y   

    elseif event.phase == "ended" then
        for i=1,16,1 do
            if math.abs(self.y - 840) < 70 and math.abs(self.x - 100) < 70 then

            elseif math.abs(self.y - GridPos[i].y) < 70 and math.abs(self.x - GridPos[i].x) < 70 then
                transition.to( self, { time=16, x=GridPos[i].x, y=GridPos[i].y} )
            end
        end
        if (string.find( self.myName, "key" )~=nil and keycount<=3) then
        basicItems["key"..keycount].alpha=1
        basicItems["key"..keycount]:addEventListener("touch", move)
        keycount=keycount+1
        end
    end
    
    return true
end

local function build( )

    --Walls Done
    --Scientist Location check
    local letters = {'w','x','y','z'}
    local sciencefail =true
    local keyfail={true,true,true}
    count = 1
    for i = 1,4,1 do
        for j=1,4,1 do
            if (math.abs(basicItems["science"].x-GridPos[count].x)<30 and math.abs(basicItems["science"].y - GridPos[count].y)<30) then
                
                table.insert( level.scientist, 1, i )
                table.insert( level.scientist, 2, letters[j] )
                level.scientist[2] = letters[j]
                sciencefail=false
                count=count+1
            else
                count=count+1
            end
        end
    end
    --Key Location check
    
    for keys=1,keycount-1 do
        count = 1
        for i = 1,4,1 do
            for j=1,4,1 do
                
                if  (basicItems["key"..keys].x~=1468 or basicItems["key"..keys].y ~= 186) then
                    if (math.abs(basicItems["key"..keys].x-GridPos[count].x)<30 and math.abs(basicItems["key"..keys].y- GridPos[count].y)<30) then
                        level.key[keys][1] = i
                        level.key[keys][2] = letters[j]
                        keyfail[keys]=false
                        --print( "level.key[keys][2]" )
                    end
                    count=count+1
                else
                    keyfail[keys] = false
                end
            end
        end
    end
    keyfails=false
        for keys=1,keycount-1 do
            if (keyfail[keys]==true) then
                keyfails=true
            end
        end
    blah=level.scientist
    bleh={}
    bleh[1]=level.key[1][1]
    bleh[2]=level.key[1][2]
    bleh[3]=level.key[2][1]
    bleh[4]=level.key[2][2]
    bleh[5]=level.key[3][1]
    bleh[6]=level.key[3][2]
    wally={}
    if (sciencefail==false and keyfails==false) then
        
            myData.Build_Rescue.scientist[1] = blah[1]
            myData.Build_Rescue.scientist[2] = blah[2]
            myData.Build_Rescue.walls = level.walls
            myData.Build_Rescue.key[1][1]=bleh[1]
            myData.Build_Rescue.key[1][2]=bleh[2]
            myData.Build_Rescue.key[2][1]=bleh[3]
            myData.Build_Rescue.key[2][2]=bleh[4]
            myData.Build_Rescue.key[3][1]=bleh[5]
            myData.Build_Rescue.key[3][2]=bleh[6]
            --print("looking for this-> "..myData.Build_Rescue.walls[1] )
            --myData.Build_Rescue.key[1] = bleh
            local options = {
                isModal = true,
                effect = "crossFade",
                time = 500
            }  
            
            composer.gotoScene("Test_Build_Rescue",options)
            
    else
        composer.showOverlay( "fail_create_rescue", options )
    end
end

function scene:reset()
    transition.to( basicItems["science"], { time=16, x=1192, y=186} )
    for i=2,keycount-1 do
        basicItems["key"..i].alpha=0
        basicItems["key"..i].x=1468
        basicItems["key"..i].y=186
        basicItems["key"..i]:removeEventListener("touch", move)
    end
    transition.to( basicItems["key1"], { time=16, x=1468, y=186} )
    keycount=2
    level.scientist = {nil,nil} 
    level.key = {{nil,nil},{nil,nil},{nil,nil}}
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
            composer.gotoScene("MainMenu",optionsh)
            
            
end
-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    basicItems["background"]=setupPic("background", myData.background[5], myData.background[1], myData.background[2], myData.background[3], myData.background[4])
    basicItems["grida"]=setupPic("grida", myData.grida[5], myData.grida[1], myData.grida[2], myData.grida[3], myData.grida[4])
    
    basicItems["start"]=setupPic("run_button", myData.startbutton[5], myData.startbutton[1], myData.startbutton[2], myData.startbutton[3], myData.startbutton[4])
    basicItems["home"]=setupPic("home", myData.homebutton[5], myData.homebutton[1], myData.homebutton[2], myData.homebutton[3], myData.homebutton[4])
    basicItems["science"]=setupPic("science", myData.science[5], 1192, 186, myData.science[3], myData.science[4])
    basicItems["key1"]=setupPic("key1", myData.keybase[5], 1468, 186, myData.keybase[3], myData.keybase[4])
    basicItems["key2"]=setupPic("key2", myData.keybase[5], 1468, 186, myData.keybase[3], myData.keybase[4],0)
    basicItems["key3"]=setupPic("key3", myData.keybase[5], 1468, 186, myData.keybase[3], myData.keybase[4],0)
    
    basicItems["start"]:addEventListener("tap", build)
    basicItems["home"]:addEventListener("tap", gohome)
    basicItems["science"]:addEventListener("touch", move)
    basicItems["key1"]:addEventListener("touch", move)
    

    basicItems["robot"] = setupPic("robot", myData.robot[5], myData.robot[1], myData.robot[2], myData.robot[3], myData.robot[4])
    --basicItems["robot"].anchorX=0
    --basicItems["robot"].anchorY=0
    --basicItems["robot"].x=109
    --basicItems["robot"].y=819
    --basicItems["robot"].height=140
    --basicItems["robot"].width=140
    --basicItems["robot"].myName="robot"
    local letters = {w,x,y,z}
    count=1
    for i = 0,3,1 do
        for j=0,3,1 do
            GridPos[count] = {x=100+(247*i),y=100+(248*j)}
            count=count+1
        end
    end

    
    --addbackground
    sceneGroup:insert(basicItems["background"])
    sceneGroup:insert(basicItems["key1"])
    sceneGroup:insert(basicItems["key2"])
    sceneGroup:insert(basicItems["key3"])
    sceneGroup:insert(basicItems["robot"])
    --add grid
    sceneGroup:insert(basicItems["grida"])
    sceneGroup:insert(basicItems["start"])
    sceneGroup:insert(basicItems["home"])
    sceneGroup:insert(basicItems["science"])
    
end



local function addButton( wall,xPos, yPos,hi, wi,idName)
    buttonTable[wall] = widget.newButton
    {
        width = wi+20,
        height = hi+20,
        x = xPos ,
        y = yPos ,
        id = idName,
        onEvent = instructionTap,
        fillColor = { default={ 1, 0, 0, 1 }, over={ 1, 0.1, 0.7, 0.4 } }
    }
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    keycount=2
    if ( phase == "will" ) then
        
        
        for key,value in pairs(wall_buttons) do
            addButton(key,value[1], value[2], value[3], value[4],key..value[5])
            
            sceneGroup:insert(buttonTable[key])
        end
        
        
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
        for key,value in pairs(wall_buttons) do
            display.remove(items[key])
        end
        scene:reset()
        wallno= table.maxn(level.walls)
        for i=1,wallno,1 do
            if(string.find( level.walls[i], "%d" )==nil) then
                display.remove(items['wall'..level.walls[i]])
                --items['wall'..level.walls[i]]:removeSelf()
            else
                display.remove(items['wall0'..level.walls[i]])
                --items['wall0'..level.walls[i]]:removeSelf()
            end
        end
        level.walls=nil
        level.walls={}
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