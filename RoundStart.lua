-- Initialize the Start Time
local RoundTimedStart 
local IntermissionTime = 10
local RoundTime = 10
local waitTime = .50
local roundCounter = 0

local playerHealth = 100
local killer_damage = 25

local diffeq = math.random(1, 10)
local map = game.Workspace.Crossroads
local Players = game:GetService("Players"):GetPlayers()

--Teams
local survivors = game.Teams.Survive
local killers = game.Teams.Kill

-- grabbing the spawn position
local Spawn_x = game.Workspace.Lobby.SpawnLocation1.Position.X
local Spawn_y = game.Workspace.Lobby.SpawnLocation1.Position.Y
local Spawn_z = game.Workspace.Lobby.SpawnLocation1.Position.Z

-- Teleportation
local TPort1 = {map.Teleport1.Position.X, map.Teleport1.Position.Y, map.Teleport1.Position.Z}
local TPort2 = {map.Teleport2.Position.X, map.Teleport2.Position.Y, map.Teleport2.Position.Z}
local KPort  = {map.KILLERSPOT.Position.X, map.KILLERSPOT.Position.Y, map.KILLERSPOT.Position.Z}

local maxKillers = 1
local maxSurvivors = 8


-- Local Functions
local function initialize()
	-- getting the current time
	RoundTimedStart = tick() 
end


local function len(arr)
	local Count = 0
	for Index in arr do
  		Count = Count + 1
	end
	return Count
end


local function pickKillerandTeams()
	wait(5)
	-- This function should randomly pick a killer
	for _, player in pairs(game.Players:GetPlayers()) do
	    math.randomseed(tick())
	    local count = math.random(1,10)
		print(count)
	    if count == 1 and len(killers) < maxKillers then
	        player.Team = killers
			print("The Killer for the round is ----> ", player)	
	    else
	        player.Team = survivors
			print("You are on the survivor team --->", player)
	    end
	end
end



local function intermission()
	-- countdown and wait for intermission time
	-- return the intermission time remaining
	print("Intermission Time")
	wait(IntermissionTime)
end



-- Teleport Function
local function TeleportPlayer(X,Y,Z)
	local target = CFrame.new(X,Y,Z) 
	for i, player in ipairs(game.Players:GetChildren()) do
   --Make sure the character exists and its HumanoidRootPart exists
   		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
       --add an offset of 5 for each character
     	 	player.Character.HumanoidRootPart.CFrame = target + Vector3.new(0, i * 5, 0)
   		end
	end
end


-- game loop
while true do	
	-- if the first spawn, show intermission
	
	if roundCounter < 1 then
		print("WELCOME TO THE LOBBY . . .")
		print("Killer will be picked soon . . .")
		intermission()
	end
	pickKillerandTeams()
	TeleportPlayer(TPort1[1], TPort1[2], TPort1[3])	
	print("Begin Round")
	initialize()
	repeat
		local currentTime = tick()
		local GameRunningTime = currentTime - RoundTimedStart
		wait(waitTime)
	until GameRunningTime > RoundTime
	print("End of Round")
	TeleportPlayer(Spawn_x, Spawn_y, Spawn_z)	
	intermission()
	roundCounter = roundCounter + 1
end