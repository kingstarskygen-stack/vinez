-- Modern Dark Key System + Main Script Hub (English Version)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local CORRECT_KEY = "MY_FIRST_KEY_2026"

-- 1. Main ScreenGui Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EtinityHub_Protected"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- ==========================================
-- FUNCTION: CREATE MAIN HUB (Opens after key)
-- ==========================================
local function CreateMainHub()
    -- Główne okno Hubu
    local HubFrame = Instance.new("Frame")
    HubFrame.Size = UDim2.new(0, 450, 0, 280)
    HubFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
    HubFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    HubFrame.BorderSizePixel = 0
    HubFrame.Active = true
    HubFrame.Draggable = true
    HubFrame.Parent = ScreenGui
    
    local HubCorner = Instance.new("UICorner")
    HubCorner.CornerRadius = UDim.new(0, 4)
    HubCorner.Parent = HubFrame
    
    local HubStroke = Instance.new("UIStroke")
    HubStroke.Color = Color3.fromRGB(35, 35, 35)
    HubStroke.Thickness = 1
    HubStroke.Parent = HubFrame

    -- Pasek boczny (Sidebar dla zakładek)
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 120, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = HubFrame
    
    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 4)
    SidebarCorner.Parent = Sidebar

    -- Tytuł w Hubie
    local HubTitle = Instance.new("TextLabel")
    HubTitle.Size = UDim2.new(0, 120, 0, 40)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = "Etinity Hub"
    HubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    HubTitle.TextSize = 15
    HubTitle.Font = Enum.Font.GothamBold
    HubTitle.Parent = Sidebar

    -- Kontener na przyciski/funkcje (Główny panel)
    local MainContent = Instance.new("Frame")
    MainContent.Size = UDim2.new(1, -130, 1, -10)
    MainContent.Position = UDim2.new(0, 125, 0, 5)
    MainContent.BackgroundTransparency = 1
    MainContent.Parent = HubFrame

    -- --- FUNKCJA: PRZYCISK "SPEED" ---
    local SpeedButton = Instance.new("TextButton")
    SpeedButton.Size = UDim2.new(1, 0, 0, 40)
    SpeedButton.Position = UDim2.new(0, 0, 0, 10)
    SpeedButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SpeedButton.Text = "Enable Super Speed (100)"
    SpeedButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    SpeedButton.Font = Enum.Font.Gotham
    SpeedButton.TextSize = 12
    SpeedButton.Parent = MainContent
    
    Instance.new("UICorner", SpeedButton).CornerRadius = UDim.new(0, 4)
    local SpeedStroke = Instance.new("UIStroke", SpeedButton)
    SpeedStroke.Color = Color3.fromRGB(40, 40, 40)

    local speedActive = false
    SpeedButton.MouseButton1Click:Connect(function()
        speedActive = not speedActive
        local char = Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            if speedActive then
                hum.WalkSpeed = 100
                SpeedButton.TextColor3 = Color3.fromRGB(46, 204, 113) -- Zielony tekst gdy włączone
                SpeedButton.Text = "Disable Super Speed"
            else
                hum.WalkSpeed = 16 -- Domyślna prędkość
                SpeedButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                SpeedButton.Text = "Enable Super Speed (100)"
            end
        end
    end)

    -- --- FUNKCJA: PRZYCISK "JUMP" ---
    local JumpButton = Instance.new("TextButton")
    JumpButton.Size = UDim2.new(1, 0, 0, 40)
    JumpButton.Position = UDim2.new(0, 0, 0, 60)
    JumpButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    JumpButton.Text = "Enable Infinite Jump"
    JumpButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    JumpButton.Font = Enum.Font.Gotham
    JumpButton.TextSize = 12
    JumpButton.Parent = MainContent
    
    Instance.new("UICorner", JumpButton).CornerRadius = UDim.new(0, 4)
    local JumpStroke = Instance.new("UIStroke", JumpButton)
    JumpStroke.Color = Color3.fromRGB(40, 40, 40)

    local infJumpActive = false
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if infJumpActive then
            local char = Players.LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState("Jumping")
            end
        end
    end)

    JumpButton.MouseButton1Click:Connect(function()
        infJumpActive = not infJumpActive
        if infJumpActive then
            JumpButton.TextColor3 = Color3.fromRGB(46, 204, 113)
            JumpButton.Text = "Disable Infinite Jump"
        else
            JumpButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            JumpButton.Text = "Enable Infinite Jump"
        end
    end)
end

-- ==========================================
-- SYSTEM KLUCZA (Z poprzedniego kroku)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 240)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 4)
FrameCorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Thickness = 1
UIStroke.Parent = MainFrame

-- Spadające gwiazdy w tle
local starsContainer = Instance.new("Frame")
starsContainer.Size = UDim2.new(1, 0, 1, 0)
starsContainer.BackgroundTransparency = 1
starsContainer.Parent = MainFrame

local function createStar()
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    star.Position = UDim2.new(math.random(), 0, -0.05, 0)
    star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    star.BackgroundTransparency = math.random(2, 6) / 10
    star.BorderSizePixel = 0
    star.Parent = starsContainer
    Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)

    local speed = math.random(40, 90) / 100
    local connection
    connection = RunService.RenderStepped:Connect(function(deltaTime)
        if not star or not star.Parent then connection:Disconnect() return end
        star.Position = star.Position + UDim2.new(0, 0, 0, speed * deltaTime * 150)
        if star.Position.Y.Scale > 1.05 then connection:Disconnect() star:Destroy() end
    end)
end

task.spawn(function()
    while MainFrame and MainFrame.Parent do
        createStar()
        task.wait(math.random(3, 8) / 10)
    end
end)

-- Teksty i Przyciski okna klucza
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "SECURITY VERIFICATION"
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Please enter your access key below"
Subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.Parent = MainFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 290, 0, 42)
KeyInput.Position = UDim2.new(0.5, -145, 0.45, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
KeyInput.Text = ""
KeyInput.PlaceholderText = "Enter key code..."
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
KeyInput.TextSize = 13
KeyInput.Font = Enum.Font.Gotham
KeyInput.Parent = MainFrame
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 4)
local InputStroke = Instance.new("UIStroke", KeyInput)
InputStroke.Color = Color3.fromRGB(40, 40, 40)

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0, 290, 0, 42)
SubmitButton.Position = UDim2.new(0.5, -145, 0.7, 5)
SubmitButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SubmitButton.Text = "SUBMIT KEY"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.TextSize = 13
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.Parent = MainFrame
Instance.new("UICorner", SubmitButton).CornerRadius = UDim.new(0, 4)

-- Logika weryfikacji i przejścia
SubmitButton.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        SubmitButton.Text = "ACCESS GRANTED"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
        InputStroke.Color = Color3.fromRGB(39, 174, 96)
        
        -- Animacja znikania okna klucza
        local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2.new(0, 320, 0, 200), Position = UDim2.new(0.5, -160, 0.5, -100)})
        local strokeTween = TweenService:Create(UIStroke, TweenInfo.new(0.4), {Transparency = 1})
        
        Title.TextTransparency = 1
        Subtitle.TextTransparency = 1
        KeyInput.BackgroundTransparency = 1
        KeyInput.TextTransparency = 1
        InputStroke.Transparency = 1
        SubmitButton.BackgroundTransparency = 1
        SubmitButton.TextTransparency = 1
        starsContainer.BackgroundTransparency = 1
        
        fadeTween:Play()
        strokeTween:Play()
        
        fadeTween.Completed:Connect(function()
            MainFrame:Destroy() -- Usuwamy tylko okno klucza
            CreateMainHub()     -- Uruchamiamy funkcję tworzącą nowe Główne Menu!
        end)
    else
        SubmitButton.Text = "INVALID KEY! TRY AGAIN"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
        InputStroke.Color = Color3.fromRGB(192, 57, 43)
        task.wait(1.6)
        SubmitButton.Text = "SUBMIT KEY"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        InputStroke.Color = Color3.fromRGB(40, 40, 40)
    end
end)
