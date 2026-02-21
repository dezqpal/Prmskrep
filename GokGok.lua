-- [[ PRIMO HUB - ANIMATED TITLE & BACKGROUND ]] --

local player = game:GetService("Players").LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- 1. SETTINGS
local MySecretKey = "PrimoOnTop" 

-- 2. SETUP SCREEN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PrimoHubUI"
ScreenGui.Parent = pgui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 3. MAIN WINDOW
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45) 
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(255, 255, 255) 
Stroke.Transparency = 0.5

-- 4. SNOW/PARTICLE EFFECT (IBINALIK KO NA ITO)
local function CreateParticle()
    local p = Instance.new("Frame")
    p.Size = UDim2.new(0, 2, 0, 2)
    p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    p.BackgroundTransparency = 0.4
    p.Position = UDim2.new(math.random(), 0, math.random(), 0)
    p.Parent = MainFrame
    Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
    
    task.spawn(function()
        while p.Parent do
            p:TweenPosition(UDim2.new(math.random(), 0, math.random(), 0), "Out", "Linear", 4)
            task.wait(4)
        end
    end)
end
for i = 1, 12 do CreateParticle() end

-- 5. TITLE BAR WITH TYPING EFFECT
local TitleBox = Instance.new("Frame")
TitleBox.Size = UDim2.new(0.8, 0, 0, 45)
TitleBox.Position = UDim2.new(0.1, 0, 0, 15)
TitleBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TitleBox.Parent = MainFrame
Instance.new("UICorner", TitleBox).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "" 
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBox

local function AnimateTitle()
    local fullText = "Primo Hub"
    while true do
        for i = 1, #fullText do
            Title.Text = string.sub(fullText, 1, i)
            task.wait(0.15)
        end
        task.wait(2)
        for i = #fullText, 0, -1 do
            Title.Text = string.sub(fullText, 1, i)
            task.wait(0.1)
        end
        task.wait(0.5)
    end
end
task.spawn(AnimateTitle)

-- 6. KEY SYSTEM BOX
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.85, 0, 0, 45)
KeyBox.Position = UDim2.new(0.075, 0, 0, 75)
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyBox.PlaceholderText = "Enter the Key..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = MainFrame
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 10)

-- 7. BUTTONS
local function CreateButton(pos, text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    return btn
end

local MainBtn = CreateButton(UDim2.new(0.075, 0, 0, 130), "Main Farm", Color3.fromRGB(80, 80, 80))
local FarmBtn = CreateButton(UDim2.new(0.075, 0, 0, 180), "Pack Farm", Color3.fromRGB(110, 110, 110))

-- 8. EXECUTION LOGIC
local function CheckAndRun(scriptType)
    if KeyBox.Text == MySecretKey then
        MainFrame.Visible = false 
        if scriptType == "Main" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/dezqpal/Primo/refs/heads/main/Prmkeysystem.lua"))()
        elseif scriptType == "Farm" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/dezqpal/Primo/refs/heads/main/v2Obsfucator.lua"))()
        end
        task.wait(1)
        ScreenGui:Destroy()
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "WRONG KEY!"
        task.wait(1)
        KeyBox.PlaceholderText = "Enter the Key..."
    end
end

MainBtn.MouseButton1Click:Connect(function() CheckAndRun("Main") end)
FarmBtn.MouseButton1Click:Connect(function() CheckAndRun("Farm") end)
