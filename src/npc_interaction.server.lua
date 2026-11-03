-- NPC Interaction System

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Remote Events
local npcDialogueEvent = Instance.new("RemoteEvent")
npcDialogueEvent.Name = "NPCDialogueEvent"
npcDialogueEvent.Parent = ReplicatedStorage

-- NPC data
local npcs = {
    {
        name = "Garden Guide",
        dialogue = {
            "Welcome to the garden!",
            "I can help you grow your plants.",
            "Just click on them to interact."
        }
    }
}

-- Function to handle NPC interaction
local function handleNPCInteraction(player, npcId)
    if npcs[npcId] then
        local dialogue = npcs[npcId].dialogue
        npcDialogueEvent:FireClient(player, dialogue)
    end
end

-- Set up NPCs in the game
for i, npcData in ipairs(npcs) do
    local npc = game.Workspace:FindFirstChild(npcData.name)
    if npc then
        npc.Touched:Connect(function(hit)
            local player = Players:GetPlayerFromCharacter(hit.Parent)
            if player then
                handleNPCInteraction(player, i)
            end
        end)
    end
end

-- Player interaction
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Handle player interactions with NPCs
    end)
end)