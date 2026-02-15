--// SETTINGS \\--
local CORRECT_KEY = "Primo"
local SCRIPT_URL = "https://raw.githubusercontent.com/dezqpal/Primo/refs/heads/main/PRMobfuscated.lua"

--// UI CONSTRUCT \\--
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local DropShadow = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local BtnCorner = Instance.new("UICorner")
local StatusLabel = Instance.new("TextLabel")

-- Parent to Player
ScreenGui.Name = "OmirpKeySystem"
ScreenGui.Parent = game.CoreGui -- Mas safe sa CoreGui para 'di madaling ma-delete sa Explorer

-- Main Frame Design
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.BorderSizePixel = 0

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "BAYOT VERIFICATION"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- Input Field
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter Access Key..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14

local InputCorner = Instance.new("UICorner", KeyInput)
InputCorner.CornerRadius = UDim.new(0, 8)

-- Submit Button
SubmitBtn.Parent = MainFrame
SubmitBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 255) -- Modern Blue
SubmitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 40)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Text = "SUBMIT"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
SubmitBtn.AutoButtonColor = true

BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = SubmitBtn

-- Status Label
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.88, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Waiting for input..."
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 11

--// LOGIC & ANIMATIONS \\--

local function notify(msg, color)
    StatusLabel.Text = msg
    StatusLabel.TextColor3 = color
end

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        notify("Access Granted! Loading...", Color3.fromRGB(100, 255, 100))
        SubmitBtn.Text = "Success!"
        
        -- Smooth fade out animation bago i-destroy
        local TweenService = game:GetService("TweenService")
        local info = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainFrame, info, {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1})
        
        tween:Play()
        tween.Completed:Connect(function()
            ScreenGui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/dezqpal/Primo/refs/heads/main/PRMx.lua "))()
        end)
    else
        notify("Invalid Key! Try again.", Color3.fromRGB(255, 100, 100))
        KeyInput.Text = ""
        
        -- Shake effect (Optional/Aesthetic)
        local originalPos = MainFrame.Position
        for i = 1, 5 do
            MainFrame.Position = originalPos + UDim2.new(0, math.random(-5,5), 0, 0)
            task.wait(0.02)
        end
        MainFrame.Position = originalPos
    end
end)
