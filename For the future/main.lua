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
myData.rescue = 0

-- require the composer library
local composer = require "composer"

composer.gotoScene( "Splash" )




-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)

