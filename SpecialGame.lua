local RoundTimeStart
local round_time = 120
local intermission_time = 25
local warning_time = 10
local wait_time = .50
local round_map
local rand_choice
local maxKillers = 1
local maxSurvivors = 15
--Teams
local survivors = game.Teams.Survivors
local killers = game.Teams.Killer
local lobby = game.Teams.Witnesses


local TPort1 
local TPort2 
local TPort3
local TPort4

------------Sounds-------------
local LobbySounds = {
	"rbxassetid://1841580829",
	"rbxassetid://4566170647"
}

local GameSounds = {
	"rbxassetid://1838264699",
	"rbxassetid://1841600954",
	"rbxassetid://1846706224",
	"rbxassetid://304235605"
	
	}
local sounds = game.Workspace.Sound	
local audioID = sounds.SoundId
local music = Instance.new("Sound", game.Workspace)
------------Sounds-------------	
	
------------MAPS-------------	
local Maps = {
	"Map01",
	"Map02"
	}
------------MAPS-------------
local function initialize()
	-- getting the current time
	RoundTimeStart = tick() 
end


local function playMusic(arr, count)
	local id = arr[count]
	music.SoundId = id
	music:Play()
end

local function len(arr)
	local teams = game:GetService("Teams"):GetTeams()
	for _, team in pairs(teams) do
		local players = team:GetPlayers()	
		return #players
	end
end



local function intermission_wait()
	playMusic(LobbySounds, 1)
	print("Intermission")
	for count = 1, intermission_time do
		intermission_time =	intermission_time - 1
		wait(1)
		print(intermission_time)
	end
	music:Stop()
end

local function warning_countdown()
	playMusic(LobbySounds, 2)
	print("WARNING, Game starting soon . . .")
	for count = 1, warning_time  do
		warning_time = warning_time - 1
		wait(1)
		print(warning_time)
	end
	music:Stop()
end

local function pickKillerandTeams()
	-- This function should randomly pick a killer
	for _, player in pairs(game.Players:GetPlayers()) do
	    math.randomseed(tick())
	    local count = math.random(1, len(player))
		print (count)
	    if count == 1 and len(killers) <= maxKillers then
	        player.Team = killers
			print("The Killer for the round is ----> ", player)	
	    else
	        player.Team = survivors
			print("You are on the survivor team ---->", player)
	    end
	end
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


local function pickMap()
	local map_choice = math.random(1, #Maps)
    round_map = Maps[map_choice]
	return round_map
end


local function RoundStart()
	initialize()
	rand_choice = math.random(1, #GameSounds)
	playMusic(GameSounds, rand_choice)
	round_map = pickMap()
	print(round_map)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local MapToClone = ReplicatedStorage:WaitForChild(round_map):Clone()
	MapToClone.Parent = game.Workspace
	
	local map
	if round_map == "Map01" then
		map = game.Workspace.Map01
	elseif round_map == "Map02" then
		map = game.Workspace.Map02
	end
	
	wait(5)
	print("ROUND IS STARTING . . . ")
	
	local TPort1 = {map.TPort1.Position.X, map.TPort1.Position.Y, map.TPort1.Position.Z}
	local TPort2 = {map.TPort2.Position.X, map.TPort2.Position.Y, map.TPort2.Position.Z}
	local TPort3 = {map.TPort3.Position.X, map.TPort3.Position.Y, map.TPort3.Position.Z}
	local TPort4 = {map.TPort4.Position.X, map.TPort4.Position.Y, map.TPort4.Position.Z}
	
	local randon_tport = math.random(1, 4) --change whenever the number of tport spawns is set in stone
	local TPORT = "TPort1"
	TPORT = TPORT:gsub("1", tostring(randon_tport))
	
	print(TPORT)
	
	TeleportPlayer(TPORT[1], TPORT[2], TPORT[3])
	
	wait(round_time)
	MapToClone.Parent = nil
	music:Stop()
end

while true do
	intermission_wait()
	warning_countdown()
	pickKillerandTeams()
	RoundStart()
end