-- Graphics and Visual Effects

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remote Events
local growthEvent = ReplicatedStorage:WaitForChild("GrowthEvent")
local npcDialogueEvent = ReplicatedStorage:WaitForChild("NPCDialogueEvent")
local shopEvent = ReplicatedStorage:WaitForChild("ShopEvent")

-- Function to create a visual effect for plant growth
local function createGrowthEffect(plant, growthStage)
    local effect = Instance.new("ParticleEmitter")
    effect.Name = "GrowthEffect"
    effect.Parent = plant

    -- Customize the effect based on growth stage
    if growthStage == 1 then
        effect.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
        effect.Size = NumberSequence.new(0.5)
    elseif growthStage == 2 then
        effect.Color = ColorSequence.new(Color3.fromRGB(0, 200, 0))
        effect.Size = NumberSequence.new(0.7)
    elseif growthStage == 3 then
        effect.Color = ColorSequence.new(Color3.fromRGB(0, 150, 0))
        effect.Size = NumberSequence.new(0.9)
    elseif growthStage == 4 then
        effect.Color = ColorSequence.new(Color3.fromRGB(0, 100, 0))
        effect.Size = NumberSequence.new(1.1)
    elseif growthStage == 5 then
        effect.Color = ColorSequence.new(Color3.fromRGB(0, 50, 0))
        effect.Size = NumberSequence.new(1.3)
    end

    effect.Lifetime = NumberRange.new(1, 2)
    effect.Rate = 10
    effect.Speed = NumberRange.new(1, 2)
    effect.Texture = "rbxassetid://24192287"
    effect.ZOffset = 2

    effect:Emit(10)
    wait(2)
    effect:Destroy()
end

-- Function to display NPC dialogue
local function displayNPCDialogue(dialogue)
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "NPCDialogue"
    billboardGui.Parent = character.Head
    billboardGui.Adornee = character.Head
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "DialogueText"
    textLabel.Parent = billboardGui
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0
    textLabel.Text = dialogue[1]
    textLabel.TextScaled = true

    local currentDialogue = 1
    humanoid.Died:Connect(function()
        billboardGui:Destroy()
    end)

    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
            currentDialogue = currentDialogue + 1
            if currentDialogue <= #dialogue then
                textLabel.Text = dialogue[currentDialogue]
            else
                billboardGui:Destroy()
            end
        end
    end)
end

-- Function to display shop UI
local function displayShopUI(items)
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ShopUI"
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Name = "ShopFrame"
    frame.Parent = screenGui
    frame.Size = UDim2.new(0.5, 0, 0.7, 0)
    frame.Position = UDim2.new(0.25, 0, 0.15, 0)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0

    local title = Instance.new("TextLabel")
    title.Name = "ShopTitle"
    title.Parent = frame
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Text = "Shop"
    title.TextScaled = true

    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ItemScrollFrame"
    scrollFrame.Parent = frame
    scrollFrame.Size = UDim2.new(1, 0, 0.8, 0)
    scrollFrame.Position = UDim2.new(0, 0, 0.1, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 5

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Name = "ItemListLayout"
    uiListLayout.Parent = scrollFrame
    uiListLayout.Padding = UDim.new(0, 5)

    for i, item in ipairs(items) do
        local itemButton = Instance.new("TextButton")
        itemButton.Name = "ItemButton"
        itemButton.Parent = scrollFrame
        itemButton.Size = UDim2.new(1, -10, 0, 50)
        itemButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        itemButton.BorderSizePixel = 0
        itemButton.TextColor3 = Color3.new(1, 1, 1)
        itemButton.Text = item.name .. " - " .. item.cost .. " coins"
        itemButton.TextScaled = true

        itemButton.MouseButton1Click:Connect(function()
            shopEvent:FireServer(i)
        end)
    end

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Parent = frame
    closeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    closeButton.Position = UDim2.new(0.4, 0, 0.9, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeButton.BorderSizePixel = 0
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Text = "Close"
    closeButton.TextScaled = true

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
end

-- Event connections
growthEvent.OnClientEvent:Connect(function(plantId, growthStage)
    local plant = game.Workspace:FindFirstChild(plantId)
    if plant then
        createGrowthEffect(plant, growthStage)
    end
end)

npcDialogueEvent.OnClientEvent:Connect(function(dialogue)
    displayNPCDialogue(dialogue)
end)

shopEvent.OnClientEvent:Connect(function(message, data)
    if message == "Welcome to the shop!" then
        displayShopUI(data)
    elseif message == "Purchase successful!" then
        print("You purchased: " .. data)
    elseif message == "Not enough coins!" then
        print(message)
    end
end)