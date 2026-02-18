-- [[ CONFIGURATION ]]
local CorrectKey = "PrimoOnTop"

-- [[ UI CREATION ]]
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local VerifyBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Parent the GUI (Nilagay sa CoreGui para hindi ma-delete kapag namatay ang player)
if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end -- Proteksyon para sa Synapse users
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "BayotKeySystem"

-- Main Window Styling
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true 

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

-- Title Text
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "PALAUTOG KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- Input Box
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter Key Here..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)

local InputCorner = Instance.new("UICorner")
InputCorner.Parent = KeyInput

-- Verify Button
VerifyBtn.Parent = MainFrame
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
VerifyBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 35)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Text = "VERIFY"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local BtnCorner = Instance.new("UICorner")
BtnCorner.Parent = VerifyBtn

-- [[ LOGIC ]]
VerifyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        Title.Text = "ACCESS GRANTED!"
        Title.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        -- Animation bago mawala
        task.wait(1)
        ScreenGui:Destroy()
        
        -- FIXED LOADSTRING LOGIC
        print("Main Script Loading...")
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/dezqpal/Primo/refs/heads/main/CeyyOBFUSCATED.LUA"))()
        end)
        
        if not success then
            warn("Failed to load script: " .. tostring(err))
        end
        
    else
        Title.Text = "WRONG KEY!"
        Title.TextColor3 = Color3.fromRGB(255, 50, 50)
        KeyInput.Text = ""
        task.wait(1.5)
        Title.Text = "JACOB KEY SYSTEM"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)
