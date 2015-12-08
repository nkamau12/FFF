---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )


-- code to read if there is an existent user logged into the game
local JSON = require ("json")
local loadsave = require( "loadsave" ) 
--default no user settings
--local userSettings = {
  --user = nil,
  --search = 1,
  --rescue = 0,
  --theme = "default",
  --robot = "default",
  --science = "default"
--}
--loadsave.saveTable( userSettings, "user.json" )
local loadedUser = loadsave.loadTable( "user.json" )
print(loadedUser)
if (loadedUser == nil) then
  local userSettings = {
    user = "nil",
    search = 1,
    rescue = 0,
    volume = 100,
    sfx = 100,
    credits = 0,
    theme = "default",
    robot = "default",
    science = "default",
    keys = 0,
    stopwatch = 0
  }
  loadsave.saveTable( userSettings, "user.json" )
  loadedUser = loadsave.loadTable( "user.json" )
end

--app42 API code
require("App42-Lua-API.Operator")
require("App42-Lua-API.Permission")
require("App42-Lua-API.GeoOperator")
require("App42-Lua-API.OrderByType")
require("App42-Lua-API.Operator")
local JSON = require("App42-Lua-API.JSON") 
local queryBuilder = require("App42-Lua-API.QueryBuilder")
local App42API = require("App42-Lua-API.App42API")
local ACL = require("App42-Lua-API.ACL")
App42API:initialize("b6887ae37e4088c5a4f198454ec46fdbfdfd0f96e0732c339f2534b4c5ca1080",
    "4e6f1ff5df8a77a619e5eeb4356445330e449b3ead02a7b2fea42c2e1080e44a")
local storageService = App42API:buildStorageService()  


--local in-game data storage
local myData = require( "mydata" )

--loading values
myData.searchLvl = 1
myData.rescueLvl = 1
myData.rescue = 0

--load user
local dbName  = "USERS"
local collectionName = "GameInfo"
local key = "user"
local value
--this checks if there is any content in user.json 
  --If not, it loads the default values so the game can run. 
  --This only serves as a callback while the app retrieves the actual data from the users database.
if(loadedUser == nil)then
  value = "nil"
  myData.user = nil
  myData.musicVol = 100
  myData.sfx = 100
  myData.credits = 0
  myData.savedkeys = 0
  myData.savedclocks = 0
else
  value = loadedUser.user
  print("value ")
  myData.musicVol = loadedUser.volume
  myData.sfx = loadedUser.sfx
  myData.credits = loadedUser.credits
end
if(value == nil)then
  value = "nil"
end
local App42CallBack = {}
local jsonDoc = {}
--this connects to App42's Api and looks for the user information stored in the database.
storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)

--if this function is called, it means the user was found in the database and all their content will be downloaded.
function App42CallBack:onSuccess(object)
  print("dbName is "..object:getDbName())
  for i=1,table.getn(object:getJsonDocList()) do
    print("DocId is "..object:getJsonDocList()[i]:getDocId())
    print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
    jsonDoc.userDoc = object:getJsonDocList()[i]:getDocId()
    jsonDoc.user = object:getJsonDocList()[i]:getJsonDoc().user
    jsonDoc.search = object:getJsonDocList()[i]:getJsonDoc().search
    jsonDoc.rescue = object:getJsonDocList()[i]:getJsonDoc().rescue
    jsonDoc.theme = object:getJsonDocList()[i]:getJsonDoc().theme
    jsonDoc.credits = object:getJsonDocList()[i]:getJsonDoc().credits
    jsonDoc.robot = object:getJsonDocList()[i]:getJsonDoc().robot
    jsonDoc.volume = object:getJsonDocList()[i]:getJsonDoc().volume
    jsonDoc.sfx = object:getJsonDocList()[i]:getJsonDoc().sfx
    jsonDoc.scientist = object:getJsonDocList()[i]:getJsonDoc().scientist
    jsonDoc.keys = object:getJsonDocList()[i]:getJsonDoc().keys
    jsonDoc.stopwatch = object:getJsonDocList()[i]:getJsonDoc().stopwatch
  end

  if(value == nil)then
    myData.user = nil
  else
    myData.user = jsonDoc.user
  end
  myData.maxsrch = jsonDoc.search
  myData.maxrsc = jsonDoc.rescue
  myData.theme = jsonDoc.theme
  myData.roboSprite = jsonDoc.robot
  myData.musicVol = jsonDoc.volume
  myData.sfx = jsonDoc.sfx
  myData.credits = jsonDoc.credits
  myData.scienceSprite = jsonDoc.scientist
  myData.userDoc = jsonDoc.userDoc
  myData.savedkeys = jsonDoc.keys
  myData.savedclocks = jsonDoc.stopwatch

  myData.key = {}
  
  myData.error1_count = 0
  myData.errorText1 = "Remeber to use method 1 and 2 to get all the commands you need"


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
    myData.background = {0, 0, 1080, 1920,"Images/theme_"..myData.theme.."/rescue_background.png"}
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
    myData.leftwall = {43.01, 41.93, 993.04, 10,"Images/theme_"..myData.theme.."/left_wall.png"}
    myData.rightwall = {1026.05, 41.93, 993.04, 10,"Images/theme_"..myData.theme.."/left_wall.png"}
    myData.topwall = {43.01, 41.93, 10, 993.04,"Images/theme_"..myData.theme.."/topbottom_wall.png"}
    myData.bottomwall = {43.01, 1024.97, 10, 993.04,"Images/theme_"..myData.theme.."/topbottom_wall.png"}
    --loop objects
    myData.mainloop = {1063.96, 625, 133, 805,"Images/main_loop.png"}
    myData.oneloop = {1063.96, 768, 133, 805,"Images/one_loop.png"}
    myData.twoloop = {1063.96, 910, 133, 805,"Images/two_loop.png"}
    --buttons
    myData.uparrow = {1065, 186, 122, 122, "Images/up_arrow.png"}
    myData.downarrow = {1203, 186, 122, 122, "Images/down_arrow.png"}
    myData.leftarrow = {1341, 186, 122, 122, "Images/left_arrow.png"}
    myData.rightarrow = {1479, 186, 122, 122, "Images/right_arrow.png"}
    myData.onebutton = {1617, 186, 122, 122, "Images/1_block.png"}
    myData.twobutton = {1755, 186, 122, 122, "Images/2_block.png"}
    myData.homebutton = {1764, 30, 122, 122, "Images/home.png"}
    myData.startbutton = {1552, 332, 122, 320, "Images/run_button.png"}
    myData.keypowerup = {1085, 349, 88, 88, "Images/key.png"}
    myData.clockpowerup = {1321, 349, 88, 88, "Images/stopwatch.png"}
    --robot
    myData.robot = {109, 819, 140, 140, "Images/robot_"..myData.roboSprite..".png"}
    --scientist
    myData.science = {nil, nil, 140, 140, "Images/scientist_"..myData.scienceSprite..".png"}
    --key
    myData.keybase = {nil, nil, 124, 140, "Images/key.png"}
    myData.key = {{},{},{},{}}
    --Level keys
    myData.Build_Rescue={ walls = {}, scientist = {nil,nil}, key = {{nil,nil},{nil,nil},{nil,nil}}}
    myData.levelkey = {
      { walls = {'a','b','c','d','f','j',7,8},                   scientist = {4, 'x'}, key = {{0,0}}}, -- level 1
      { walls = {8,10},                                          scientist = {4, 'z'}, key = {{0,0}}}, -- level 2
      { walls = {},                                              scientist = {4, 'w'}, key = {{0,0}}},  -- level 3
      { walls = {'e','b',4},                                     scientist = {1, 'x'}, key = {{0,0}}},  -- level 4
      { walls = {'e','f','g','h','l',9,12},                      scientist = {4, 'y'}, key = {{3, 'y'}}},  -- level 5
      { walls = {'a','b','c','i','j','k',6,9},                   scientist = {1, 'w'}, key = {{0,0}}},  -- level 6
      { walls = {'b','d','f','g',4,5},                           scientist = {2, 'x'}, key = {{4,'z'}}},  -- level 7
      { walls = {'e','f','i','j','k',2,5,6,7,8,9},               scientist = {1, 'y'}, key = {{3,'x'},{3,'y'}}},  -- level 8
      { walls = {'a','b','c','d','e','f','i','j',1,2,3,5,7},     scientist = {2, 'w'}, key = {{2,'x'},{3,'z'}}},  -- level 9
      { walls = {'c','f','g','h','k',5,6,8,9,11,12},             scientist = {3, 'y'}, key = {{2,'w'},{4,'x'}}},  -- level 10
      { walls = {'b','c','d','f','k','l',2,3,6,11},              scientist = {4, 'w'}, key = {{1,'w'}}},  -- level 11
      { walls = {'a','b','c','d','f','i','j','k',1,2,3,4,5,7,9}, scientist = {1, 'w'}, key = {{2,'z'},{3,'y'},{4,'w'},{4,'z'}}}  -- level 12
    }
  end

  --Load rescue objects
  setObjects()

  --Set scientist's location in the grid
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

  --Set keys' location(s) in the grid
  function setkey(level,index)
    lvl = level
    ind = index
    if(myData.levelkey[lvl].key[ind] ~= nil)then
      keyx = myData.levelkey[lvl].key[ind][1]
      if(keyx == 0) then
        myData.key[ind][1] = 0
      elseif(keyx == 1) then
        myData.key[ind][1] = 100
      elseif(keyx == 2) then
        myData.key[ind][1] = 347
      elseif(keyx == 3) then
        myData.key[ind][1] = 595
      elseif(keyx == 4) then
        myData.key[ind][1] = 843
      end
    end

    if(myData.levelkey[lvl].key[ind] ~= nil)then
      keyy = myData.levelkey[lvl].key[ind][2]
      if(keyy == 0) then
        myData.key[ind][2] = 0
      elseif(keyy == 'w') then
        myData.key[ind][2] = 100
      elseif(keyy == 'x') then
        myData.key[ind][2] = 348
      elseif(keyy == 'y') then
        myData.key[ind][2] = 596
      elseif(keyy == 'z') then
        myData.key[ind][2] = 840
      end
    end
  end


  --SEARCH OBJECTS:
  myData.blockred = {1289, 729, 120, 120, "Images/red_block.png", "red"}
  myData.blockgreen = {1426, 729, 120, 120, "Images/green_block.png", "green"}
  myData.blockblue = {1564, 729, 120, 120, "Images/blue_block.png", "blue"}
  myData.blockyellow = {1700, 729, 120, 120, "Images/yellow_block.png", "yellow"}

  myData.searchRun = {1450, 887, 120, 360, "Images/run_button.png"}
  myData.searchDelete = {1289, 887, 120, 120, "Images/delete_button.png"}
  myData.searchHome = {1766, 28, 120, 120, "Images/home.png"}

  -- Search answer keys. Used for the single player levels
  myData.searchAnswerkey = {
    {"red","green","blue","green","yellow"},                            -- level 1
    {"green","green","red","yellow","blue","green","green","red"},      -- level 2
    {"green","red","blue","red","blue","yellow","red","blue"},          -- level 3
    {"red","green","blue","yellow","green","yellow","red","blue"},      -- level 4
    {"yellow","red","yellow","green","blue","yellow"},                  -- level 5
    {"blue","yellow","red","red","green","green"},                      -- level 6
    {"red","blue","blue","red","red","blue","blue"},                    -- level 7
    {"green","yellow","blue","red","green","green","red","yellow"},     -- level 8
    {"blue","yellow","red","green","blue","yellow","green","green"},    -- level 9
    {"yellow","red","green","green","blue","green","green","yellow"},   -- level 10
    {"blue","blue","yellow","blue","blue","yellow","blue","blue"},      -- level 11
    {"green","red","blue","yellow","green","red","blue","green"}        -- level 12
  }


  -- Search setup keys. Each array corresponds to a function, so one = Main function, two = one function, and three = two Function
  myData.searchkey = {
    { one = {"red",1,"blue",1,"yellow"}, two = {"green",nil,nil,nil,nil}, three = {nil,nil,nil,nil,nil}},                    -- level 1
    { one = {1,"yellow","blue",1,nil}, two = {"green","green","red",nil,nil}, three = {nil,nil,nil,nil,nil}},                -- level 2
    { one = {"green",2,2,"yellow",2}, two = {nil,nil,nil,nil,nil}, three = {"red","blue",nil,nil,nil}},                      -- level 3
    { one = {1,"green","yellow","red","blue"}, two = {"red","green","blue","yellow",nil}, three = {"blue","yellow","red","red",nil}},-- level 4
    { one = {1,"green","blue",2,nil}, two = {"yellow","red",2,nil,nil}, three = {"yellow",nil,nil,nil,nil}},                 -- level 5
    { one = {"blue",2,nil,nil,nil}, two = {"red","red","green",nil,nil}, three = {"yellow",1,"green",nil,nil}},              -- level 6
    { one = {2,1,2,2,1}, two = {"blue","blue",nil,nil,nil}, three = {"red",nil,nil,nil,nil}},                                -- level 7
    { one = {"green",1,2,"yellow",nil}, two = {"yellow","blue",2,"green","green"}, three = {"red",nil,nil,nil,nil}},         -- level 8
    { one = {2,"green",1,"green","green"}, two = {"blue","yellow",nil,nil,nil}, three = {1,"red",nil,nil,nil}},              -- level 9
    { one = {"yellow",1,"yellow",nil,nil}, two = {"red",2,"blue",2,nil}, three = {"green","green",nil,nil,nil}},             -- level 10
    { one = {2,2,1,1,nil}, two = {"blue",nil,nil,nil,nil}, three = {1,1,"yellow",nil,nil}},                                  -- level 11
    { one = {2,"yellow",1,2,"green"}, two = {nil,nil,nil,nil,nil}, three = {"green",1,"red","blue",1}}                       -- level 12
  }
  
  --STORE OBJECTS:
  -- object = {type, displayname, picture, cost, backName}
  myData.storeItems = {
    {"robot", "Santa Robot", "Images/robot_santa.png", 100, "santa"},
    {"robot", "Potato Robot", "Images/robot_potato.png", 200, "potato"},
    {"scientist", "Present Scientist", "Images/scientist_present.png", 100, "present"},
    {"scientist", "Sad Scientist", "Images/scientist_sadface.png", 200, "sadface"},
    {"theme", "Yellow Theme", "Images/theme_yellow/splash_main.png", 50, "yellow"},
    {"theme", "Red Theme", "Images/theme_red/splash_main.png", 100, "red"},
    {"theme", "Green Theme", "Images/theme_green/splash_main.png", 150, "green"},
    {"robot", "Default Robot", "Images/robot_default.png", 0, "default"},
    {"scientist", "Default Scientist", "Images/scientist_default.png", 0, "default"},
    {"theme", "Default Theme", "Images/theme_default/splash_main.png", 0, "default"}
  } 

  -- object = {type, displayname, picture, cost, backName}
  myData.buyPowerUps = {
    {"powerup", "Key", "Images/key.png", 200, "keys"},
    {"powerup", "Time Stop", "Images/stopwatch.png", 200, "stopwatch"}
  } 


  --TUTORIAL OBJECTS:
  --Search Tutorial objects
  myData.SSImages = {
    {images = {{"Tutorials/tutorial_search_1.png",0,1080,nil,nil,0.8}}},
    {images = {{"Tutorials/tutorial_search_2.png",0,1080,nil,nil,0.8}}},
    {images = {{"Tutorials/tutorial_search_3.png",0,1080,nil,nil,0.8}}},
    {images = {{"Tutorials/tutorial_search_4.png",0,1080,nil,nil,0.8}}},
    {images = {{"Tutorials/tutorial_search_5.png",0,1080,nil,nil,0.8},{"Tutorials/red_outline.png",194,583+447,449,864,1}}},
    {images = {{"Tutorials/tutorial_search_6.png",0,1080,nil,nil,0.8},{"Tutorials/red_outline.png",194,583+151,151,864,1}}},
    {images = {{"Tutorials/tutorial_search_7.png",0,1080,nil,nil,0.8}}},
    {images = {{"Tutorials/tutorial_search_8.png",0,1080,nil,nil,0.8}}},
    {images = {{"Tutorials/tutorial_search_9.png",0,1080,nil,nil,0.8},{"Tutorials/red_outline.png",1288,729+121,122,538,1}}},
    {images = {{"Tutorials/tutorial_search_10.png",0,1080,nil,nil,0.8},{"Tutorials/red_outline.png",1289,887+121,122,122,1},{"Tutorials/alert_arrow.png",1072,887+97,nil,nil,1}}},
    {images = {{"Tutorials/tutorial_search_11.png",0,1080,nil,nil,0.8}}}
  }
  --Rescue Tutorial objects
  myData.SRImages = {
    {images = {{"Tutorials/tutorial_rescue_2.png",97,819,nil,nil,0.8,0,1}}},
    {images = {{"Tutorials/tutorial_rescue_3.png",97,819,nil,nil,0.8,0,1}}},
    {images = {{"Tutorials/tutorial_rescue_4.png",97,819,nil,nil,0.8,0,1},{"Tutorials/red_outline.png",842,347,142,142,1},{"Tutorials/alert_arrow.png",841,347+70,nil,nil,1,1,0.5}}},
    {images = {{"Tutorials/tutorial_rescue_5.png",97,819,nil,nil,0.8,0,1},{"Tutorials/red_outline.png",842,347,142,142,1},{"Tutorials/alert_arrow.png",841,347+70,nil,nil,1,1,0.5}}},
    {images = {{"Tutorials/tutorial_rescue_6.png",97,819,nil,nil,0.8,0,1},{"Tutorials/alert_arrow_v.png",172,288+10,nil,nil,1,0.5,0},{"Tutorials/alert_arrow_v.png",359+62,288+11,nil,nil,1,0.5,0},{"Tutorials/alert_arrow_v.png",598+62,288+11,nil,nil,1,0.5,0}}},
    {images = {{"Tutorials/tutorial_rescue_7.png",97,819,nil,nil,0.8,0,1}}},
    {images = {{"Tutorials/tutorial_rescue_8.png",97,819,nil,nil,0.8,0,1},{"Tutorials/red_outline.png",1120,155,320,750,1},{"Tutorials/alert_arrow.png",1120,155+160,nil,nil,1,1,0.5}}},
    {images = {{"Tutorials/tutorial_rescue_9.png",97,819,nil,nil,0.8,0,1},{"Tutorials/red_outline.png",1150,170,160,600,1},{"Tutorials/alert_arrow.png",1120,155+80,nil,nil,1,1,0.5}}},
    {images = {{"Tutorials/tutorial_rescue_10.png",97,819,nil,nil,0.8,0,1},{"Tutorials/red_outline.png",1100,325,150,450,1},{"Tutorials/alert_arrow.png",1100,325+75,nil,nil,1,1,0.5}}},
    {images = {{"Tutorials/tutorial_rescue_11.png",97,819,nil,nil,0.8,0,1},{"Tutorials/alert_arrow.png",1120,155+80,nil,nil,1,1,0.5}}},
    {images = {{"Tutorials/tutorial_rescue_12.png",97,819,nil,nil,0.8,0,1},{"Tutorials/alert_arrow.png",1200,691.5,nil,nil,1,1,0.5}}},
    {images = {{"Tutorials/tutorial_rescue_13.png",97,819,nil,nil,0.8,0,1},{"Tutorials/alert_arrow.png",1064,691.5,nil,nil,1,1,0.5}}},
    {images = {{"Tutorials/tutorial_rescue_14.png",97,819,nil,nil,0.8,0,1}}},
    {images = {{"Tutorials/tutorial_rescue_15.png",97,819,nil,nil,0.8,0,1}}},
  }
  myData.SpeechS=1
  myData.SpeechR=1


  --Pre-load content for Rescue 1
  setObjects()
  setscience(1)
  setkey(1)
  

 --error
	--Use of multiple function
	--Creating method error(Search)
	myData.error1_count = 0
	myData.errorText1 = "Remember once a method is complete it \n goes back to the method it was called from"
	myData.errorText2 = "Remember robot starts from M (main) method"
	--Calling method error (Rescue)
	myData.error2_count = 0
	myData.errorText3 = "Remember to use method 1 and 2 are used \n to get all the commands needed"
	myData.errorText4 = "Remember robot start reading commands from M (main) method"
	-- use of key error (Rescue)
	myData.error3_count = 0
	myData.errorText5 = "Remember each key only clears one wall"
	myData.errorText6 = "Remember go to the key first before going to wall"
	

  -- require the composer library
  local composer = require "composer"
  local options = {
    isModal = true,
    effect = "fade",
    time = 500
  }
  composer.gotoScene( "Splash" )
end

--this function runs if for any reason the game is unable to connect to the API. Then the default data will be pre-loaded in the game.
function App42CallBack:onException(exception)
  print("Message is : "..exception:getMessage())
  print("App Error code is : "..exception:getAppErrorCode())
  print("Http Error code is "..exception:getHttpErrorCode())
  print("Detail is : "..exception:getDetails())

  myData.maxsrch = loadedUser.search
  myData.maxrsc = loadedUser.rescue
  myData.user = loadedUser.user
  myData.theme = loadedUser.theme
  myData.credits = loadedUser.credits
  myData.roboSprite = loadedUser.robot
  myData.scienceSprite = loadedUser.science
  myData.musicVol = loadedUser.volume
  myData.sfx = loadedUser.sfx
  myData.savedkeys = loadedUser.keys
  myData.savedclocks = loadedUser.stopwatch

  local composer = require "composer"
  local options = {
        isModal = true,
    effect = "fade",
    time = 500
  }
  composer.gotoScene( "Splash" )
end