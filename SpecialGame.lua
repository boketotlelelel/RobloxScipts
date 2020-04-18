local RoundTimedStart 
local IntermissionTime = 30
local game_start_warning = 10
local RoundTime = 5
local roundCounter = 0
local round_counter = 0 

local diffeq = math.random(1, 10)
local map = game.Workspace.Crossroads
local Players = game:GetService("Players"):GetPlayers()
local Lobby = game.Workspace.Lobby

--Teams
local survivors = game.Teams.Survivors
local killers = game.Teams.Killer
local lobby = game.Teams.Witnesses

-- Teleportation (NEEDS TO BE DONE FOR THE MAP)
local LobbySpawn = {Lobby.SpawnLocation.Position.X, Lobby.SpawnLocation.Position.Y, Lobby.SpawnLocation.Position.Z}
local TPort1 = {map.Teleport1.Position.X, map.Teleport1.Position.Y, map.Teleport1.Position.Z}
local TPort2 = {map.Teleport2.Position.X, map.Teleport2.Position.Y, map.Teleport2.Position.Z}
local KPort  = {map.KILLERSPOT.Position.X, map.KILLERSPOT.Position.Y, map.KILLERSPOT.Position.Z}

local maxKillers = 1
local maxSurvivors = 8

-- add songs here
local Sounds = {
	"rbxassetid://1841580829",
	"rbxassetid://1838264699",
	"rbxassetid://1841600954",
	"rbxassetid://1846706224",
	"rbxassetid://4566170647",
	"rbxassetid://304235605"
	
	}
	
	
local sounds = game.Workspace.Sound
local audioID = sounds.SoundId
local music = Instance.new("Sound", game.Workspace)


	
local function playMusic(count)
	local id = Sounds[count]
	music.SoundId = id
	print(id)
	music:Play()
end

-- Local Functions
local function initialize()
	-- getting the current time
	RoundTimedStart = tick() 
end


local function len(arr)
	local teams = game:GetService("Teams"):GetTeams()
	for _, team in pairs(teams) do
		local players = team:GetPlayers()	
		return #players
	end
end


local function initialize()
	-- getting the current time
	RoundTimedStart = tick() 
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




local function pickKillerandTeams()
	wait(5)
	-- This function should randomly pick a killer
	for _, player in pairs(game.Players:GetPlayers()) do
	    math.randomseed(tick())
	    local count = math.random(1,10)
	    if count == 1 and len(killers) <= maxKillers then
	        player.Team = killers
			print("The Killer for the round is ----> ", player)	
	    else
	        player.Team = survivors
			print("You are on the survivor team --->", player)
	    end
	end
end

