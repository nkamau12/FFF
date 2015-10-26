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

parse.showStatus = true
--Register when app is opened
parse:appOpened()


-- require the composer library
local composer = require "composer"

local GA = require "plugin.gameanalytics"
composer.gotoScene( "Splash" )
GA.isDebug = true
GA.runInSimulator=true
GA.submitAverageFps=true
GA.submitSystemInfo=true
GA.init ( {
		game_key = 'c5fff2a3c3f7970f8560e139994010c9',
		secret_key = '378b4c3481bfbd954ea49d1611df233fca998b44',
		build_name = "FTF",
		} )



-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)

