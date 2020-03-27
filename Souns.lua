local sounds = game.Workspace.Sound
local audioID = sounds.SoundId


-- sounds
local sounds = game.Workspace.Sound
local audioID = sounds.SoundId

-- add songs here
local Sounds = {
	"rbxassetid://1841580829",
	"rbxassetid://1838264699",
	"rbxassetid://1841600954",
	"rbxassetid://1846706224"}
	


local count = math.random(1, table.getn(Sounds))
print(count)
print(Sounds[count])
local id = Sounds[count]
local music = Instance.new("Sound", game.Workspace)
music.SoundId = id
music:Play()
