-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Function to create a highlight and billboard for a player
local function createHighlight(player)
    local character = player.Character
    if not character then return end

    -- Create a Highlight object
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.new(1, 0, 0) -- Red color
    highlight.OutlineColor = Color3.new(1, 1, 1) -- White outline
    highlight.Parent = character

    -- Create a BillboardGui to display the player's name on walls
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = player.Name
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.TextColor3 = Color3.new(1, 0, 0) -- Red text
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = billboard

    billboard.Parent = character
end

-- Function to remove highlights and billboards when a player leaves
local function onPlayerRemoved(player)
    local character = player.Character
    if character then
        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Highlight") or child:IsA("BillboardGui") then
                child:Destroy()
            end
        end
    end
end

-- Connect functions to events
Players.PlayerAdded:Connect(createHighlight)
Players.PlayerRemoving:Connect(onPlayerRemoved)

-- Handle existing players
for _, player in ipairs(Players:GetPlayers()) do
    createHighlight(player)
end
