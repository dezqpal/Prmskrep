--// MODERN KEY SYSTEM (UPGRADED BY GEMINI) \\--

local KEY = "UnoHub"
local TweenService = game:GetService("TweenService")

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local CornerBtn = Instance.new("UICorner")

-- UI Setup
ScreenGui.Name = "PrimoKeySystem"
ScreenGui.Parent = game.CoreGui -- Mas safe sa CoreGui para 'di madaling ma-delete ng scripts

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.Size = UDim2.new(0, 300, 0, 160)
MainFrame.BorderSizePixel = 0

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

UIStroke.Color = Color3.fromRGB(80, 80, 80)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Title
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "UNO HUB | KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

-- TextBox Style
TextBox.Parent = MainFrame
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.Position = UDim2.new(0.05, 0, 0.35, 0)
TextBox.Size = UDim2.new(0.9, 0, 0, 35)
TextBox.Font = Enum.Font.Gotham
TextBox.PlaceholderText = "Paste your key here..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 14
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

-- Submit Button Style
SubmitBtn.Name = "SubmitBtn"
SubmitBtn.Parent = MainFrame
SubmitBtn.BackgroundColor3 = Color3.fromRGB(45, 120, 255) -- Blue Theme
SubmitBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
SubmitBtn.Size = UDim2.new(0.9, 0, 0, 40)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Text = "SUBMIT KEY"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
CornerBtn.CornerRadius = UDim.new(0, 8)
CornerBtn.Parent = SubmitBtn

--// LOGIC WITH TWEENS \\--

SubmitBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == KEY then
        -- Success Animation
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 100) -- Change to green
        SubmitBtn.Text = "ACCESS GRANTED"
        
        task.wait(0.5)
        
        -- Smooth Fade Out
        TweenService:Create(MainFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0.6, -75), BackgroundTransparency = 1}):Play()
        TweenService:Create(UIStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
        
        task.wait(0.5)
        ScreenGui:Destroy()
        
        print("Key correct! Loading script...")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dezqpal/Prmskrep/refs/heads/main/UnObns.lua "))()
    else
        -- Error Animation
        SubmitBtn.Text = "INVALID KEY!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
        
        -- Shake effect
        local originalPos = MainFrame.Position
        for i = 1, 5 do
            MainFrame.Position = originalPos + UDim2.new(0, math.random(-5, 5), 0, 0)
            task.wait(0.05)
        end
        MainFrame.Position = originalPos
        
        task.wait(1)
        SubmitBtn.Text = "SUBMIT KEY"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(45, 120, 255)
        TextBox.Text = ""
    end
end)

-- Hover effect para sa button
SubmitBtn.MouseEnter:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(65, 140, 255)}):Play()
end)

SubmitBtn.MouseLeave:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45, 120, 255)}):Play()
end)
