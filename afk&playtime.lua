-- [[ SERVICES ]]
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- [[ VARIABLES ]]
local startTime = tick()
local lastInputTime = tick()

-- [[ UI CREATION ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PrimoSimpleTracker"
ScreenGui.Parent = CoreGui

-- STATS HUD (Simple Design)
local StatsFrame = Instance.new("Frame")
StatsFrame.Size = UDim2.new(0, 180, 0, 70)
StatsFrame.Position = UDim2.new(0, 15, 0.4, 0) -- Nasa kaliwang bahagi ng screen
StatsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
StatsFrame.BackgroundTransparency = 0.3
StatsFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = StatsFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Thickness = 1
Stroke.Transparency = 0.7
Stroke.Parent = StatsFrame

-- PLAYTIME LABEL
local PlaytimeLabel = Instance.new("TextLabel")
PlaytimeLabel.Size = UDim2.new(1, 0, 0.5, 0)
PlaytimeLabel.BackgroundTransparency = 1
PlaytimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlaytimeLabel.Font = Enum.Font.GothamBold
PlaytimeLabel.TextSize = 14
PlaytimeLabel.Text = "Playtime: 00:00:00"
PlaytimeLabel.Parent = StatsFrame

-- AFK TIMER LABEL
local AfkLabel = Instance.new("TextLabel")
AfkLabel.Size = UDim2.new(1, 0, 0.5, 0)
AfkLabel.Position = UDim2.new(0, 0, 0.5, 0)
AfkLabel.BackgroundTransparency = 1
AfkLabel.TextColor3 = Color3.fromRGB(255, 80, 80) -- Red kapag AFK
AfkLabel.Font = Enum.Font.GothamBold
AfkLabel.TextSize = 14
AfkLabel.Text = "IDLE: 00:00:00"
AfkLabel.Visible = false -- Lalabas lang pag naka-AFK
AfkLabel.Parent = StatsFrame

-- [[ FUNCTIONS ]]
local function formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    return string.format("%02d:%02d:%02d", h, m, s)
end

-- Detect Activity (Keyboard, Mouse, Click)
UserInputService.InputBegan:Connect(function()
    lastInputTime = tick()
end)

-- Main Loop (Update every frame)
RunService.RenderStepped:Connect(function()
    -- 1. Update Playtime (Total time since script started)
    local playDuration = tick() - startTime
    PlaytimeLabel.Text = "Playtime: " .. formatTime(playDuration)
    
    -- 2. Update AFK (Idle time)
    local idleDuration = tick() - lastInputTime
    
    if idleDuration >= 5 then -- Magpapakita pagka 5 seconds na walang galaw
        AfkLabel.Visible = true
        AfkLabel.Text = "AFK: " .. formatTime(idleDuration)
    else
        AfkLabel.Visible = false
    end
end)

print("Primo Playtime & AFK Tracker Loaded!")
