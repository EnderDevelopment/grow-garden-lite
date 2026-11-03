-- Shop System

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Remote Events
local shopEvent = Instance.new("RemoteEvent")
shopEvent.Name = "ShopEvent"
shopEvent.Parent = ReplicatedStorage

-- Shop items
local shopItems = {
    {
        name = "Basic Seed",
        cost = 10,
        description = "A basic seed for growing plants."
    },
    {
        name = "Premium Seed",
        cost = 50,
        description = "A premium seed for faster growth."
    }
}

-- Function to handle item purchase
local function handleItemPurchase(player, itemId)
    if shopItems[itemId] then
        local item = shopItems[itemId]
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local coins = leaderstats:FindFirstChild("Coins")
            if coins and coins.Value >= item.cost then
                coins.Value = coins.Value - item.cost
                -- Give the player the item
                shopEvent:FireClient(player, "Purchase successful!", item.name)
            else
                shopEvent:FireClient(player, "Not enough coins!")
            end
        end
    end
end

-- Set up shop
local shop = game.Workspace:FindFirstChild("Shop")
if shop then
    shop.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)
        if player then
            shopEvent:FireClient(player, "Welcome to the shop!", shopItems)
        end
    end)
end

-- Player interaction
Players.PlayerAdded:Connect(function(player)
    -- Initialize leaderstats
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local coins = Instance.new("IntValue")
    coins.Name = "Coins"
    coins.Value = 100 -- Starting coins
    coins.Parent = leaderstats

    -- Handle player interactions with the shop
end)