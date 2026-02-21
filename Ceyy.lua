local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BASTOSaKO/Privatezz/refs/heads/main/Sbhshsh", true))()

local window = library:AddWindow("PRIMO •|• AUTO TRADE SCRIPT", {
	title_bar = {Color3.fromRGB(180, 0, 0), Color3.fromRGB(115, 0, 0), Color3.fromRGB(50, 0, 0)}, -- Title Bar Gradient (1-3 Colors)
	title_bar_transparency = 0.2, -- Title Bar transparency (0-1 with 1 being fully transparent)
	background = {Color3.fromRGB(0, 0, 0), Color3.fromRGB(34, 0, 0), Color3.fromRGB(68, 0, 0)}, -- (Background Gradient 1-3 Colors)
	background_transparency = 0.1, -- Background transparency (0-1 with 1 being fully transparent)
	main_color = Color3.fromRGB(255, 0, 0), -- Main Color for some Elements like Particles
	min_size = Vector2.new(420, 500), -- Size of the Window (vertically, horizontally)
	can_resize = true -- resizable (PC exclusive)
})

local PetsTab = window:AddTab("PetsTab")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--// Remote events
local tradingEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("tradingEvent")
local cPetShopRemote = ReplicatedStorage:WaitForChild("cPetShopRemote")
local cPetShopFolder = ReplicatedStorage:WaitForChild("cPetShopFolder")
local petEvolveEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("petEvolveEvent")

local selectedPlayer = nil
local selectedPet = nil -- unified variable for trade, hatch, evolve
local offerCount = 6

local autoTrading, autoTradeAll, autoHatch, autoEvolve = false, false, false, false
local autoTradeLoopRunning, autoTradeAllLoopRunning, autoHatchLoopRunning, autoEvolveLoopRunning = false, false, false, false

--// Helper functions
local function offerPet(petInstance)
    tradingEvent:FireServer("offerItem", petInstance)
end

local function offerMultiplePets(petName, count)
    local LocalPlayer = Players.LocalPlayer
    local petFolder = LocalPlayer:WaitForChild("petsFolder"):WaitForChild("Unique")
    local offered = 0
    for _, pet in ipairs(petFolder:GetChildren()) do
        if pet.Name == petName then
            offerPet(pet)
            offered += 1
            task.wait(0.05)
            if offered >= count then break end
        end
    end
end

local function performTrade(target)
    if not target or not selectedPet then return end
    tradingEvent:FireServer("sendTradeRequest", target)
    task.wait(0.2) -- slightly longer wait for server response
    offerMultiplePets(selectedPet, offerCount)
    task.wait(0.1)
    tradingEvent:FireServer("acceptTrade")
end

local function autoTradeLoop()
    if autoTradeLoopRunning then return end
    autoTradeLoopRunning = true
    while autoTrading do
        if selectedPlayer then
            performTrade(selectedPlayer)
        end
        task.wait(0.5)
    end
    autoTradeLoopRunning = false
end
local function autoTradeAllLoop()
    if autoTradeAllLoopRunning then return end
    autoTradeAllLoopRunning = true
    while autoTradeAll do
        if selectedPet then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    performTrade(player)
                    task.wait(0.2)
                end
            end
        end
        task.wait(1)
    end
    autoTradeAllLoopRunning = false
end

local function autoHatchLoop()
    if autoHatchLoopRunning then return end
    autoHatchLoopRunning = true
    while autoHatch and selectedPet do
        local petToOpen = cPetShopFolder:FindFirstChild(selectedPet)
        if petToOpen then
            local success, err = pcall(function()
                cPetShopRemote:InvokeServer(petToOpen)
            end)
            if not success then warn("Auto Hatch Error: "..err) end
        end
        task.wait(0.1)
    end
    autoHatchLoopRunning = false
end

local function autoEvolveLoop()
    if autoEvolveLoopRunning then return end
    autoEvolveLoopRunning = true
    while autoEvolve and selectedPet do
        local success, err = pcall(function()
            petEvolveEvent:FireServer("evolvePet", selectedPet)
        end)
        if not success then warn("Auto Evolve Error: "..err) end
        task.wait(0.1)
    end
    autoEvolveLoopRunning = false
end

PetsTab:AddLabel("Auto Trade & auto give pets & Auto Buy Pets").TextSize = 15

local petDropdown = PetsTab:AddDropdown("Select Pet", function(petName)
    selectedPet = petName
end)

local petsList = {
    "Neon Guardian","Blue Birdie","Blue Bunny","Blue Firecaster","Blue Pheonix",
    "Crimson Falcon","Cybernetic Showdown Dragon","Dark Golem","Dark Legends Manticore",
    "Dark Vampy","Darkstar Hunter","Eternal Strike Leviathan","Frostwave Legends Penguin",
    "Gold Warrior","Golden Pheonix","Golden Viking","Green Butterfly","Green Firecaster",
    "Infernal Dragon","Lightning Strike Phantom","Magic Butterfly","Muscle Sensei",
    "Orange Hedgehog","Orange Pegasus","Phantom Genesis Dragon","Purple Dragon",
    "Purple Falcon","Red Dragon","Red Firecaster","Red Kitty","Silver Dog",
    "Ultimate Supernova Pegasus","Ultra Birdie","White Pegasus","White Pheonix","Yellow Butterfly"
}

for _, petName in ipairs(petsList) do
    petDropdown:Add(petName)
end

PetsTab:AddSwitch("Auto Hatch Pet", function(state)
    autoHatch = state
    if state then task.spawn(autoHatchLoop) end
end)

PetsTab:AddSwitch("Auto Evolve Pet", function(state)
    autoEvolve = state
    if state then task.spawn(autoEvolveLoop) end
end)

PetsTab:AddLabel("Other").TextSize = 23

local playerDropdown = PetsTab:AddDropdown("Select Player", function(playerName)
    selectedPlayer = Players:FindFirstChild(playerName)
end)
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then playerDropdown:Add(player.Name) end
end
Players.PlayerAdded:Connect(function(player)
    if player ~= Players.LocalPlayer then playerDropdown:Add(player.Name) end
end)
Players.PlayerRemoving:Connect(function(player)
    playerDropdown:Remove(player.Name)
end)

PetsTab:AddSwitch("Auto Trade", function(state)
    autoTrading = state
    if state then task.spawn(autoTradeLoop) end
end)

PetsTab:AddSwitch("Auto Trade All", function(state)
    autoTradeAll = state
    if state then task.spawn(autoTradeAllLoop) end
end)

local Credits = window:AddTab("Credits")

Credits:AddLabel("Made By Primo")

Credits:AddLabel("        ")
Credits:AddLabel("•--- My Social Media ---•")
Credits:AddLabel(" Follow my TikTok account")

Credits:AddButton("Copy TikTok Link", function()
    setclipboard("https://www.tiktok.com/@primo_legitaccount").TextSize = 35
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "TikTok Link",
        Text = "Link copied to clipboard!",
        Duration = 3
    })
end)
Credits:AddLabel("Dm me here for more free script")

Credits:AddButton("Copy Facebook Link", function()
    setclipboard("https://www.facebook.com/profile.php?id=61576466431107").TextSize = 35
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Facebook Link",
        Text = "Link copied to clipboard!",
        Duration = 3
    })
end)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Linisin ang luma
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "PrimoTag" then v:Destroy() end
end

local function createTag()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local head = char:WaitForChild("Head", 15)

    -- Gagawa ng BillboardGui sa CoreGui (Safe Zone)
    local bgui = Instance.new("BillboardGui")
    bgui.Name = "PrimoTag"
    bgui.Parent = CoreGui
    bgui.Adornee = head
    
    -- PINAKALAKING SIZE: Ginawang 8,0,3,0 para higante ang text box
    bgui.Size = UDim2.new(10, 0, 7, 0) 
    bgui.StudsOffset = Vector3.new(0, 4.5, 0) -- Tinaas pa lalo para hindi sagabal sa view ng character
    bgui.AlwaysOnTop = true
    bgui.ExtentsOffset = Vector3.new(0, 1.5, 0)

    local tl = Instance.new("TextLabel")
    tl.Parent = bgui
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.Text = " " .. LocalPlayer.DisplayName .. " "
    tl.TextColor3 = Color3.new(1, 1, 1)
    tl.TextScaled = true -- Otomatikong lalakihan ang font base sa laki ng box
    tl.Font = Enum.Font.LuckiestGuy

    -- Mas makapal na outline para sa malaking text
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 4 
    stroke.Color = Color3.new(0, 0, 0)
    stroke.Parent = tl

    -- Rainbow Loop
    spawn(function()
        while bgui.Parent do
            local hue = tick() % 5 / 5
            tl.TextColor3 = Color3.fromHSV(hue, 0.9, 1)
            task.wait()
        end
    end)
end

-- Simulan ang script
createTag()

-- Kapag namatay o nag-respawn
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1.5)
    createTag()
end)

print("Super Giant NameTag Loaded!")
