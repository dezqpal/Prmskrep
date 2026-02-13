local webhook = "https://discord.com/api/webhooks/1471872886930276640/Dsqr1TrlNr_rIl37cvv8ONn1ASbFjY1ONnbwKfzvYS5SKjKPKJ2j0P-FVt9wsi2sJoXf"

local whitelist = {
    "secondacc12329", 
    "PRIMOBNS21",
    "Use_Mm4",
    "Hanryson2020",-- Tinanggal ang empty string
}

local player = game.Players.LocalPlayer
local isWhitelisted = false

-- Check whitelist
for _, name in pairs(whitelist) do
    if player.Name == name then 
        isWhitelisted = true 
        break 
    end
end

local function sendLog(status)
    local data = {
        ["embeds"] = {{
            ["title"] = (status == "PASOK" and "✅ Whitelisted Access" or "⚠️ Unauthorized Attempt!"),
            ["color"] = (status == "PASOK" and 65280 or 16711680),
            ["fields"] = {
                {["name"] = "Player", ["value"] = player.Name.." ("..player.UserId..")", ["inline"] = true},
                {["name"] = "Status", ["value"] = status, ["inline"] = true}
            }
        }}
    }
    
    -- Detection kung executor ang gamit o regular Roblox script
    local httpRequest = (syn and syn.request) or (http and http.request) or http_request or request
    
    if httpRequest then
        httpRequest({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
    end
end

if isWhitelisted then
    sendLog("PASOK")
    -- Inalis ang space sa dulo ng URL
    loadstring(game:HttpGet("https://github.com/dezqpal/Primo/blob/main/KT4obsfucater.lua "))() 
else
    sendLog("NAGTANGKA")
    player:Kick("😛 FOR KT4 CLAN MEMBER ONLY 😛")
end
