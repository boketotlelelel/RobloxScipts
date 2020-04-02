local lobby = game.Workspace.Test_Caben1
local playerSpawn = game.Workspace.PLAYERSPAWN.Position

local TPort1 = {playerSpawn.X, playerSpawn.Y, playerSpawn.Z}
-- FUNCTIONS

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
local maxPlayer = 8


local enemy = game.ServerStorage["Drooling Zombie"]
local spawn = game.Workspace.SpawnDoor1.SPAWNDOOR
local multiplier = 2
local zombieCounter = 10
	
local function playMusic(count)
	local id = Sounds[count]
	music.SoundId = id
	music:Play()
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


local function spawnZombies(counter)
	for i = 0, counter do
		local clone = enemy:Clone()
		clone.Parent = game.Workspace
		clone:MoveTo(spawn.Position)
		wait(10)
	end
end


wait(10)
TeleportPlayer(TPort1[1], TPort1[2], TPort1[3])

local count = math.random(1, table.getn(Sounds))
local counter = 10
playMusic(count)


spawnZombies(counter)