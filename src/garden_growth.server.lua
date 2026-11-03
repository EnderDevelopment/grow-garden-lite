-- Garden Growth System

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Configuration
local GROWTH_INTERVAL = 60 -- seconds
local MAX_GROWTH_STAGE = 5

-- Remote Events
local growthEvent = Instance.new("RemoteEvent")
growthEvent.Name = "GrowthEvent"
growthEvent.Parent = ReplicatedStorage

-- Plant data
local plants = {}

-- Function to grow a plant
local function growPlant(plantId)
    if plants[plantId] then
        plants[plantId].growthStage = math.min(plants[plantId].growthStage + 1, MAX_GROWTH_STAGE)
        growthEvent:FireAllClients(plantId, plants[plantId].growthStage)
    end
end

-- Function to create a new plant
local function createPlant(plantId, plantType)
    plants[plantId] = {
        type = plantType,
        growthStage = 0,
        lastGrown = os.time()
    }
    growPlant(plantId)
end

-- Main growth loop
while true do
    for plantId, plantData in pairs(plants) do
        if os.time() - plantData.lastGrown >= GROWTH_INTERVAL then
            growPlant(plantId)
            plantData.lastGrown = os.time()
        end
    end
    wait(10) -- Check every 10 seconds
end

-- Player interaction
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Handle player interactions with plants
    end)
end)