-- ============================================================
-- XENON GUI — MERGED WITH BROTHER'S VOW FUNCTIONS
-- ============================================================

if getgenv().XenonLoaded then
    if getgenv().XenonScreenGui then getgenv().XenonScreenGui:Destroy() end
    if getgenv().MobileButton then getgenv().MobileButton:Destroy() end
end
getgenv().XenonLoaded = true

local VALID_KEY = "Jkfq12lvwfwg51vdc"
local GETKEY_LINK = "https://discord.gg/9Fyh42Hs"
local hasAccess = false

if not hasAccess then
    local TweenService = game:GetService("TweenService")
    local gui = Instance.new("ScreenGui")
    gui.Name = "XenonKeyUI"; gui.IgnoreGuiInset = true; gui.ResetOnSpawn = false; gui.Parent = game.CoreGui

    local blur = Instance.new("BlurEffect"); blur.Size = 0; blur.Parent = game.Lighting
    TweenService:Create(blur, TweenInfo.new(0.4), {Size = 20}):Play()

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,0,1,0); bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
    bg.BackgroundTransparency = 1; bg.Parent = gui
    TweenService:Create(bg, TweenInfo.new(0.4), {BackgroundTransparency = 0.4}):Play()

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0,0,0,0); main.Position = UDim2.new(0.5,0,0.5,0)
    main.AnchorPoint = Vector2.new(0.5,0.5); main.BackgroundColor3 = Color3.fromRGB(15,15,15); main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)
    local grad = Instance.new("UIGradient", main)
    grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(20,20,20)), ColorSequenceKeypoint.new(1, Color3.fromRGB(10,10,10))}
    TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0,340,0,220)}):Play()

    local line = Instance.new("Frame", main); line.Size = UDim2.new(1,0,0,2); line.BackgroundColor3 = Color3.fromRGB(0,160,255)
    local title = Instance.new("TextLabel", main); title.Size = UDim2.new(1,0,0,50); title.BackgroundTransparency = 1
    title.Text = "XENON"; title.Font = Enum.Font.GothamBlack; title.TextSize = 20; title.TextColor3 = Color3.fromRGB(255,255,255)
    local sub = Instance.new("TextLabel", main); sub.Size = UDim2.new(1,0,0,20); sub.Position = UDim2.new(0,0,0,35)
    sub.BackgroundTransparency = 1; sub.Text = "Premium Access Required"; sub.Font = Enum.Font.Gotham; sub.TextSize = 12; sub.TextColor3 = Color3.fromRGB(130,130,130)

    local input = Instance.new("TextBox", main)
    input.Size = UDim2.new(0.8,0,0,40); input.Position = UDim2.new(0.1,0,0.45,0)
    input.BackgroundColor3 = Color3.fromRGB(25,25,25); input.Text = ""; input.PlaceholderText = "Enter your key..."
    input.Font = Enum.Font.Gotham; input.TextSize = 14; input.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", input).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", input).Color = Color3.fromRGB(40,40,40)

    local unlock = Instance.new("TextButton", main)
    unlock.Size = UDim2.new(0.8,0,0,35); unlock.Position = UDim2.new(0.1,0,0.68,0)
    unlock.Text = "Unlock"; unlock.Font = Enum.Font.GothamBold; unlock.TextSize = 14; unlock.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", unlock).CornerRadius = UDim.new(0,10)
    local unlockGrad = Instance.new("UIGradient", unlock)
    unlockGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0,160,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0,90,200))}
    Instance.new("UIStroke", unlock).Color = Color3.fromRGB(0,160,255)

    local getkey = Instance.new("TextButton", main)
    getkey.Size = UDim2.new(0.8,0,0,28); getkey.Position = UDim2.new(0.1,0,0.85,0)
    getkey.Text = "Get Key"; getkey.Font = Enum.Font.Gotham; getkey.TextSize = 12
    getkey.TextColor3 = Color3.fromRGB(200,200,200); getkey.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Instance.new("UICorner", getkey).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", getkey).Color = Color3.fromRGB(60,60,60)

    local status = Instance.new("TextLabel", main)
    status.Size = UDim2.new(1,0,0,18); status.Position = UDim2.new(0,0,1,-18)
    status.BackgroundTransparency = 1; status.Text = ""; status.Font = Enum.Font.Gotham
    status.TextSize = 12; status.TextColor3 = Color3.fromRGB(255,80,80)

    getkey.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(GETKEY_LINK); status.TextColor3 = Color3.fromRGB(100,255,100); status.Text = "Link copied!"
        else status.Text = "Clipboard not supported" end
    end)

    local unlocked = false
    unlock.MouseButton1Click:Connect(function()
        if input.Text == VALID_KEY then
            status.TextColor3 = Color3.fromRGB(100,255,100); status.Text = "Access granted"; unlocked = true
            TweenService:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0,0,0,0)}):Play()
            task.wait(0.3); gui:Destroy(); blur:Destroy()
        else status.Text = "Invalid key" end
    end)
    repeat task.wait() until unlocked
end

-- ============================================================
-- XENON LIB INIT
-- ============================================================
local XenonLib
local XENON_URL = "https://raw.githubusercontent.com/Xenon150/Xenon-GUI/refs/heads/main/GUI.lua"

local function fetchSource(url)
    if request then
        local ok, res = pcall(request, { Url = url, Method = "GET" })
        if ok and res and res.StatusCode == 200 and type(res.Body) == "string" and #res.Body > 100 then
            return res.Body
        end
    end
    if syn and syn.request then
        local ok, res = pcall(syn.request, { Url = url, Method = "GET" })
        if ok and res and res.StatusCode == 200 and type(res.Body) == "string" and #res.Body > 100 then
            return res.Body
        end
    end
    local ok, src = pcall(game.HttpGet, game, url)
    if ok and type(src) == "string" and #src > 100 then
        return src
    end
    return nil
end

for attempt = 1, 3 do
    local src = fetchSource(XENON_URL)
    if not src then
        warn("[Xenon] Attempt " .. attempt .. ": failed to fetch source")
        task.wait(2)
    elseif src:sub(1, 1) == "<" then
        warn("[Xenon] Attempt " .. attempt .. ": got HTML instead of Lua (404/rate limit)")
        task.wait(2)
    else
        local fn, compileErr = loadstring(src)
        if not fn then
            warn("[Xenon] Attempt " .. attempt .. ": compile error: " .. tostring(compileErr))
            task.wait(2)
        else
            local ok, result = pcall(fn)
            if ok and result then
                XenonLib = result
                break
            else
                warn("[Xenon] Attempt " .. attempt .. ": runtime error: " .. tostring(result))
                task.wait(2)
            end
        end
    end
    if attempt == 3 and not XenonLib then
        error("[Xenon] Could not load library. Check internet or executor permissions.")
    end
end

local Notification = XenonLib:CreateNotification()
local Logging = XenonLib:CreateLogger()

local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local autoScale = isMobile and XenonLib.Scales.Mobile or XenonLib.Scales.Default

local window = XenonLib:CreateWindow({
    Logo = XenonLib.GlobalLogo,
    Name = "Brother's Vow",
    Content = "brother vow",
    Size = autoScale,
    ConfigFolder = "XenonConfigs",
    Enable3DRenderer = false,
    Keybind = "K"
})

getgenv().XenonScreenGui = XenonLib.ScreenGui

if isMobile then
    task.wait(0.2)
    window:SetSize(XenonLib.Scales.Mobile)
end

pcall(function()
    for _, v in pairs(XenonLib.ScreenGui:GetDescendants()) do
        if v:IsA("Frame") and v:FindFirstChild("pencil-square") then v.Visible = false end
        if v:IsA("TextLabel") and v.Text == "pencil-square" then
            local parent = v.Parent; if parent then parent.Visible = false end
        end
    end
end)

if isMobile then
    local mobileButton = Instance.new("ScreenGui")
    mobileButton.Name = "XenonMobileButton"; mobileButton.ResetOnSpawn = false; mobileButton.Parent = game:GetService("CoreGui")
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0,60,0,60); button.Position = UDim2.new(0.5,-30,0.9,-30)
    button.BackgroundColor3 = Color3.fromRGB(30,30,30); button.BackgroundTransparency = 0.3
    button.Text = "Menu"; button.TextColor3 = Color3.fromRGB(255,255,255); button.TextSize = 20
    button.Font = Enum.Font.SourceSansBold; button.BorderSizePixel = 0; button.Parent = mobileButton
    Instance.new("UICorner", button).CornerRadius = UDim.new(0,30)
    local dragToggle, dragStart, startPos
    local function updateDrag(inp)
        local delta = inp.Position - dragStart
        button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    button.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true; dragStart = inp.Position; startPos = button.Position
            inp.Changed:Connect(function() if inp.UserInputState == Enum.UserInputState.End then dragToggle = false end end)
        end
    end)
    button.InputChanged:Connect(function(inp)
        if dragToggle and inp.UserInputType == Enum.UserInputType.Touch then updateDrag(inp) end
    end)
    button.MouseButton1Click:Connect(function() window:ToggleInterface() end)
    getgenv().MobileButton = mobileButton
end

-- ============================================================
-- СЕРВИСЫ И ПЕРЕМЕННЫЕ (ИЗ BROTHER'S VOW)
-- ============================================================
local Players   = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Lighting  = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cam = workspace.CurrentCamera
local LP = Players.LocalPlayer

-- Списки предметов
local allItems = {
    "Tec9","Revolver","Shiv","Bottle","Medkit",
    "PrimaryAmmo","SecondaryAmmo",
    "Beans","Candy Bar","ShellsAmmo","M1911","DoubleBarrel",
    "AK74","Bandage","Carrot","Chips","MRE",
    "Soup","CandyBar","Soda","WitchBrew"
}

-- Состояния
local selectedItems = {}
local collecting = false
local noclipEnabled = false
DRAG_SPEED_DISTANCE = 5

-- Тогглы
local antiVoidEnabled     = false
local fullBrightEnabled   = false
local floatEnabled        = false
local lockedYPosition     = 0
local nameEspEnabled      = false
local noFogEnabled        = false
local antiAfkEnabled      = false
local animationBypassEnabled = false
local ghostModeEnabled    = false
local bringAllItemsEnabled = false
local autoCollectEnabled  = false
local bringAllNpcEnabled  = false
local generatorPPEnabled  = false
local chainsawGuyEspEnabled = false
local highlightGatesEnabled = false
local playersEspEnabled   = false
local enemyEspEnabled     = false
local walkspeedBoostActive = false
local jumpBoostActive     = false
local originalAnimateScript = nil
local animationBypassCleanup = {}

-- Константы
local collectTimeout = 5.0
local teleportDelay  = 0.2
local firePPDelay    = 0.2
local aimSmoothness  = 0.581
local fov            = 136
local boostedWalkspeed = 40
local boostedJumpPower = 100
local defaultWalkspeed = 0
local defaultJumpPower = 0

-- ESP хранилища
local playerHighlights = {}; local enemyHighlights = {}
local playerBoxes = {}; local playerHealthLabels = {}
local enemyBoxes = {}; local enemyHealthLabels = {}
local playerNameLabels = {}
local chainsawGuyBoxes = {}; local chainsawGuyHighlights = {}
local gateHighlights = {}

-- Оригинальное освещение
local originalAmbient       = Lighting.Ambient
local originalBrightness    = Lighting.Brightness
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalFogEnd        = Lighting.FogEnd or 0
local originalFogStart      = Lighting.FogStart or 0

-- Ремоуты
local EventsFolder = ReplicatedStorage:FindFirstChild("Events")
local MenuEvents   = ReplicatedStorage:FindFirstChild("Assets")
    and ReplicatedStorage.Assets:FindFirstChild("Events")
    and ReplicatedStorage.Assets.Events:FindFirstChild("MenuEvents")
local ActivateGeneratorRemote = (EventsFolder and EventsFolder:FindFirstChild("ActivateGenerator"))
    or ReplicatedStorage:FindFirstChild("ActivateGenerator")

-- ============================================================
-- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
-- ============================================================
local function getRoot(c)
    if not c then return nil end
    if c:IsA("Model") and c.PrimaryPart and c.PrimaryPart:IsA("BasePart") then return c.PrimaryPart end
    return c:FindFirstChild("HumanoidRootPart") or c:FindFirstChildWhichIsA("BasePart")
end
local function getHum(c) return c and c:FindFirstChildOfClass("Humanoid") end
local function getChar() return LP.Character end

local function toggleNoclip(state)
    noclipEnabled = state
    local char = LP.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = not state end
        end
    end
end

local function findAllParts(name)
    local found = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(LP.Character or Instance.new("Folder")) and v.Name:lower() == name:lower() then
            table.insert(found, v)
        end
    end
    return found
end

local function getLargestPart(name)
    local best, bestVol = nil, 0
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(LP.Character or Instance.new("Folder")) and v.Name:lower() == name:lower() then
            local vol = v.Size.X * v.Size.Y * v.Size.Z
            if vol > bestVol then bestVol = vol; best = v end
        end
    end
    return best
end

local function getClosestPart(name)
    local best, bestDist = nil, math.huge
    local char = LP.Character; local root = char and getRoot(char)
    if not root then return nil end
    local pos = root.Position
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(char) and v.Name:lower() == name:lower() then
            local d = (v.Position - pos).Magnitude
            if d < bestDist then bestDist = d; best = v end
        end
    end
    return best
end

local function firepp(targetPart)
    if fireproximityprompt and targetPart then
        local prompt = targetPart:FindFirstChildOfClass("ProximityPrompt")
        if prompt then fireproximityprompt(prompt); return true end
    end
    return false
end

-- Инит скоростей
local function InitializeBaseSpeeds()
    local char = LP.Character or LP.CharacterAdded:Wait()
    local hum = getHum(char)
    if hum then
        defaultWalkspeed = hum.WalkSpeed; defaultJumpPower = hum.JumpPower
        boostedWalkspeed = math.max(defaultWalkspeed * 2.5, 40)
        boostedJumpPower = math.max(defaultJumpPower * 2, 100)
    end
end
if LP.Character then InitializeBaseSpeeds() else LP.CharacterAdded:Connect(InitializeBaseSpeeds) end

-- ============================================================
-- КОНФИГ СИСТЕМА
-- ============================================================
local CONFIG_FOLDER = "XenonConfigs"
local function ensureFolder() if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end end
local function getCurrentData()
    return {
        antiVoid = antiVoidEnabled, fullBright = fullBrightEnabled, noFog = noFogEnabled,
        antiAfk = antiAfkEnabled, ghostMode = ghostModeEnabled, nameEsp = nameEspEnabled,
        playersEsp = playersEspEnabled, enemyEsp = enemyEspEnabled,
        chainsawEsp = chainsawGuyEspEnabled, gateHighlight = highlightGatesEnabled,
        walkspeed = walkspeedBoostActive, jumpPower = jumpBoostActive,
        autoCollect = autoCollectEnabled, bringItems = bringAllItemsEnabled,
        bringNpcs = bringAllNpcEnabled, genPP = generatorPPEnabled,
        animBypass = animationBypassEnabled, float = floatEnabled,
    }
end
local function getConfigList()
    ensureFolder(); local list = {}
    local ok, files = pcall(listfiles, CONFIG_FOLDER)
    if not ok then return list end
    for _, path in pairs(files) do
        local name = string.match(path, "([^/\\]+)%.json$")
        if name then table.insert(list, name) end
    end
    return list
end
local function saveConfig(name)
    if not name or name == "" then Logging.new("triangle-exclamation","Enter config name",3); return end
    ensureFolder()
    local ok, encoded = pcall(function() return HttpService:JSONEncode(getCurrentData()) end)
    if ok then writefile(CONFIG_FOLDER.."/"..name..".json", encoded); Logging.new("folder","Saved: "..name,3) end
end

-- ============================================================
-- ОЧИСТКА СОЕДИНЕНИЙ
-- ============================================================
if getgenv().XenonConnections then
    for _, c in pairs(getgenv().XenonConnections) do pcall(function() c:Disconnect() end) end
end
getgenv().XenonConnections = {}

-- ============================================================
-- WATERMARK
-- ============================================================
local Watermark = window:Watermark()
local UITogg = Watermark:AddBlock("cube-vertexes","Xenon")
UITogg:Input(function() window:ToggleInterface() end)
Watermark:AddBlock(isMobile and "smartphone-portrait" or "teletype", isMobile and "Mobile" or "PC")

-- ============================================================
-- ВКЛАДКА: MAIN (Item Collector + ESP)
-- ============================================================
local MainTab = window:AddTab({ Icon = "home", Name = "Main" })

-- ---- ITEM COLLECTOR ----
local CollectorSection = MainTab:AddSection({ Name = "ITEM COLLECTOR" })

-- Выбор предметов (через кнопку + дропдаун)
local itemDropdown = CollectorSection:AddLabel("Select Items"):AddDropdown({
    Default = nil,
    Values = allItems,
    Flag = "SelectedItem",
    Callback = function(v)
        selectedItems = {}
        if v then table.insert(selectedItems, v) end
    end
})

CollectorSection:AddButton({
    Name = "Open ALL Containers (PP)",
    Icon = "box-open",
    Callback = function()
        if collecting then Logging.new("triangle-exclamation","Already busy collecting.",3); return end
        local containerNames = {"LongCrate","Resizeable Crate","WoodCrate","CardboardBox","Backpacks"}
        local char = LP.Character; local root = getRoot(char)
        if not char or not root then Logging.new("triangle-exclamation","Character not available.",3); return end
        collecting = true; local savedPos = root.CFrame; toggleNoclip(true)
        Logging.new("box-open","Opening containers...",2)
        local allDesc = Workspace:GetDescendants(); local total = 0
        for _, cName in ipairs(containerNames) do
            for _, container in ipairs(allDesc) do
                if container.Name:lower() == cName:lower() or container.Name:lower():match(cName:lower()) then
                    local partWithPP, prompt = nil, nil
                    if container:IsA("Model") or container:IsA("Part") then
                        for _, desc in ipairs(container:GetDescendants()) do
                            if desc:FindFirstChildOfClass("ProximityPrompt") then
                                prompt = desc:FindFirstChildOfClass("ProximityPrompt"); partWithPP = desc; break
                            end
                        end
                    end
                    if not prompt and container:IsA("BasePart") then
                        prompt = container:FindFirstChildOfClass("ProximityPrompt"); partWithPP = container
                    end
                    if prompt and partWithPP and partWithPP:IsDescendantOf(Workspace) and partWithPP:IsA("BasePart") then
                        root.CFrame = partWithPP.CFrame; task.wait(teleportDelay)
                        for j=1,5 do fireproximityprompt(prompt); task.wait(firePPDelay) end
                        total = total + 1
                    end
                end
            end
        end
        toggleNoclip(false); root.CFrame = savedPos; collecting = false
        Logging.new("check","Opened "..total.." containers.",4)
    end
})

CollectorSection:AddButton({
    Name = "Collect Selected Items",
    Icon = "backpack",
    Callback = function()
        if #selectedItems == 0 then Logging.new("triangle-exclamation","Select an item first!",3); return end
        local char = LP.Character
        if not char then Logging.new("triangle-exclamation","Character not available.",3); return end
        collecting = true; local root = getRoot(char); local savedPos = root.CFrame
        local totalCollected = 0; local startTime = tick()
        Logging.new("backpack","Collecting "..#selectedItems.." item types...",2)
        toggleNoclip(true)
        while tick() - startTime < collectTimeout do
            local foundSomething = false
            for _, selName in ipairs(selectedItems) do
                for _, part in ipairs(findAllParts(selName)) do
                    if part and part:IsDescendantOf(Workspace) then
                        foundSomething = true; totalCollected = totalCollected + 1
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum and hum.SeatPart then hum.Sit = false; task.wait(teleportDelay) end
                        root.CFrame = part.CFrame; task.wait(teleportDelay)
                        for j=1,5 do firepp(part); task.wait(firePPDelay); if not part:IsDescendantOf(Workspace) then break end end
                    end
                end
            end
            if not foundSomething then break end
        end
        toggleNoclip(false); root.CFrame = savedPos; collecting = false
        Logging.new("check","Done. Total: "..totalCollected,4)
    end
})

CollectorSection:AddButton({
    Name = "Drag & Collect Nearest (TP Back)",
    Icon = "arrow-right-arrow-left",
    Callback = function()
        if #selectedItems == 0 then Logging.new("triangle-exclamation","Select an item first!",3); return end
        local itemPart = getClosestPart(selectedItems[1]); local root = getRoot(LP.Character)
        if not itemPart or not root then Logging.new("triangle-exclamation","Item or character not found.",3); return end
        collecting = true; local savedPos = root.CFrame; local t = tick()
        while tick()-t < 0.001 do
            task.wait(firePPDelay)
            itemPart.CFrame = CFrame.new(root.CFrame.p + root.CFrame.LookVector * 2)
        end
        if itemPart and itemPart:IsDescendantOf(Workspace) then
            toggleNoclip(true); root.CFrame = itemPart.CFrame; task.wait(teleportDelay)
            for j=1,5 do firepp(itemPart); task.wait(firePPDelay); if not itemPart:IsDescendantOf(Workspace) then break end end
            toggleNoclip(false); root.CFrame = savedPos
        end
        collecting = false
        Logging.new("check","Drag collect done.",3)
    end
})

CollectorSection:AddButton({
    Name = "Teleport to Nearest Item",
    Icon = "location-arrow",
    Callback = function()
        if #selectedItems == 0 then Logging.new("triangle-exclamation","Select an item first!",3); return end
        local part = getClosestPart(selectedItems[1]); local root = getRoot(LP.Character)
        if part and root then root.CFrame = part.CFrame * CFrame.new(0,5,0); Logging.new("location-arrow","Teleported to nearest "..selectedItems[1],3)
        else Logging.new("triangle-exclamation","Item not found.",3) end
    end
})

CollectorSection:AddButton({
    Name = "Teleport to Largest Item",
    Icon = "up-right-and-down-left-from-center",
    Callback = function()
        if #selectedItems == 0 then Logging.new("triangle-exclamation","Select an item first!",3); return end
        local part = getLargestPart(selectedItems[1]); local root = getRoot(LP.Character)
        if part and root then root.CFrame = part.CFrame * CFrame.new(0,5,0); Logging.new("up-right-and-down-left-from-center","Teleported to largest "..selectedItems[1],3)
        else Logging.new("triangle-exclamation","Item not found.",3) end
    end
})

CollectorSection:AddButton({
    Name = "Activate All Generators",
    Icon = "bolt",
    Callback = function()
        if collecting then Logging.new("triangle-exclamation","Already busy.",3); return end
        local generators = {}
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name:lower() == "generator" and (v:IsA("BasePart") or v:IsA("Model")) then
                local rp = getRoot(v); if rp and rp:IsA("BasePart") then table.insert(generators, rp) end
            end
        end
        if #generators == 0 then Logging.new("triangle-exclamation","No generators found.",4); return end
        local char = LP.Character; local root = getRoot(char)
        if not char or not root then Logging.new("triangle-exclamation","Character not available.",3); return end
        collecting = true; local savedPos = root.CFrame; toggleNoclip(true)
        Logging.new("bolt","Activating "..#generators.." generators...",3)
        for _, gp in ipairs(generators) do
            if gp:IsDescendantOf(Workspace) and gp:IsA("BasePart") then
                root.CFrame = gp.CFrame; task.wait(teleportDelay)
                root.CFrame = root.CFrame * CFrame.new(0,0,-5); task.wait(teleportDelay)
                root.CFrame = gp.CFrame; task.wait(teleportDelay)
                if ActivateGeneratorRemote and ActivateGeneratorRemote:IsA("RemoteEvent") then
                    ActivateGeneratorRemote:FireServer(gp)
                end
            end
        end
        toggleNoclip(false); root.CFrame = savedPos; collecting = false
        Logging.new("check","Generators done.",4)
    end
})

local bringItemsToggle = CollectorSection:AddLabel("Bring ALL Items"):AddToggle({
    Default = false, Flag = "BringAllItems",
    Callback = function(v)
        bringAllItemsEnabled = v
        if v then toggleNoclip(true); Logging.new("arrows-to-circle","Bring ALL Items ON.",3)
        else if not noclipEnabled then toggleNoclip(false) end; Logging.new("arrows-to-circle","Bring ALL Items OFF.",3) end
    end
})

local autoCollectToggle = CollectorSection:AddLabel("Auto-Collect"):AddToggle({
    Default = false, Flag = "AutoCollect",
    Callback = function(v) autoCollectEnabled = v; Logging.new("rotate","Auto-Collect: "..(v and "ON" or "OFF"),3) end
})

-- ---- ESP ----
local EspSection = MainTab:AddSection({ Name = "ESP SETTINGS" })

local playersEspToggle = EspSection:AddLabel("Players ESP"):AddToggle({
    Default = false, Flag = "PlayersESP",
    Callback = function(v)
        playersEspEnabled = v
        if not v then for _, h in pairs(playerHighlights) do h.Enabled = false end end
    end
})
local enemyEspToggle = EspSection:AddLabel("Enemy ESP"):AddToggle({
    Default = false, Flag = "EnemyESP",
    Callback = function(v)
        enemyEspEnabled = v
        if not v then for _, h in pairs(enemyHighlights) do h.Enabled = false end end
    end
})
local chainsawEspToggle = EspSection:AddLabel("ChainsawGuy ESP"):AddToggle({
    Default = false, Flag = "ChainsawESP",
    Callback = function(v) chainsawGuyEspEnabled = v; Logging.new("eye","ChainsawGuy ESP: "..(v and "ON" or "OFF"),3) end
})
local gateHighlightToggle = EspSection:AddLabel("Highlight Gates (GatePart1/2)"):AddToggle({
    Default = false, Flag = "GateHighlight",
    Callback = function(v) highlightGatesEnabled = v; Logging.new("eye","Gate Highlights: "..(v and "ON" or "OFF"),3) end
})
local nameEspToggle = EspSection:AddLabel("Name ESP"):AddToggle({
    Default = false, Flag = "NameESP",
    Callback = function(v) nameEspEnabled = v end
})

-- ============================================================
-- ВКЛАДКА: PLAYER (Movement + Combat)
-- ============================================================
local PlayerTab = window:AddTab({ Icon = "person-running", Name = "Player" })

-- ---- MOVEMENT ----
local MovSection = PlayerTab:AddSection({ Name = "MOVEMENT" })

local walkspeedToggle = MovSection:AddLabel("Fast Walkspeed"):AddToggle({
    Default = false, Flag = "WalkspeedBoost",
    Callback = function(v)
        walkspeedBoostActive = v
        local hum = getHum(LP.Character)
        if hum then hum.WalkSpeed = v and boostedWalkspeed or defaultWalkspeed end
    end
})
local jumpToggle = MovSection:AddLabel("Super Jump"):AddToggle({
    Default = false, Flag = "JumpBoost",
    Callback = function(v)
        jumpBoostActive = v
        local hum = getHum(LP.Character)
        if hum then hum.JumpPower = v and boostedJumpPower or defaultJumpPower end
    end
})
local noclipToggle = MovSection:AddLabel("Noclip"):AddToggle({
    Default = false, Flag = "Noclip",
    Callback = function(v) toggleNoclip(v) end
})
local antiAfkToggle = MovSection:AddLabel("Anti-AFK"):AddToggle({
    Default = false, Flag = "AntiAFK",
    Callback = function(v) antiAfkEnabled = v; Logging.new("clock","Anti-AFK: "..(v and "ON" or "OFF"),3) end
})
local ghostToggle = MovSection:AddLabel("Ghost Mode (Invisibility)"):AddToggle({
    Default = false, Flag = "GhostMode",
    Callback = function(v)
        ghostModeEnabled = v
        local char = LP.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.LocalTransparencyModifier = v and 1 or 0 end
            end
        end
        Logging.new("ghost","Ghost Mode: "..(v and "ON" or "OFF"),3)
    end
})
local animBypassToggle = MovSection:AddLabel("Animation Bypass"):AddToggle({
    Default = false, Flag = "AnimBypass",
    Callback = function(v)
        animationBypassEnabled = v
        if v then
            local char = LP.Character or LP.CharacterAdded:Wait()
            local anim = char:FindFirstChild("Animate")
            if anim then originalAnimateScript = anim:Clone(); animationBypassCleanup[LP] = anim; anim:Destroy()
                Logging.new("xmark","Animation Bypass ON.",3)
            end
        else
            local char = LP.Character
            if originalAnimateScript and char and not char:FindFirstChild("Animate") then
                originalAnimateScript.Parent = char; originalAnimateScript = nil; animationBypassCleanup[LP] = nil
                Logging.new("check","Animation Bypass OFF.",3)
            end
        end
    end
})
local floatToggle = MovSection:AddLabel("Mid-Air Float"):AddToggle({
    Default = false, Flag = "Float",
    Callback = function(v)
        floatEnabled = v
        if v then local root = getRoot(LP.Character); if root then lockedYPosition = root.CFrame.Y end end
        Logging.new("feather","Float: "..(v and "ON" or "OFF"),3)
    end
})

-- ---- COMBAT TOOLS ----
local CombatSection = PlayerTab:AddSection({ Name = "COMBAT TOOLS" })

CombatSection:AddButton({
    Name = "Launch Aimbot",
    Icon = "crosshairs",
    Callback = function()
        local aimbotFov = 136
        local FOVring = Drawing.new("Circle")
        FOVring.Visible = false; FOVring.Thickness = 2
        FOVring.Color = Color3.fromRGB(128,0,128); FOVring.Filled = false
        FOVring.Radius = aimbotFov; FOVring.Position = Cam.ViewportSize / 2

        local isAiming = false
        local SGui = Instance.new("ScreenGui"); SGui.Parent = game.CoreGui
        local TogBtn = Instance.new("TextButton")
        TogBtn.Size = UDim2.new(0,120,0,40); TogBtn.Position = UDim2.new(0,10,0,10)
        TogBtn.Text = "AIMBOT: OFF"; TogBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
        TogBtn.TextColor3 = Color3.fromRGB(255,50,50); TogBtn.Font = Enum.Font.GothamBold
        TogBtn.TextSize = 14; TogBtn.Parent = SGui

        local function updateDrawings()
            FOVring.Position = Cam.ViewportSize / 2
            FOVring.Radius = aimbotFov * (Cam.ViewportSize.Y / 1080)
        end
        local function aimAt(pos)
            local cf = Cam.CFrame
            local dir = (pos - cf.Position).Unit
            local lv = cf.LookVector:Lerp(dir, aimSmoothness)
            Cam.CFrame = CFrame.new(cf.Position, cf.Position + lv)
        end
        local function getTarget()
            local best, bestD = nil, math.huge
            for _, e in ipairs(Workspace:GetChildren()) do
                if e:IsA("Model") and table.find({"Enemy","ChainsawGuy","AO825"}, e.Name)
                    and e:FindFirstChild("Humanoid") and e:FindFirstChild("Head") then
                    if e.Humanoid.Health > 0 then
                        local sp, onScreen = Cam:WorldToViewportPoint(e.Head.Position)
                        if onScreen then
                            local d = (Vector2.new(sp.X,sp.Y) - Cam.ViewportSize/2).Magnitude
                            if d <= aimbotFov and d < bestD then bestD = d; best = e.Head.Position end
                        end
                    end
                end
            end
            return best
        end
        -- Проверка: держит ли игрок оружие в руках
        local function isHoldingWeapon()
            local char = LP.Character
            if not char then return false end
            return char:FindFirstChildOfClass("Tool") ~= nil
        end

        RunService.Heartbeat:Connect(function()
            updateDrawings()
            local holding = isHoldingWeapon()
            -- FOV кольцо видно только когда включён И держим оружие
            FOVring.Visible = isAiming and holding
            if isAiming and holding then
                local t = getTarget()
                if t then aimAt(t) end
            end
            -- Обновляем цвет/текст кнопки
            if isAiming then
                if holding then
                    TogBtn.Text = "AIMBOT: ON"
                    TogBtn.TextColor3 = Color3.fromRGB(50,255,50)
                else
                    TogBtn.Text = "AIMBOT: NO WEAPON"
                    TogBtn.TextColor3 = Color3.fromRGB(255,165,0)
                end
            end
        end)
        TogBtn.MouseButton1Click:Connect(function()
            isAiming = not isAiming
            if not isAiming then
                FOVring.Visible = false
                TogBtn.Text = "AIMBOT: OFF"
                TogBtn.TextColor3 = Color3.fromRGB(255,50,50)
            end
        end)
        local dragging, dragInput, dragStart2, startPos2
        TogBtn.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = true; dragStart2 = inp.Position; startPos2 = TogBtn.Position
                inp.Changed:Connect(function() if inp.UserInputState == Enum.UserInputState.End then dragging = false end end)
            end
        end)
        TogBtn.InputChanged:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then dragInput = inp end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if inp == dragInput and dragging then
                local delta = inp.Position - dragStart2
                TogBtn.Position = UDim2.new(startPos2.X.Scale, startPos2.X.Offset+delta.X, startPos2.Y.Scale, startPos2.Y.Offset+delta.Y)
            end
        end)
        Players.PlayerRemoving:Connect(function() FOVring:Remove(); SGui:Destroy() end)
        Logging.new("crosshairs","Aimbot launched. Click the button on screen.",4)
    end
})

-- ============================================================
-- ВКЛАДКА: SETTINGS (Visuals + Collection Settings)
-- ============================================================
local SettingsTab = window:AddTab({ Icon = "gear", Name = "Settings" })

-- ---- VISUALS & MISC ----
local VisualsSection = SettingsTab:AddSection({ Name = "VISUALS & MISC" })

local noFogToggle = VisualsSection:AddLabel("No Fog"):AddToggle({
    Default = false, Flag = "NoFog",
    Callback = function(v)
        noFogEnabled = v
        if v then Lighting.FogStart = 999999; Lighting.FogEnd = 999999
        else Lighting.FogStart = originalFogStart; Lighting.FogEnd = originalFogEnd end
    end
})
local fullBrightToggle = VisualsSection:AddLabel("Full Bright"):AddToggle({
    Default = false, Flag = "FullBright",
    Callback = function(v)
        fullBrightEnabled = v
        if v then Lighting.Ambient = Color3.fromRGB(255,255,255); Lighting.Brightness = 2; Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
        else Lighting.Ambient = originalAmbient; Lighting.Brightness = originalBrightness; Lighting.OutdoorAmbient = originalOutdoorAmbient end
    end
})
local antiVoidToggle = VisualsSection:AddLabel("Anti-Void"):AddToggle({
    Default = false, Flag = "AntiVoid",
    Callback = function(v) antiVoidEnabled = v; Logging.new("shield","Anti-Void: "..(v and "ON" or "OFF"),3) end
})
local bringNpcToggle = VisualsSection:AddLabel("Bring ALL NPCs"):AddToggle({
    Default = false, Flag = "BringNPCs",
    Callback = function(v) bringAllNpcEnabled = v; Logging.new("person","Bring NPCs: "..(v and "ON" or "OFF"),3) end
})
local genPPToggle = VisualsSection:AddLabel("Auto Repair Generators"):AddToggle({
    Default = false, Flag = "GenPP",
    Callback = function(v) generatorPPEnabled = v; Logging.new("bolt","Auto Generator: "..(v and "ON" or "OFF"),3) end
})

VisualsSection:AddButton({
    Name = "Instant Heal (Attempt)",
    Icon = "heart",
    Callback = function()
        local hum = getHum(LP.Character)
        if hum then hum.Health = hum.MaxHealth; Logging.new("heart","Health set to Max.",4)
        else Logging.new("triangle-exclamation","Character not found.",3) end
    end
})

VisualsSection:AddButton({
    Name = "Teleport to Exit",
    Icon = "door-open",
    Callback = function()
        local root = getRoot(LP.Character)
        local exitPart = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("ExitPart")
        if root and exitPart then
            root.CFrame = exitPart.CFrame + Vector3.new(0,3,0)
            Logging.new("door-open","Teleported to Exit.",4)
        else Logging.new("triangle-exclamation","Exit Part not found.",5) end
    end
})

-- ---- COLLECTION SETTINGS ----
local ColSetSection = SettingsTab:AddSection({ Name = "COLLECTION SETTINGS" })

ColSetSection:AddLabel("Collection Timeout (sec)"):AddTextInput({
    Default = "5.0", Placeholder = "seconds", Size = 80, Flag = "ColTimeout",
    Callback = function(v) collectTimeout = tonumber(v) or 5.0 end
})
ColSetSection:AddLabel("Teleport Delay (sec)"):AddTextInput({
    Default = "0.2", Placeholder = "seconds", Size = 80, Flag = "TpDelay",
    Callback = function(v) teleportDelay = tonumber(v) or 0.2 end
})
ColSetSection:AddLabel("Fire PP Delay (sec)"):AddTextInput({
    Default = "0.2", Placeholder = "seconds", Size = 80, Flag = "PPDelay",
    Callback = function(v) firePPDelay = tonumber(v) or 0.2 end
})

-- ============================================================
-- ВКЛАДКА: CONFIG
-- ============================================================
local CfgTab = window:AddTab({ Icon = "folder", Name = "Config" })
local CfgSection = CfgTab:AddSection({ Name = "SAVE / LOAD" })

local configNameInput = CfgSection:AddLabel("Config Name"):AddTextInput({
    Default = "", Placeholder = "Enter name...", Size = 120, Flag = "ConfigName",
    Callback = function() end
})
CfgSection:AddButton({
    Name = "Save Config", Icon = "arrow-down-to-line",
    Callback = function() saveConfig(configNameInput:GetValue()) end
})

local CfgListSection = CfgTab:AddSection({ Name = "CONFIGS" })
local configDropdown = CfgListSection:AddLabel("Select Config"):AddDropdown({
    Default = nil, Values = getConfigList(), AutoUpdate = true, Size = 120, Flag = "ConfigSelect",
    Callback = function() end
})
CfgListSection:AddButton({
    Name = "Load Selected", Icon = "arrow-right-from-portrait-rectangle",
    Callback = function()
        local name = configDropdown:GetValue()
        if not name or name == "" then Logging.new("triangle-exclamation","Select a config",3); return end
        local path = CONFIG_FOLDER.."/"..name..".json"
        if not isfile(path) then Logging.new("triangle-exclamation","File not found",3); return end
        local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
        if not ok or not data then Logging.new("triangle-exclamation","Load error",3); return end
        -- Применяем сохранённые значения
        if data.antiVoid   ~= nil then antiVoidToggle:SetValue(data.antiVoid) end
        if data.fullBright ~= nil then fullBrightToggle:SetValue(data.fullBright) end
        if data.noFog      ~= nil then noFogToggle:SetValue(data.noFog) end
        if data.antiAfk    ~= nil then antiAfkToggle:SetValue(data.antiAfk) end
        if data.ghostMode  ~= nil then ghostToggle:SetValue(data.ghostMode) end
        if data.nameEsp    ~= nil then nameEspToggle:SetValue(data.nameEsp) end
        if data.playersEsp ~= nil then playersEspToggle:SetValue(data.playersEsp) end
        if data.enemyEsp   ~= nil then enemyEspToggle:SetValue(data.enemyEsp) end
        if data.chainsawEsp ~= nil then chainsawEspToggle:SetValue(data.chainsawEsp) end
        if data.gateHighlight ~= nil then gateHighlightToggle:SetValue(data.gateHighlight) end
        if data.walkspeed  ~= nil then walkspeedToggle:SetValue(data.walkspeed) end
        if data.jumpPower  ~= nil then jumpToggle:SetValue(data.jumpPower) end
        if data.autoCollect ~= nil then autoCollectToggle:SetValue(data.autoCollect) end
        if data.bringItems ~= nil then bringItemsToggle:SetValue(data.bringItems) end
        if data.bringNpcs  ~= nil then bringNpcToggle:SetValue(data.bringNpcs) end
        if data.genPP      ~= nil then genPPToggle:SetValue(data.genPP) end
        if data.animBypass ~= nil then animBypassToggle:SetValue(data.animBypass) end
        if data.float      ~= nil then floatToggle:SetValue(data.float) end
        Logging.new("folder","Loaded: "..name,3)
    end
})
CfgListSection:AddButton({
    Name = "Delete Selected", Icon = "trash-can",
    Callback = function()
        local name = configDropdown:GetValue()
        if not name or name == "" then Logging.new("triangle-exclamation","Select a config",3); return end
        local path = CONFIG_FOLDER.."/"..name..".json"
        if isfile(path) then delfile(path); configDropdown:SetValues(getConfigList()); configDropdown:SetValue(nil); Logging.new("trash-can","Deleted: "..name,3) end
    end
})
CfgListSection:AddButton({
    Name = "Refresh List", Icon = "arrow-rotate-right",
    Callback = function() configDropdown:SetValues(getConfigList()); Logging.new("arrow-rotate-right","List refreshed",2) end
})

-- ============================================================
-- НАСТРОЙКИ МЕНЮ (USER SETTINGS)
-- ============================================================
window.UserSettings:AddLabel("Menu Keybind"):AddKeybind({
    Default = "K",
    Callback = function(v) window.Keybind = v; Logging.new("ps4-touchpad","Keybind: "..tostring(v),5) end,
})
window.UserSettings:AddLabel("Menu Scale"):AddDropdown({
    Default = isMobile and "Mobile" or "Default",
    Values = {"Default","Large","Mobile","Small"},
    Callback = function(v) window:SetSize(XenonLib.Scales[v]); Logging.new("crop","Scale: "..tostring(v),5) end,
})

-- ============================================================
-- ПЕРСОНАЖ: ПОСТОЯННОЕ ПРИМЕНЕНИЕ НАСТРОЕК
-- ============================================================
local function ApplyPermanentMovement(char)
    local hum = getHum(char)
    if hum then
        if walkspeedBoostActive then hum.WalkSpeed = boostedWalkspeed end
        if jumpBoostActive then hum.JumpPower = boostedJumpPower end
        if animationBypassEnabled then
            local anim = char:FindFirstChild("Animate"); if anim then anim:Destroy() end
        end
    end
    if ghostModeEnabled and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.LocalTransparencyModifier = 1 end
        end
    end
end

local charConn = LP.CharacterAdded:Connect(function(newChar)
    task.wait(1)
    ApplyPermanentMovement(newChar)
end)
table.insert(getgenv().XenonConnections, charConn)
if LP.Character then ApplyPermanentMovement(LP.Character) end

-- Cutscene Remover
local MapFolder = Workspace:FindFirstChild("Map")
local function removeCutscene(child)
    if child and child.Name:match("Cutscene") then
        if child:IsA("Script") or child:IsA("LocalScript") or child:IsA("ModuleScript") or child:IsA("Folder") then
            child:Destroy(); Logging.new("xmark","Cutscene '"..child.Name.."' removed.",2)
        end
    end
end
if MapFolder then
    for _, child in ipairs(MapFolder:GetChildren()) do removeCutscene(child) end
    local cutConn = MapFolder.ChildAdded:Connect(removeCutscene)
    table.insert(getgenv().XenonConnections, cutConn)
end

-- ============================================================
-- ГЛАВНЫЙ HEARTBEAT LOOP
-- ============================================================
local steppedConn = RunService.Stepped:Connect(function()
    local char = LP.Character
    local root = char and getRoot(char)
    local hum  = char and getHum(char)
    if not root then return end

    -- Скорость / прыжок
    if hum then
        if walkspeedBoostActive then hum.WalkSpeed = boostedWalkspeed end
        if jumpBoostActive then hum.JumpPower = boostedJumpPower end
    end

    -- Нокилп (каждый кадр)
    if noclipEnabled and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- Generator auto proximity
    if generatorPPEnabled and not collecting then
        local best, bestD = nil, math.huge
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name:lower() == "generator" and (v:IsA("Model") or v:IsA("BasePart")) then
                local rp = getRoot(v)
                if rp and rp:IsA("BasePart") then
                    local d = (rp.Position - root.Position).Magnitude
                    if d < bestD then bestD = d; best = rp end
                end
            end
        end
        if best then
            local co = coroutine.wrap(function()
                collecting = true; local savedPos = root.CFrame; toggleNoclip(true)
                if best:IsDescendantOf(Workspace) then
                    root.CFrame = best.CFrame; task.wait(teleportDelay)
                    root.CFrame = root.CFrame * CFrame.new(0,0,-5); task.wait(teleportDelay)
                    root.CFrame = best.CFrame; task.wait(teleportDelay)
                    if ActivateGeneratorRemote and ActivateGeneratorRemote:IsA("RemoteEvent") then
                        ActivateGeneratorRemote:FireServer(best)
                    end
                end
                toggleNoclip(false); root.CFrame = savedPos; collecting = false
            end)
            co()
        end
    end

    -- Bring ALL NPCs
    if bringAllNpcEnabled then
        local targetPos = root.CFrame.p + root.CFrame.LookVector * 5
        for _, e in ipairs(Workspace:GetChildren()) do
            if e:IsA("Model") and (e.Name=="Enemy" or e.Name=="ChainsawGuy" or e.Name=="AO825") and e:FindFirstChild("Humanoid") then
                local nr = getRoot(e); if nr then nr.CFrame = CFrame.new(targetPos) end
            end
        end
    end

    -- Auto-Collect
    if autoCollectEnabled and #selectedItems > 0 and not collecting then
        for _, selName in ipairs(selectedItems) do
            local part = getClosestPart(selName)
            if part then
                local co = coroutine.wrap(function()
                    collecting = true; local savedPos = root.CFrame; toggleNoclip(true)
                    local h = char:FindFirstChildOfClass("Humanoid")
                    if h and h.SeatPart then h.Sit = false; task.wait(teleportDelay) end
                    root.CFrame = part.CFrame; task.wait(teleportDelay)
                    for j=1,5 do firepp(part); task.wait(firePPDelay); if not part:IsDescendantOf(Workspace) then break end end
                    toggleNoclip(false); root.CFrame = savedPos
                    Logging.new("check","Auto-Collected: "..selName,2)
                    collecting = false
                end)
                co(); break
            end
        end
    end

    -- Bring ALL Items
    if bringAllItemsEnabled then
        local rootPos = root.CFrame.p
        for _, itemName in ipairs(allItems) do
            for _, part in ipairs(findAllParts(itemName)) do
                if part and part.Parent and part:IsA("BasePart") then
                    local itemPos = part.CFrame.p
                    if (itemPos - rootPos).Magnitude > 5 then
                        local dir = (rootPos - itemPos).Unit
                        part.CFrame = CFrame.new(itemPos + dir * DRAG_SPEED_DISTANCE + Vector3.new(0,1,0))
                    end
                end
            end
        end
    end

    -- Anti-Void
    if antiVoidEnabled and root.Position.Y < -50 then
        root.CFrame = root.CFrame + Vector3.new(0,50,0)
        Logging.new("shield","Anti-Void triggered!",2)
    end

    -- Float
    if floatEnabled then
        root.CFrame = CFrame.new(root.CFrame.X, lockedYPosition, root.CFrame.Z)
        if hum and not hum.PlatformStand then hum.PlatformStand = true end
    elseif hum and hum.PlatformStand then
        hum.PlatformStand = false
    end

    -- Anti-AFK
    if antiAfkEnabled and Cam and Cam.CameraType ~= Enum.CameraType.Scriptable then
        Cam.CFrame = Cam.CFrame * CFrame.Angles(0,0,0.0001)
    end

    -- ---- ESP ----
    local activePlayers, activeEnemies, activeChainsawGuys, activeGates = {},{},{},{}

    -- ChainsawGuy ESP
    if chainsawGuyEspEnabled then
        for _, e in ipairs(Workspace:GetChildren()) do
            if e:IsA("Model") and e.Name=="ChainsawGuy" and e:FindFirstChild("Humanoid") and e:FindFirstChild("Head") then
                local rp = getRoot(e); local eh = e.Humanoid
                if rp and eh.Health > 0 then
                    activeChainsawGuys[e] = true
                    local headPos, onScreen = Cam:WorldToViewportPoint(rp.Position + Vector3.new(0,4,0))
                    local hl = chainsawGuyHighlights[e]
                    if not hl or not hl.Parent then
                        hl = Instance.new("Highlight"); hl.OutlineColor = Color3.fromRGB(255,165,0)
                        hl.FillTransparency = 1; hl.Parent = e; chainsawGuyHighlights[e] = hl
                    end
                    hl.Enabled = true
                    if onScreen then
                        local fp = Cam:WorldToViewportPoint(rp.Position - Vector3.new(0,3,0))
                        local h2 = math.abs(headPos.Y - fp.Y); local w = h2*0.4
                        local box = chainsawGuyBoxes[e]
                        if not box then box = Drawing.new("Square"); box.Color = Color3.fromRGB(255,165,0); box.Thickness = 2; box.Filled = false; chainsawGuyBoxes[e] = box end
                        box.Size = Vector2.new(w,h2); box.Position = Vector2.new(fp.X-w/2, fp.Y-h2); box.Visible = true
                    else
                        if chainsawGuyBoxes[e] then chainsawGuyBoxes[e].Visible = false end
                    end
                end
            end
        end
        for e, box in pairs(chainsawGuyBoxes) do
            if not activeChainsawGuys[e] or not e:IsDescendantOf(Workspace) then if box then box:Remove() end; chainsawGuyBoxes[e] = nil end
        end
        for e, hl in pairs(chainsawGuyHighlights) do
            if not activeChainsawGuys[e] or not e:IsDescendantOf(Workspace) then if hl then hl:Destroy() end; chainsawGuyHighlights[e] = nil end
        end
    end

    -- Gate Highlights
    if highlightGatesEnabled then
        for _, name in ipairs({"GatePart1","GatePart2"}) do
            local gp = Workspace:FindFirstChild(name, true)
            if gp and gp:IsA("BasePart") then
                local hl = gateHighlights[gp]
                if not hl or not hl.Parent then
                    hl = Instance.new("Highlight"); hl.OutlineColor = Color3.fromRGB(255,0,255)
                    hl.FillTransparency = 0.5; hl.Parent = gp; gateHighlights[gp] = hl
                end
                hl.Enabled = true; activeGates[gp] = true
            end
        end
    end
    for gp, hl in pairs(gateHighlights) do
        if not highlightGatesEnabled or not activeGates[gp] or not gp:IsDescendantOf(Workspace) then
            if hl then hl:Destroy() end; gateHighlights[gp] = nil
        end
    end

    -- Player ESP
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local pc = p.Character; local rp = getRoot(pc); local ph = getHum(pc)
            local nameLabel = playerNameLabels[p]
            if (playersEspEnabled or nameEspEnabled) and rp and ph and ph.Health > 0 then
                local headPos, onScreen = Cam:WorldToViewportPoint(rp.Position + Vector3.new(0,4,0))
                if onScreen then
                    activePlayers[pc] = true
                    if nameEspEnabled then
                        if not nameLabel then nameLabel = Drawing.new("Text"); nameLabel.Text = p.Name; nameLabel.Color = Color3.fromRGB(255,255,255); nameLabel.Outline = true; nameLabel.Size = 14; playerNameLabels[p] = nameLabel end
                        nameLabel.Position = Vector2.new(headPos.X, headPos.Y-20); nameLabel.Visible = true
                    elseif nameLabel then nameLabel.Visible = false end
                    if playersEspEnabled then
                        local fp = Cam:WorldToViewportPoint(rp.Position - Vector3.new(0,3,0))
                        local h2 = math.abs(headPos.Y-fp.Y); local w = h2*0.4
                        local box = playerBoxes[pc]
                        if not box then box = Drawing.new("Square"); box.Color = Color3.fromRGB(0,255,0); box.Thickness = 1; box.Filled = false; playerBoxes[pc] = box end
                        box.Size = Vector2.new(w,h2); box.Position = Vector2.new(fp.X-w/2, fp.Y-h2); box.Visible = true
                        local hl2 = playerHealthLabels[pc]
                        if not hl2 then hl2 = Drawing.new("Text"); hl2.Outline = true; playerHealthLabels[pc] = hl2 end
                        local hr = ph.Health/ph.MaxHealth; hl2.Color = Color3.fromHSV(0.33*hr,1,1)
                        hl2.Text = string.format("HP: %d", math.floor(ph.Health))
                        hl2.Position = Vector2.new(box.Position.X+w+5, box.Position.Y+h2/2); hl2.Visible = true
                    else
                        if playerBoxes[pc] then playerBoxes[pc].Visible = false end
                        if playerHealthLabels[pc] then playerHealthLabels[pc].Visible = false end
                    end
                    local hl3 = playerHighlights[pc]
                    if not hl3 or not hl3.Parent then hl3 = Instance.new("Highlight"); hl3.OutlineColor = Color3.fromRGB(0,255,0); hl3.FillTransparency = 1; hl3.Parent = pc; playerHighlights[pc] = hl3 end
                    hl3.Enabled = playersEspEnabled or nameEspEnabled
                else
                    if nameLabel then nameLabel.Visible = false end
                    if playerBoxes[pc] then playerBoxes[pc].Visible = false end
                    if playerHealthLabels[pc] then playerHealthLabels[pc].Visible = false end
                    if playerHighlights[pc] then playerHighlights[pc].Enabled = false end
                end
            else
                if nameLabel then nameLabel.Visible = false end
                if playerHighlights[pc] then playerHighlights[pc].Enabled = false end
                if playerBoxes[pc] then playerBoxes[pc].Visible = false end
                if playerHealthLabels[pc] then playerHealthLabels[pc].Visible = false end
            end
        end
    end
    for p, lbl in pairs(playerNameLabels) do
        if not Players:FindFirstChild(p.Name) or not nameEspEnabled then if lbl then lbl:Remove() end; playerNameLabels[p] = nil end
    end

    -- Enemy ESP
    if enemyEspEnabled then
        for _, e in ipairs(Workspace:GetChildren()) do
            if e:IsA("Model") and (e.Name=="Enemy" or e.Name=="AO825") and e:FindFirstChild("Humanoid") and e:FindFirstChild("Head") then
                local eh = e.Humanoid; local rp = getRoot(e)
                if rp and eh.Health > 0 then
                    activeEnemies[e] = true
                    local col = e.Name=="AO825" and Color3.fromRGB(0,255,255) or Color3.fromRGB(255,0,0)
                    local hl = enemyHighlights[e]
                    if not hl or not hl.Parent then hl = Instance.new("Highlight"); hl.OutlineColor = col; hl.FillTransparency = 1; hl.Parent = e; enemyHighlights[e] = hl end
                    hl.Enabled = true
                    local hp, osh = Cam:WorldToViewportPoint(rp.Position + Vector3.new(0,4,0))
                    local fp, osf = Cam:WorldToViewportPoint(rp.Position - Vector3.new(0,3,0))
                    if osh and osf then
                        local h2 = math.abs(hp.Y-fp.Y); local w = h2*0.4
                        local box = enemyBoxes[e]
                        if not box then box = Drawing.new("Square"); box.Color = col; box.Thickness = 1; box.Filled = false; enemyBoxes[e] = box end
                        box.Size = Vector2.new(w,h2); box.Position = Vector2.new(fp.X-w/2, fp.Y-h2); box.Color = col; box.Visible = true
                        local hlbl = enemyHealthLabels[e]
                        if not hlbl then hlbl = Drawing.new("Text"); hlbl.Outline = true; enemyHealthLabels[e] = hlbl end
                        local hr = eh.Health/eh.MaxHealth; hlbl.Color = Color3.fromHSV(0.33*hr,1,1)
                        hlbl.Text = string.format("%s HP: %d", e.Name, math.floor(eh.Health))
                        hlbl.Position = Vector2.new(box.Position.X+w+5, box.Position.Y+h2/2); hlbl.Visible = true
                    else
                        if enemyBoxes[e] then enemyBoxes[e].Visible = false end
                        if enemyHealthLabels[e] then enemyHealthLabels[e].Visible = false end
                    end
                end
            end
        end
    end
    for e, hl in pairs(enemyHighlights) do if not activeEnemies[e] or not enemyEspEnabled then if hl then hl:Destroy() end; enemyHighlights[e] = nil end end
    for e, box in pairs(enemyBoxes) do if not activeEnemies[e] or not enemyEspEnabled then if box then box:Remove() end; enemyBoxes[e] = nil end end
    for e, lbl in pairs(enemyHealthLabels) do if not activeEnemies[e] or not enemyEspEnabled then if lbl then lbl:Remove() end; enemyHealthLabels[e] = nil end end
    for pc, hl in pairs(playerHighlights) do if not activePlayers[pc] and hl then hl:Destroy(); playerHighlights[pc] = nil end end
end)

table.insert(getgenv().XenonConnections, steppedConn)

-- ============================================================
-- УВЕДОМЛЕНИЕ О ЗАПУСКЕ
-- ============================================================
Notification.new({
    Title = "Brother's Vow",
    Content = "Loaded | "..(isMobile and "Mobile (button added)" or "PC (press K)"),
    Duration = 5,
})
