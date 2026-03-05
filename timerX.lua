local p = game:GetService("Players").LocalPlayer
local gui = p:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

-- Clean up old UI
if gui:FindFirstChild("PrimoQpal") then gui.PrimoQpal:Destroy() end

local sg = Instance.new("ScreenGui", gui)
sg.Name = "PrimoQpal"
sg.ResetOnSpawn = false
sg.DisplayOrder = 99

-- FIXED DRAG FUNCTION (Para hindi mag-lag sa Delta)
local function makeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    obj.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- PQ ICON (Toggle Button)
local toggle = Instance.new("TextButton", sg)
toggle.Size = UDim2.new(0, 50, 0, 50)
toggle.Position = UDim2.new(0, 15, 0.4, 0)
toggle.BackgroundColor3 = Color3.new(0,0,0)
toggle.Text = "PQ"
toggle.TextColor3 = Color3.new(0, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 20
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)
local tStroke = Instance.new("UIStroke", toggle)
tStroke.Color = Color3.new(0, 1, 1)
tStroke.Thickness = 2
makeDraggable(toggle)

-- MAIN WINDOW
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 230, 0, 260)
frame.Position = UDim2.new(0.5, -115, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Visible = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 15)
local fStroke = Instance.new("UIStroke", frame)
fStroke.Color = Color3.new(0, 1, 1)
fStroke.Thickness = 2
makeDraggable(frame)

-- TYPING TITLE
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = ""
title.TextColor3 = Color3.new(0, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.BackgroundTransparency = 1

-- STOPWATCH DISPLAY
local disp = Instance.new("TextLabel", frame)
disp.Size = UDim2.new(1, 0, 0, 70)
disp.Position = UDim2.new(0, 0, 0.25, 0)
disp.Text = "00:00.00"
disp.TextColor3 = Color3.new(1, 1, 1)
disp.Font = Enum.Font.Code
disp.TextSize = 38
disp.BackgroundTransparency = 1

-- CONTROLS
local startB = Instance.new("TextButton", frame)
startB.Size = UDim2.new(0, 190, 0, 45)
startB.Position = UDim2.new(0.5, -95, 0.58, 0)
startB.Text = "START"
startB.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
startB.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", startB)

local resetB = Instance.new("TextButton", frame)
resetB.Size = UDim2.new(0, 190, 0, 35)
resetB.Position = UDim2.new(0.5, -95, 0.82, 0)
resetB.Text = "RESET"
resetB.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
resetB.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", resetB)

-- TIMER LOGIC
local time = 0
local run = false

toggle.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

startB.MouseButton1Click:Connect(function()
    run = not run
    startB.Text = run and "PAUSE" or "RESUME"
    startB.BackgroundColor3 = run and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(0, 120, 0)
end)

resetB.MouseButton1Click:Connect(function()
    run = false
    time = 0
    startB.Text = "START"
    startB.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    disp.Text = "00:00.00"
end)

RunService.Heartbeat:Connect(function(dt)
    if run then
        time = time + dt
        disp.Text = string.format("%02d:%02d.%02d", math.floor(time/60), math.floor(time%60), math.floor((time*100)%100))
    end
end)

-- SAFE TYPING EFFECT
task.spawn(function()
    local name = "primo Qpal"
    while true do
        for i = 1, #name do
            title.Text = string.sub(name, 1, i)
            task.wait(0.15)
        end
        task.wait(3)
        title.Text = ""
        task.wait(0.5)
    end
end)

-- FIXED NOTIFICATION (No more syntax error)
game.StarterGui:SetCore("SendNotification", {
	Title = "ANTI AFK",
	Text = "Anti-AFK is now ACTIVATED - By Primo",
	Duration = 5
})

-- ANTI-AFK LOGIC
p.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

task.spawn(function()
    while task.wait(60) do
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(0.2)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)
