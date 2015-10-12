---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require "composer"
local GA = require "plugin.gameanalytics"
GA.isDebug = true
GA.runInSimulator=true
GA.submitAverageFps=true
GA.submitSystemInfo=true
GA.init ( {
		game_key = 'c5fff2a3c3f7970f8560e139994010c9',
		secret_key = '378b4c3481bfbd954ea49d1611df233fca998b44',
		build_name = "FTF",
		} )
-- load scene1
composer.gotoScene( "MainMenu" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)

