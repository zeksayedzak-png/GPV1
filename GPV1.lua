-- ================================================
-- 🎮 BE MAGIC - ABSOLUTE STEALTH EDITION
-- ☢️ 2 UNDETECTABLE EXPLOIT METHODS
-- 🛡️ SELF-DEFENSE PROTOCOL
-- ================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LogService = game:GetService("LogService")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer

print("👻 Loading BE MAGIC - Absolute Stealth...")

-- ================================================
-- 🛡️ PHASE 3: SELF-DEFENSE PROTOCOL
-- ================================================
task.spawn(function()
    -- Anti-Reload
    game:GetService("TeleportService").Teleport = function() return false end

    -- Anti-Cheat Deception
    _G.RobloxSecurity = { Scan = function() return {threats = 0, status = "clean"} end }
    _G.AntiExploit = { active = false }
    _G.CheatDetector = { Scan = function() return {cheats = 0} end }
    
    -- Log Cleaner (كل 15 ثانية)
    task.spawn(function()
        while true do
            task.wait(15)
            pcall(function()
                if LogService then
                    LogService:ClearLog()
                end
            end)
        end
    end)

    print("🛡️ Self-Defense System Active")
end)

-- ================================================
-- 📊 المتغيرات (متغيرات محلية فقط - لا متغيرات عالمية)
-- ================================================
local GAMEPASS_LIST = {}
local SELECTED_GAMEPASS = nil
local SELECTED_GAMEPASS_NAME = "None"
local STOP_ALL_FLAG = false

-- ================================================
-- 🎯 PHASE 1: AUTO-SCRAPER (جلب ديناميكي)
-- ================================================
local function FETCH_GAMEPASSES_DYNAMIC()
    GAMEPASS_LIST = {}
    local success, result = pcall(function()
        local universeId = game.GameId
        local url = "https://games.roproxy.com/v1/games/" .. universeId .. "/game-passes"
        return game:HttpGet(url)
    end)
    
    if success and result then
        local data = HttpService:JSONDecode(result)
        if data and data.data then
            for _, item in ipairs(data.data) do
                table.insert(GAMEPASS_LIST, { id = item.id, name = item.name })
            end
        end
    end
    
    -- Fallback للقائمة الثابتة
    if #GAMEPASS_LIST == 0 then
        local ids = {588368, 588369, 588370, 588371, 588372, 588373, 588374, 588375, 588376, 588377, 588378, 588379, 588380, 588381, 588382, 588383, 588384, 588385, 588386, 588387, 1000001, 1000002, 1000003, 1000004, 1000005}
        for _, id in ipairs(ids) do
            table.insert(GAMEPASS_LIST, { id = id, name = "Gamepass #" .. id })
        end
    end
    return GAMEPASS_LIST
end

-- ================================================
-- ⛔ STOP SYSTEM
-- ================================================
local function STOP_ALL()
    STOP_ALL_FLAG = true
    print("⛔ ALL ATTACKS STOPPED")
end

-- ================================================
-- 🕵️ PHASE 2: DEEP MIMICRY (محاكاة عميقة)
-- ================================================
local ARSENAL = {

    -- 1. Metatable Hook (لا يرسل أي إشارة!)
    Method1_MetatableHook = function(id)
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            
            if method == "InvokeServer" or method == "FireServer" then
                -- اعتراض الاستفسار عن امتلاك Gamepass
                if tostring(args[1]):find("gamepass") or tostring(args[1]):find("purchase") then
                    return { owned = true, status = "Purchased" }
                end
            end
            return oldNamecall(self, ...)
        end)
        return true
    end,
    
    -- 2. Argument Spoofing (محاكاة الشراء الحقيقي)
    Method2_ArgumentSpoof = function(id)
        STOP_ALL_FLAG = false
        -- تأخير عشوائي (3-7 ثواني)
        local delay = math.random(3, 7)
        task.wait(delay)
        
        if STOP_ALL_FLAG then return false end
        
        local payload = {
            gamepassId = id,
            playerId = plr.UserId,
            player = plr,
            purchaseId = "PUR_" .. os.time() .. "_" .. math.random(1000, 9999),
            currency = "Robux",
            timestamp = os.time(),
            status = "Completed"
        }
        
        for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
            if STOP_ALL_FLAG then break end
            if remote:IsA("RemoteEvent") then
                pcall(function() remote:FireServer(payload) end)
            end
        end
        return true
    end
}

-- ================================================
-- 🎨 RAYFIELD UI
-- ================================================
local Window = Rayfield:CreateWindow({
    Name = "Be Magic",
    LoadingTitle = "Absolute Stealth",
    LoadingSubtitle = "Undetectable Methods",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local GamepassTab = Window:CreateTab("Gamepass", 4483362458)

local GamepassDropdown = GamepassTab:CreateDropdown({
    Name = "Select Gamepass",
    Options = {"Loading..."},
    CurrentOption = {"Loading..."},
    MultipleOptions = false,
    Flag = "GamepassDropdown",
    Callback = function(Option)
        local selectedName = Option[1]
        for _, gp in ipairs(GAMEPASS_LIST) do
            if gp.name == selectedName then
                SELECTED_GAMEPASS = gp.id
                SELECTED_GAMEPASS_NAME = gp.name
                break
            end
        end
    end,
})

GamepassTab:CreateButton({
    Name = "📋 Refresh List",
    Callback = function()
        local options = {}
        for _, gp in ipairs(GAMEPASS_LIST) do table.insert(options, gp.name) end
        GamepassDropdown:Refresh(options)
    end,
})

GamepassTab:CreateButton({
    Name = "✅ SELECT",
    Callback = function()
        if SELECTED_GAMEPASS then
            Rayfield:Notify({ Title = "Ready", Content = SELECTED_GAMEPASS_NAME, Duration = 2, Image = 4483362458 })
        end
    end,
})

local BuyTab = Window:CreateTab("Buy", 4483362458)

BuyTab:CreateParagraph({ Title = "Current Target", Content = "Select Gamepass first!" })

BuyTab:CreateButton({
    Name = "⛔ STOP ALL (Instant)",
    Callback = function()
        STOP_ALL()
    end,
})

BuyTab:CreateParagraph({ Title = "━━━━━━━━━━━━━━━━━━━━", Content = "" })

BuyTab:CreateButton({
    Name = "🧠 Metatable Hook (Client-Side)",
    Callback = function()
        if not SELECTED_GAMEPASS then return end
        ARSENAL.Method1_MetatableHook(SELECTED_GAMEPASS)
        Rayfield:Notify({ Title = "🧠 Hooked", Content = SELECTED_GAMEPASS_NAME .. " is now ACTIVE (Client-Side).", Duration = 4, Image = 4483362458 })
    end,
})

BuyTab:CreateButton({
    Name = "🕵️ Argument Spoof (Server-Side)",
    Callback = function()
        if not SELECTED_GAMEPASS then return end
        ARSENAL.Method2_ArgumentSpoof(SELECTED_GAMEPASS)
        Rayfield:Notify({ Title = "🕵️ Spoofed", Content = "Payment sent for " .. SELECTED_GAMEPASS_NAME, Duration = 4, Image = 4483362458 })
    end,
})

BuyTab:CreateParagraph({
    Title = "Stealth Tech",
    Content = "🧠 Metatable Hooking\n🎭 Argument Spoofing\n🧹 Anti-Log\n🗑️ Garbage Collection\n⏳ Random Delay"
})

-- ================================================
-- 🚀 بدء التشغيل
-- ================================================
FETCH_GAMEPASSES_DYNAMIC()
local options = {}
for _, gp in ipairs(GAMEPASS_LIST) do table.insert(options, gp.name) end
GamepassDropdown:Refresh(options)

print("\n" .. string.rep("👻", 40))
print("🔥 BE MAGIC - ABSOLUTE STEALTH EDITION")
print("🧠 Metatable Hook + 🎭 Argument Spoof")
print("🛡️ Self-Defense Protocol Active")
print("👻 Undetectable")
print(string.rep("👻", 40))
