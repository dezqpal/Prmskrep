local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()

local window = library:AddWindow("Kyiel Paid v=1", {
	main_color = Color3.fromRGB(255, 0, 0), -- Color
	min_size = Vector2.new(500, 700), -- Size of the gui
	can_resize = false, -- true or false
})

local rebirths = window:AddTab("Rebirths")

rebirths:AddTextBox("Rebirth Target", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        updateStats() -- Call the stats update function
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Objetivo Actualizado",
            Text = "Nuevo objetivo: " .. tostring(targetRebirthValue) .. " renacimientos",
            Duration = 0
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Size",
            Text = "Put a size larger than 0",
            Duration = 0
        })
    end
end)

local infiniteSwitch

local targetSwitch = rebirths:AddSwitch("Auto Rebirth Target", function(bool)
    _G.targetRebirthActive = bool
    
    if bool then
        if _G.infiniteRebirthActive and infiniteSwitch then
            infiniteSwitch:Set(false)
            _G.infiniteRebirthActive = false
        end
        
        spawn(function()
            while _G.targetRebirthActive and wait(0.1) do
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                
                if currentRebirths >= targetRebirthValue then
                    targetSwitch:Set(false)
                    _G.targetRebirthActive = false
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¡Objetivo Alcanzado!",
                        Text = "Has alcanzado " .. tostring(targetRebirthValue) .. " renacimientos",
                        Duration = 5
                    })
                    
                    break
                end
                
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end, "automatic rebirth until reaching the goal")

infiniteSwitch = rebirths:AddSwitch("Auto Rebirth (Infinitely)", function(bool)
    _G.infiniteRebirthActive = bool
    
    if bool then
        if _G.targetRebirthActive and targetSwitch then
            targetSwitch:Set(false)
            _G.targetRebirthActive = false
        end
        
        spawn(function()
            while _G.infiniteRebirthActive and wait(0.1) do
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end, "rebirth infinitely")

local sizeSwitch = rebirths:AddSwitch("Auto Size 1", function(bool)
    _G.autoSizeActive = bool
    
    if bool then
        spawn(function()
            while _G.autoSizeActive and wait() do
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
            end
        end)
    end
end, "Size 1")

local teleportSwitch = rebirths:AddSwitch("Auto Teleport to Muscle King", function(bool)
    _G.teleportActive = bool
    
    if bool then
        spawn(function()
            while _G.teleportActive and wait() do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end
        end)
    end
end, "Tp to Mk")

local autoEquipToolsFolder = rebirths:AddFolder("Auto Equip Tools")

autoEquipToolsFolder:AddButton("Gamepass AutoLift", function()
    local gamepassFolder = game:GetService("ReplicatedStorage").gamepassIds
    local player = game:GetService("Players").LocalPlayer
    for _, gamepass in pairs(gamepassFolder:GetChildren()) do
        local value = Instance.new("IntValue")
        value.Name = gamepass.Name
        value.Value = gamepass.Value
        value.Parent = player.ownedGamepasses
    end
end, "Unlock AutoLift Passe")

autoEquipToolsFolder:AddSwitch("Auto Weight", function(Value)
    _G.AutoWeight = Value
    
    if Value then
        local weightTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
        if weightTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(weightTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Weight")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoWeight do
            if not _G.AutoWeight then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Auto Weight")

autoEquipToolsFolder:AddSwitch("Auto Pushups", function(Value)
    _G.AutoPushups = Value
    
    if Value then
        local pushupsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups")
        if pushupsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(pushupsTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Pushups")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoPushups do
            if not _G.AutoPushups then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Auto Pushups")

autoEquipToolsFolder:AddSwitch("Auto Handstands", function(Value)
    _G.AutoHandstands = Value
    
if Value then
        local handstandsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Handstands")
        if handstandsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(handstandsTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Handstands")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoHandstands do
            if not _G.AutoHandstands then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Auto Handstands")

autoEquipToolsFolder:AddSwitch("Auto Situps", function(Value)
    _G.AutoSitups = Value
    
    if Value then
        local situpsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Situps")
        if situpsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(situpsTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Situps")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoSitups do
            if not _G.AutoSitups then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Auto Abdominals")

autoEquipToolsFolder:AddSwitch("Auto Punch", function(Value)
    _G.fastHitActive = Value
    
    if Value then
        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end
                
                local player = game.Players.LocalPlayer
                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end
                end
                task.wait(0.1)
            end
        end)
        
        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end
                
                local player = game.Players.LocalPlayer
                player.muscleEvent:FireServer("punch", "rightHand")
                player.muscleEvent:FireServer("punch", "leftHand")
                
                local character = player.Character
                if character then
                    local punchTool = character:FindFirstChild("Punch")
                    if punchTool then
                        punchTool:Activate()
                    end
                end
                task.wait(0)
            end
        end)
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Punch")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end

    end, "Auto Punch")

autoEquipToolsFolder:AddSwitch("Fast Tools", function(Value)
    _G.FastTools = Value
    
    local defaultSpeeds = {
        {
            "Punch",
            "attackTime",
            Value and 0 or 0.35
        },
        {
            "Ground Slam",
            "attackTime",
            Value and 0 or 6
        },
        {
            "Stomp",
            "attackTime",
            Value and 0 or 7
        },
        {
            "Handstands",
            "repTime",
            Value and 0 or 1
        },
        {
            "Pushups",
            "repTime",
            Value and 0 or 1
        },
        {
            "Weight",
            "repTime",
            Value and 0 or 1
        },
        {
            "Situps",
            "repTime",
            Value and 0 or 1
        }
    }
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    for _, toolInfo in ipairs(defaultSpeeds) do
        local tool = backpack:FindFirstChild(toolInfo[1])
        if tool and tool:FindFirstChild(toolInfo[2]) then
            tool[toolInfo[2]].Value = toolInfo[3]
        end
        
        local equippedTool = player.Character and player.Character:FindFirstChild(toolInfo[1])
        if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
            equippedTool[toolInfo[2]].Value = toolInfo[3]
        end
    end
end, "Speed up all tools")

local FarmingTab = window:AddTab("Rock")


FarmingTab:AddLabel("Rocks:").TextSize = 22

local function gettool()
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    local player = game:GetService("Players").LocalPlayer
    player.muscleEvent:FireServer("punch", "leftHand")
    player.muscleEvent:FireServer("punch", "rightHand")
end

local rockData = {
    ["Tiny Rock - 0"] = 0,
    ["Large Rock - 100"] = 100,
    ["Punching Rock - 10"] = 10,
    ["Golden Rock - 5k"] = 5000,
    ["Frost Rock - 150k"] = 150000,
    ["Mythical Rock - 400k"] = 400000,
    ["Eternal Rock - 750k"] = 750000,
    ["Legend Rock - 1m"] = 1000000,
    ["Muscle King Rock - 5m"] = 5000000,
    ["Jungle Rock - 10m"] = 10000000
}

local selectedRock = nil

local rockDropdown = FarmingTab:AddDropdown("Select Rock", function(selection)
    selectedRock = selection
end)

for rockName in pairs(rockData) do
    rockDropdown:Add(rockName)
end

local autoRockSwitch = FarmingTab:AddSwitch("Auto Rock", function(enabled)
    getgenv().RockFarmRunning = enabled

    if enabled and selectedRock then
        task.spawn(function()
            local requiredDurability = rockData[selectedRock]
            local player = game:GetService("Players").LocalPlayer

            while getgenv().RockFarmRunning do
                task.wait()
                if player.Durability.Value >= requiredDurability then
                    for _, v in pairs(workspace.machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == requiredDurability and
                            player.Character:FindFirstChild("LeftHand") and
                            player.Character:FindFirstChild("RightHand") then

                            local rock = v.Parent:FindFirstChild("Rock")
                            if rock then
                                firetouchinterest(rock, player.Character.RightHand, 0)
                                firetouchinterest(rock, player.Character.RightHand, 1)
                                firetouchinterest(rock, player.Character.LeftHand, 0)
                                firetouchinterest(rock, player.Character.LeftHand, 1)
                                gettool()
                            end
                        end
                    end
                end
            end
        end)
    end
end)

local teleport = window:AddTab("teleportrock")

teleport:AddButton("Spawn", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2, 8, 115)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Spawn",
        Duration = 0
    })
end)

teleport:AddButton("Secret Area", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(1947, 2, 6191)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Secret Area",
        Duration = 0
    })
end)

teleport:AddButton("Tiny Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-34, 7, 1903)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Tiny Island",
        Duration = 0
    })
end)


teleport:AddButton("Frozen Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(- 2600.00244, 3.67686558, - 403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, - 3.7464023e-09, - 0.99617666, 3.09302628e-08, 0.0873617008)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Frozen Island",
        Duration = 0
    })
end)

teleport:AddButton("Mythical Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2255, 7, 1071)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Mythical Island",
        Duration = 0
    })
end)

teleport:AddButton("Hell Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-6768, 7, -1287)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Hell Island",
        Duration = 0
    })
end)

teleport:AddButton("Legend Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4604, 991, -3887)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Legend Island",
        Duration = 0
    })
end)

teleport:AddButton("Muscle King Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8646, 17, -5738)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Muscle King",
        Duration = 0
    })
end)

teleport:AddButton("Jungle Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8659, 6, 2384)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Jungle Island",
        Duration = 0
    })
end)

teleport:AddButton("Brawl Lava", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4471, 119, -8836)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Brawl Lava",
        Duration = 0
    })
end)

teleport:AddButton("Brawl Desert", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(960, 17, -7398)
    
game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Brawl Desert",
        Duration = 0
    })
end)

local PackFarm = window:AddTab("Farming")

getgenv()._AutoRepFarmEnabled = false  

-- Switch en la librería
PackFarm:AddSwitch("Fast Strenght", function(state)
    getgenv()._AutoRepFarmEnabled = state
    warn("[Auto Rep Farm] Estado cambiado a:", state and "ON" or "OFF")
end)

-- Servicios
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

-- Configuración
local PET_NAME = "Swift Samurai"
local ROCK_NAME = "Rock5M"
local PROTEIN_EGG_NAME = "ProteinEgg"
local PROTEIN_EGG_INTERVAL = 30 * 60
local REPS_PER_CYCLE = 40
local REP_DELAY = 0.01
local ROCK_INTERVAL = 5
local MAX_PING = 5000   -- si pasa esto, pausa
local MIN_PING = 100   -- si baja de esto, reanuda

-- Variables internas
local HumanoidRootPart
local lastProteinEggTime = 0
local lastRockTime = 0

-- Funciones
local function getPing()
    local success, ping = pcall(function()
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    return success and ping or 999
end

local function updateCharacterRefs()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    HumanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
end

local function equipPet()
    local petsFolder = LocalPlayer:FindFirstChild("petsFolder")
    if petsFolder and petsFolder:FindFirstChild("Unique") then
        for _, pet in pairs(petsFolder.Unique:GetChildren()) do
            if pet.Name == PET_NAME then
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
                break
            end
        end
    end
end

local function eatProteinEgg()
    if LocalPlayer:FindFirstChild("Backpack") then
        for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
            if item.Name == PROTEIN_EGG_NAME then
                ReplicatedStorage.rEvents.eatEvent:FireServer("eat", item)
                break
            end
        end
    end
end

local function hitRock()
    local rock = workspace:FindFirstChild(ROCK_NAME)
    if rock and HumanoidRootPart then
        HumanoidRootPart.CFrame = rock.CFrame * CFrame.new(0, 0, -5)
        ReplicatedStorage.rEvents.hitEvent:FireServer("hit", rock)
    end
end

-- Loop principal (siempre corriendo)
task.spawn(function()
    updateCharacterRefs()
    equipPet()
    lastProteinEggTime = tick()
    lastRockTime = tick()

    local farmingPaused = false

    while true do
        if getgenv()._AutoRepFarmEnabled then
            local ping = getPing()

            -- Pausa si ping alto
            if ping > MAX_PING then
                if not farmingPaused then
                    warn("[Auto Rep Farm] Ping alto ("..math.floor(ping).."ms), pausando farmeo...")
                    farmingPaused = true
                end
            end

            -- Reanuda si ping bajo
            if ping <= MIN_PING then
                if farmingPaused then
                    warn("[Auto Rep Farm] Ping bajo ("..math.floor(ping).."ms), reanudando farmeo...")
                    farmingPaused = false
                end
            end

            -- Solo farmea si no está pausado
            if not farmingPaused then
                if LocalPlayer:FindFirstChild("muscleEvent") then
                    for i = 1, REPS_PER_CYCLE do
                        LocalPlayer.muscleEvent:FireServer("rep")
                    end
                end

                if tick() - lastProteinEggTime >= PROTEIN_EGG_INTERVAL then
                    eatProteinEgg()
                    lastProteinEggTime = tick()
                end

                if tick() - lastRockTime >= ROCK_INTERVAL then
                    hitRock()
                    lastRockTime = tick()
                end
            end
        end

        task.wait(REP_DELAY)
    end
end)

PackFarm:AddButton("Jungle Squat", function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    hrp.CFrame = CFrame.new(-8371.4336, 6.7981, 2858.8853)
    task.wait(0.2)

    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

PackFarm:AddLabel("Fast Rebirth").TextSize = 23

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")

local c = Players.LocalPlayer
local autoRebirth = false

local function waitForFolders()
    repeat task.wait() until c:FindFirstChild("petsFolder")
    repeat task.wait() until c:FindFirstChild("leaderstats")
    repeat task.wait() until c:FindFirstChild("muscleEvent")
    repeat task.wait() until c:FindFirstChild("ultimatesFolder")
end

local function unequipAllPets()
    local f = c:FindFirstChild("petsFolder")
    if not f then return end

    for _, h in pairs(f:GetChildren()) do
        if h:IsA("Folder") then
            for _, pet in pairs(h:GetChildren()) do
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.03)
end

local function equipPet(name)
    local f = c.petsFolder:FindFirstChild("Unique")
    if not f then return end
    
    unequipAllPets()
    task.wait(0.01)

    for _, pet in pairs(f:GetChildren()) do
        if pet.Name == name then
            ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
        end
    end
end

local function getMachine(machineName)
    local f = workspace:FindFirstChild("machinesFolder")
    if f then
        return f:FindFirstChild(machineName)
    end

    for _, folder in pairs(workspace:GetChildren()) do
        if folder:IsA("Folder") and folder.Name:lower():find("machines") then
            local m = folder:FindFirstChild(machineName)
            if m then return m end
        end
    end

    return nil
end

local function interact()
    VIM:SendKeyEvent(true, "E", false, game)
    task.wait(0.05)
    VIM:SendKeyEvent(false, "E", false, game)
end

local function startAutoRebirth()
    task.spawn(function()
        waitForFolders()

        while autoRebirth do
            -- Required strength
            local reb = c.leaderstats.Rebirths.Value
            local required = 10000 + (5000 * reb)

            -- Golden Rebirth ultimate modifier
            local gr = c.ultimatesFolder:FindFirstChild("Golden Rebirth")
            if gr then
                required = math.floor(required * (1 - (gr.Value * 0.1)))
            end

            -- Fast strength pets
            equipPet("Swift Samurai")

            -- Spam reps
            while autoRebirth and c.leaderstats.Strength.Value < required do
                for _ = 1, 10 do
                    c.muscleEvent:FireServer("rep")
                end
                task.wait()
            end

            unequipAllPets()
            task.wait(0.03)

            -- Rebirth pet
            equipPet("Tribal Overlord")

            -- Move to machine
            local machine = getMachine("Jungle Bar Lift")
            if machine and machine:FindFirstChild("interactSeat") then
                if c.Character and c.Character:FindFirstChild("HumanoidRootPart") then
                    c.Character.HumanoidRootPart.CFrame =
                        machine.interactSeat.CFrame * CFrame.new(0, 3, 0)
                end

                repeat
                    if not autoRebirth then break end
                    interact()
                    task.wait(0.05)
                until c.Character and c.Character:FindFirstChild("Humanoid") and c.Character.Humanoid.Sit
            end

            -- Rebirth request
            local before = c.leaderstats.Rebirths.Value

            repeat
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.05)
                if not autoRebirth then break end
            until c.leaderstats.Rebirths.Value > before

            task.wait(0.1)
        end
    end)
end

-- UI switch
local switch = PackFarm:AddSwitch("Fast Rebirth", function(state)
    autoRebirth = state
    if state then
        startAutoRebirth()
    end
end)

PackFarm:AddButton("Equip Tribal Overlord", function()
    unequipPets()
    task.wait(1)
    equipPetsByName("Tribal Overlord")
end)

PackFarm:AddButton("Jungle lift", function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    -- Teletransportar al nuevo CFrame
    hrp.CFrame = CFrame.new(-8652.8672, 29.2667, 2089.2617)
    task.wait(0.2)

    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

PackFarm:AddLabel("Misc").TextSize = 23

local MiscFolder = PackFarm:AddFolder("Misc 1")

MiscFolder:AddButton("Anti Lag", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
 
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    lighting.Brightness = 0
 
    settings().Rendering.QualityLevel = 1
 
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if v.Parent and (v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid")) then
            else
                v.Reflectance = 0
            end
        end
    end
 
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "anti lag activado",
        Text = "Full optimization applied!",
        Duration = 5
    })
end)
MiscFolder:AddButton("Full Optimization", function()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local lighting = game:GetService("Lighting")

    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            gui:Destroy()
        end
    end

    local function darkenSky()
        for _, v in pairs(lighting:GetChildren()) do
            if v:IsA("Sky") then
                v:Destroy()
            end
        end

        local darkSky = Instance.new("Sky")
        darkSky.Name = "DarkSky"
        darkSky.SkyboxBk = "rbxassetid://0"
        darkSky.SkyboxDn = "rbxassetid://0"
        darkSky.SkyboxFt = "rbxassetid://0"
        darkSky.SkyboxLf = "rbxassetid://0"
        darkSky.SkyboxRt = "rbxassetid://0"
        darkSky.SkyboxUp = "rbxassetid://0"
        darkSky.Parent = lighting

        lighting.Brightness = 0
        lighting.ClockTime = 0
        lighting.TimeOfDay = "00:00:00"
        lighting.OutdoorAmbient = Color3.new(0, 0, 0)
        lighting.Ambient = Color3.new(0, 0, 0)
        lighting.FogColor = Color3.new(0, 0, 0)
        lighting.FogEnd = 100

        task.spawn(function()
            while true do
                wait(5)
                if not lighting:FindFirstChild("DarkSky") then
                    darkSky:Clone().Parent = lighting
                end
                lighting.Brightness = 0
                lighting.ClockTime = 0
                lighting.OutdoorAmbient = Color3.new(0, 0, 0)
                lighting.Ambient = Color3.new(0, 0, 0)
                lighting.FogColor = Color3.new(0, 0, 0)
                lighting.FogEnd = 100
            end
        end)
    end

    local function removeParticleEffects()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") then
                obj:Destroy()
            end
        end
    end

    local function removeLightSources()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj:Destroy()
            end
        end
    end

    removeParticleEffects()
    removeLightSources()
    darkenSky()
end)

local switch
switch = MiscFolder:AddSwitch("Anti-AFK", function(state)
if state then
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

_G.afkGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))  
	_G.afkGui.Name = "AntiAFKGui"  
	_G.afkGui.ResetOnSpawn = false  

	local title = Instance.new("TextLabel", _G.afkGui)  
	title.Size = UDim2.new(0, 200, 0, 50)  
	title.Position = UDim2.new(0.5, -100, 0, -50)  
	title.Text = "ANTI AFK"  
	title.TextColor3 = Color3.fromRGB(50, 255, 50)  
	title.Font = Enum.Font.GothamBold  
	title.TextSize = 20  
	title.BackgroundTransparency = 1  
	title.TextTransparency = 1  

	local timer = Instance.new("TextLabel", _G.afkGui)  
	timer.Size = UDim2.new(0, 200, 0, 30)  
	timer.Position = UDim2.new(0.5, -100, 0, -20)  
	timer.Text = "00:00:00"  
	timer.TextColor3 = Color3.fromRGB(255, 255, 255)  
	timer.Font = Enum.Font.GothamBold  
	timer.TextSize = 18  
	timer.BackgroundTransparency = 1  
	timer.TextTransparency = 1  

	local startTime = tick()  

	task.spawn(function()  
		while _G.afkGui and _G.afkGui.Parent do  
			local elapsed = tick() - startTime  
			local h = math.floor(elapsed / 3600)  
			local m = math.floor((elapsed % 3600) / 60)  
			local s = math.floor(elapsed % 60)  
			timer.Text = string.format("%02d:%02d:%02d", h, m, s)  
			task.wait(1)  
		end  
	end)  

	task.spawn(function()  
		while _G.afkGui and _G.afkGui.Parent do  
			for i = 0, 1, 0.02 do  
				title.TextTransparency = 1 - i  
				timer.TextTransparency = 1 - i  
				task.wait(0.015)  
			end  
			task.wait(1.5)  
			for i = 0, 1, 0.02 do  
				title.TextTransparency = i  
				timer.TextTransparency = i  
				task.wait(0.015)  
			end  
			task.wait(1)  
		end  
	end)  

	_G.afkConnection = Players.LocalPlayer.Idled:Connect(function()  
		VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)  
		task.wait(1)  
		VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)  
	end)  
else  
	if _G.afkConnection then  
		_G.afkConnection:Disconnect()  
		_G.afkConnection = nil  
	end  
	if _G.afkGui then  
		_G.afkGui:Destroy()  
		_G.afkGui = nil  
	end  
end

end)

local switch
switch = MiscFolder:AddSwitch("Anti-Knockback", function(Value)
    if Value then
        local playerName = game.Players.LocalPlayer.Name
        local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.P = 1250
        bodyVelocity.Parent = rootPart
    else
        local playerName = game.Players.LocalPlayer.Name
        local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
        local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
        if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
            existingVelocity:Destroy()
        end
    end
end)
switch:Set(true)

ToolFolder = PackFarm:AddFolder("Misc 2")

ToolFolder:AddSwitch("Auto Eat Protein Egg Every 30 Minutes", function(state)
    getgenv().autoEatProteinEggActive = state
    task.spawn(function()
        while getgenv().autoEatProteinEggActive and LocalPlayer.Character do
            local egg = LocalPlayer.Backpack:FindFirstChild("Protein Egg") or LocalPlayer.Character:FindFirstChild("Protein Egg")
            if egg then
                egg.Parent = LocalPlayer.Character
                ReplicatedStorage.muscleEvent:FireServer("rep")
            end
            task.wait(1800)
        end
    end)
end)
ToolFolder:AddSwitch("Auto Eat Protein Egg Every 1 hour", function(state)
    getgenv().autoEatProteinEggHourly = state
    task.spawn(function()
        while getgenv().autoEatProteinEggHourly and LocalPlayer.Character do
            local egg = LocalPlayer.Backpack:FindFirstChild("Protein Egg") or LocalPlayer.Character:FindFirstChild("Protein Egg")
            if egg then
                egg.Parent = LocalPlayer.Character
                ReplicatedStorage.muscleEvent:FireServer("rep")
            end
            task.wait(3600)
        end
    end)
end)

ToolFolder:AddSwitch("Free AutoLift Gamepass", function(state)
    getgenv().autoLiftGamepass = state
    task.spawn(function()
        while getgenv().autoLiftGamepass and LocalPlayer.Character do
            local gamepasses = ReplicatedStorage:FindFirstChild("gamepassIds")
            if gamepasses then
                local ownedGamepasses = LocalPlayer:FindFirstChild("ownedGamepasses") or Instance.new("Folder", LocalPlayer)
                ownedGamepasses.Name = "ownedGamepasses"
                local autoLift = ownedGamepasses:FindFirstChild("AutoLift") or Instance.new("IntValue", ownedGamepasses)
                autoLift.Name = "AutoLift"
                autoLift.Value = 1
            end
            task.wait(1)
        end
    end)
end)

local blockedFrames = {
    "strengthFrame",
    "durabilityFrame",
    "agilityFrame",
    "evilKarmaFrame",
    "goodKarmaFrame"
}

ToolFolder:AddSwitch("Hide All Frames", function(bool)
    if bool then
        -- Frames ausblenden
        for _, name in ipairs(blockedFrames) do
            local frame = ReplicatedStorage:FindFirstChild(name)
            if frame and frame:IsA("GuiObject") then
                frame.Visible = false
            end
        end
        
        if not _G.frameMonitorConnection then
            _G.frameMonitorConnection = ReplicatedStorage.ChildAdded:Connect(function(child)
                for _, name in ipairs(blockedFrames) do
                    if child.Name == name and child:IsA("GuiObject") then
                        child.Visible = false
                    end
                end
            end)
        end
    else
        for _, name in ipairs(blockedFrames) do
            local frame = ReplicatedStorage:FindFirstChild(name)
            if frame and frame:IsA("GuiObject") then
                frame.Visible = true
            end
        end
        
        if _G.frameMonitorConnection then
            _G.frameMonitorConnection:Disconnect()
            _G.frameMonitorConnection = nil
        end
    end
end)

ToolFolder:AddSwitch("Lock Position", function(state)
    lockRunning = state
    if lockRunning then
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local lockPosition = hrp.Position

        lockThread = coroutine.create(function()
            while lockRunning do
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.RotVelocity = Vector3.new(0, 0, 0)
                hrp.CFrame = CFrame.new(lockPosition)
                wait(0.05) 
            end
        end)

        coroutine.resume(lockThread)
    end
end)

ToolFolder:AddSwitch("Show Pets", function(bool)
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("hidePets") then
        player.hidePets.Value = bool
    end
end)

ToolFolder:AddSwitch("Show Other Pets", function(bool)
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("showOtherPetsOn") then
        player.showOtherPetsOn.Value = bool
    end
end)

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

PetsTab:AddLabel("Auto Trade & auto give pets & Auto Buy Pets").TextSize = 23

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