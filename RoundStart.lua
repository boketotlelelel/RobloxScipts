-- Initialize the Start Time
local RoundTimedStart 
local IntermissionTime = 10
local RoundTime = 10
local waitTime = .50
local roundCounter = 0
local diffeq = math.random(1, 10)
local map = game.Workspace.Crossroads

-- grabbing the spawn position
local Spawn_x = game.Workspace.Lobby.SpawnLocation1.Position.X
local Spawn_y = game.Workspace.Lobby.SpawnLocation1.Position.Y
local Spawn_z = game.Workspace.Lobby.SpawnLocation1.Position.Z

-- Teleportation
local TPort1 = {map.Teleport1.Position.X, map.Teleport1.Position.Y, map.Teleport1.Position.Z}
local TPort2 = {map.Teleport2.Position.X, map.Teleport2.Position.Y, map.Teleport2.Position.Z}
local KPort  = {map.KILLERSPOT.Position.X, map.KILLERSPOT.Position.Y, map.KILLERSPOT.Position.Z}

-- Local teams
local survivers
local killer

-- Local Functions
local function initialize()
	-- getting the current time
	RoundTimedStart = tick() 
end


local function pickKiller()
	wait(10)
	-- This function should randomly pick a killer
	local Players = game:GetService("Players"):GetPlayers()
	local randomPlayer
	if #Players > 0 then
	    randomPlayer = Players[math.random(#Players)]
	end	
	killer = randomPlayer
	
	return killer
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
	killer = pickKiller()
	print("The Killer for the round is ----> ", killer)	
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