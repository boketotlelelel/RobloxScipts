local RoundTimeStart
local round_time = 120
local intermission_time = 10
local warning_time = 5
local wait_time = .50
local round_map
local rand_choice
local maxKillers = 1
local maxSurvivors = 15
--Teams
local survivors = game.Teams.Survivors
local killers = game.Teams.Killer
local lobby = game.Teams.Witnesses

local players = game:GetService("Players")


local TPort1 
local TPort2 
local TPort3 
local TPort4 
local KPort
------------Sounds-------------
local LobbySounds = {
	"rbxassetid://432472104",
	"rbxassetid://709122469"
}

local GameSounds = {
	"rbxassetid://155791979",
	"rbxassetid://877670289",
	"rbxassetid://245939390",
	"rbxassetid://4439690368"
	
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

local function getNumberOfPlayers()
    return #players:GetPlayers()
end

local function pickKillerandTeams()
	--The bracketed Players is a string. Sorry, I can not use quotes on mobile
	local player_num = getNumberOfPlayers()
	-- This function should randomly pick a killer
	for _, player in pairs(game.Players:GetPlayers()) do
		
	    local count = math.random(1, player_num)
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
     	 	player.Character.HumanoidRootPart.CFrame = target + Vector3.new(0, 0,0)
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
	round_map = pickMap()
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
	
	
	TPort1 = {map.TPort1.Position.X, map.TPort1.Position.Y, map.TPort1.Position.Z}
	TPort2 = {map.TPort2.Position.X, map.TPort2.Position.Y, map.TPort2.Position.Z}
	TPort3 = {map.TPort3.Position.X, map.TPort3.Position.Y, map.TPort3.Position.Z}
	TPort4 = {map.TPort4.Position.X, map.TPort4.Position.Y, map.TPort4.Position.Z}
	KPort  = {map.KTPort.Position.X, map.KTPort.Position.Y, map.KTPort.Position.Z}

	
	for _, player in ipairs(game.Players:GetChildren()) do
		local count = math.random(1,10)
		print(count)
		
		if player.Team == survivors then
			if count <= 2 then
				TeleportPlayer(TPort1[1], TPort1[2], TPort1[3])	
			elseif count > 2 and count <=4 then 
				TeleportPlayer(TPort2[1], TPort2[2], TPort2[3])
			elseif count > 4 and count <=6 then 	
				TeleportPlayer(TPort3[1], TPort3[2], TPort3[3])	
			elseif count > 6 and count <=8 then 
				TeleportPlayer(TPort4[1], TPort4[2], TPort4[3])
			elseif count <= 10 and count >= 9 then 
				TeleportPlayer(TPort2[1], TPort2[2], TPort2[3])
			end					
		else
			TeleportPlayer(KPort[1], KPort[2], KPort[3])
		end
	end
	rand_choice = math.random(1, #GameSounds)
	playMusic(GameSounds, rand_choice)
	
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