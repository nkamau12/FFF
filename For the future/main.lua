---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local parse = require( "mod_parse" )
parse:init({ 
  appId = "YZIbu9ERjYD4h8OdtdJ3fknrWIwjMUZGjUSrZOQe", 
  apiKey = "WTmSOin1ChKS2l0CXkenSNaSwMEMy2ytEwyaBesn"
})

parse.showStatus = false
--Register when app is opened
parse:appOpened()

local myData = require( "mydata" )

--Save the parse object id for later use
local function saveTime(event)
  if not event.error then
    myData.timeid = event.response.objectId
  end
end
local function saveUndo(event)
  if not event.error then
    myData.undoid = event.response.objectId
  end
end
local function saveHome(event)
  if not event.error then
    myData.homeid = event.response.objectId
  end
end
local function saveRun(event)
  if not event.error then
    myData.runid = event.response.objectId
  end
end
local function saveEmpty(event)
  if not event.error then
    myData.emptyid = event.response.objectId
  end
end

--Generate parse object
local datatable = {}
parse:createObject("LevelTime", datatable, saveTime)
parse:createObject("UndoCount", datatable, saveUndo)
parse:createObject("HomeCount", datatable, saveHome)
parse:createObject("RunCount", datatable, saveRun)
parse:createObject("EmptyCount", datatable, saveEmpty)
myData.searchLvl = 1
myData.rescueLvl = 1
myData.maxsrch = 1
myData.maxrsc = 1
myData.rescue = 0





--RESCUE OBJECTS:
local sciencex
local sciencey

-- myData.objectname = {xVal, yVal, hVal, wVal, imageFile}
--         (1)   (2)   (3)   (4)
--        _____ __topwall__ _____
--       |     |     |     |     |
--  (w)  |     |1    |2    |3    |r
--      l|__A__|__B__|__C__|__D__|i
--      e|     |     |     |     |g
--  (x) f|     |4    |5    |6    |h
--      t|__E__|__F__|__G__|__H__|t
--      w|     |     |     |     |w
--  (y) a|     |7    |8    |9    |a
--      l|__I__|__J__|__K__|__L__|l
--      l|     |     |     |     |l
--  (z)  |     |10   |11   |12   |
--       |_____|_____|_____|_____|
--              bottomwall
function setObjects()
  --horizontal walls
  myData.walla = {110, 288, 10, 124, "Images/locked_door_horizontal.png"}
  myData.wallb = {359, 288, 11, 124, "Images/locked_door_horizontal.png"}
  myData.wallc = {598, 288, 11, 124, "Images/locked_door_horizontal.png"}
  myData.walld = {839, 288, 11, 124, "Images/locked_door_horizontal.png"}
  myData.walle = {110, 533, 11, 124, "Images/locked_door_horizontal.png"}
  myData.wallf = {359, 533, 11, 124, "Images/locked_door_horizontal.png"}
  myData.wallg = {598, 533, 11, 124, "Images/locked_door_horizontal.png"}
  myData.wallh = {839, 533, 11, 124, "Images/locked_door_horizontal.png"}
  myData.walli = {110, 777, 11, 124, "Images/locked_door_horizontal.png"}
  myData.wallj = {359, 777, 11, 124, "Images/locked_door_horizontal.png"}
  myData.wallk = {598, 777, 11, 124, "Images/locked_door_horizontal.png"}
  myData.walll = {839, 777, 11, 124, "Images/locked_door_horizontal.png"}

  --vertical walls
  myData.wall1 = {290, 108, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall2 = {534, 108, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall3 = {778, 108, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall4 = {290, 355, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall5 = {534, 355, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall6 = {778, 355, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall7 = {290, 602, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall8 = {534, 602, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall9 = {778, 602, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall10 = {290, 848, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall11 = {534, 848, 124, 11, "Images/locked_door_horizontal.png"}
  myData.wall12 = {778, 848, 124, 11, "Images/locked_door_horizontal.png"}

  --outer walls
  myData.grida = {43.01, 41.93, 993.04, 993.04,"Images/rescue_grid.png"}
  myData.leftwall = {43.01, 41.93, 993.04, 10,"Images/theme_red/left_wall.png"}
  myData.rightwall = {1026.05, 41.93, 993.04, 10,"Images/theme_red/left_wall.png"}
  myData.topwall = {43.01, 41.93, 10, 993.04,"Images/theme_red/topbottom_wall.png"}
  myData.bottomwall = {43.01, 1024.97, 10, 993.04,"Images/theme_red/topbottom_wall.png"}

  --loop objects
  myData.oneloop = {1063.96, 625, 133, 805,"Images/one_loop.png"}
  myData.twoloop = {1063.96, 768, 133, 805,"Images/two_loop.png"}
  myData.threeloop = {1063.96, 910, 133, 805,"Images/three_loop.png"}

  --buttons
  myData.uparrow = {1192, 186, 122, 122, "Images/up_arrow.png"}
  myData.downarrow = {1330, 186, 122, 122, "Images/down_arrow.png"}
  myData.leftarrow = {1468, 186, 122, 122, "Images/left_arrow.png"}
  myData.rightarrow = {1606, 186, 122, 122, "Images/right_arrow.png"}
  myData.onebutton = {1126, 332, 122, 122, "Images/one_button_white.png"}
  myData.twobutton = {1264, 332, 122, 122, "Images/two_button_white.png"}
  myData.threebutton = {1403, 332, 122, 122, "Images/three_button_white.png"}
  myData.homebutton = {1764, 30, 122, 122, "Images/home.png"}
  myData.startbutton = {1542, 332, 122, 320, "Images/run_button.png"}

  --robot
  myData.robot = {109, 819, 140, 140, "Images/robot_potato.png"}

  --scientist
  myData.science = {nil, nil, 140, 140, "Images/scientist_sadface.png"}

  --Level keys
  myData.levelkey = {
    { walls = {'a','b','c','d','f','j',7,8}, scientist = {4, 'x'}}, -- level 1
    { walls = {8,10},              scientist = {4, 'z'}}, -- level 2
    { walls = {},                scientist = {4, 'w'}}  -- level 3
  }
end

function setscience(level)
  lvl = level
  sciencex = myData.levelkey[lvl].scientist[1]
  if(sciencex == 1) then
    myData.science[1] = 100
  elseif(sciencex == 2) then
    myData.science[1] = 347
  elseif(sciencex == 3) then
    myData.science[1] = 595
  elseif(sciencex == 4) then
    myData.science[1] = 843
  end

  sciencey = myData.levelkey[lvl].scientist[2]
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

setObjects()
setscience(1)


-- require the composer library
local composer = require "composer"

composer.gotoScene( "Splash" )




-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)

