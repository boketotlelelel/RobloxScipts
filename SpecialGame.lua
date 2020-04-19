local round_time = 120
local intermission_time = 25
local warning_time = 10
local wait_time = .50

local maxKillers = 1
local maxSurvivors = 15

--Teams
local survivors = game.Teams.Survivors
local killers = game.Teams.Killer
local lobby = game.Teams.Witnesses



local Maps = {
	"Map01",
	"Map02"
	}

local map_choice = math.random(1, #Maps)

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



local function intermission_wait()
	print("Intermission")
	for count = 1, intermission_time do
		intermission_time =	intermission_time - 1
		wait(1)
		print(intermission_time)
	end
end

local function warning_countdown()
	print("WARNING, Game starting soon . . .")
	for count = 1, warning_time  do
		warning_time = warning_time - 1
		wait(1)
		print(warning_time)
	end
end

local function pickKillerandTeams()
	wait(5)
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
			print("You are on the survivor team --->", player)
	    end
	end
end


while true do
	intermission_wait()
	warning_countdown()
	pickKillerandTeams()
	
	local map_choice = math.random(1, #Maps)
	print(map_choice)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local MapToClone = ReplicatedStorage:WaitForChild(Maps[map_choice]):Clone()
	
	MapToClone.Parent = game.Workspace
	
	wait(15)
		
	MapToClone.Parent = nil

	repeat
		local currentTime = tick()
		local GameRunningTime = currentTime - RoundTimedStart
		wait(wait_time)
	until GameRunningTime > round_time

end