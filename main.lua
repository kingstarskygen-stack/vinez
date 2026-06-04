-- VINEZ HUB: Modern Dark UI with Key System and Star Effects (English)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local CORRECT_KEY = "MY_FIRST_KEY_2026"

-- Main ScreenGui Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VinezHub_Protected"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- ==========================================
-- FUNCTION: BACKGROUND STARS ANIMATION
-- ==========================================
local function SetupStars(parentFrame, density)
    local starsContainer = Instance.new("Frame")
    starsContainer.Size = UDim2.new(1, 0, 1, 0)
    starsContainer.BackgroundTransparency = 1
    starsContainer.ZIndex = 1
    starsContainer.Parent = parentFrame

    task.spawn(function()
        while parentFrame and parentFrame.Parent do
            local star = Instance.new("Frame")
            star.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
            star.Position = UDim2.new(math.random(), 0, -0.05, 0)
            star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            star.BackgroundTransparency = math.random(3, 6) / 10
            star.BorderSizePixel = 0
            star.ZIndex = math.max(1, parentFrame.ZIndex)
            star.Parent = starsContainer
            
            local starCorner = Instance.new("UICorner")
            starCorner.CornerRadius = UDim.new(1, 0)
            starCorner.Parent = star

            local speed = math.random(40, 90) / 100
            local connection
            connection = RunService.RenderStepped:Connect(function(deltaTime)
                if not star or not star.Parent then connection:Disconnect() return end
                star.Position = star.Position + UDim2.new(0, 0, 0, speed * deltaTime * 150)
                if star.Position.Y.Scale > 1.05 then connection:Disconnect() star:Destroy() end
            end)
            task.wait(density)
        end
    end)
end

-- ==========================================
-- FUNCTION: CREATE VINEZ MAIN HUB
-- ==========================================
local function CreateMainHub()
    local HubFrame = Instance.new("Frame")
    HubFrame.Size = UDim2.new(0, 480, 0, 300)
    HubFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
    HubFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    HubFrame.BorderSizePixel = 0
    HubFrame.ClipsDescendants = true
    HubFrame.Active = true
    HubFrame.Draggable = true
    HubFrame.ZIndex = 3
    HubFrame.Parent = ScreenGui
    
    local HubCorner = Instance.new("UICorner")
    HubCorner.CornerRadius = UDim.new(0, 4)
    HubCorner.Parent = HubFrame
    
    local HubStroke = Instance.new("UIStroke")
    HubStroke.Color = Color3.fromRGB(35, 35, 35)
    HubStroke.Thickness = 1
    HubStroke.Parent = HubFrame

    -- Odpalamy gwiazdy również w głównym menu!
    SetupStars(HubFrame, 0.5)

    -- Top Header Bar
    local HeaderBar = Instance.new("Frame")
    HeaderBar.Size = UDim2.new(1, 0, 0, 45)
    HeaderBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    HeaderBar.BorderSizePixel = 0
    HeaderBar.ZIndex = 4
    HeaderBar.Parent = HubFrame

    local HeaderStroke = Instance.new("Frame")
    HeaderStroke.Size = UDim2.new(1, 0, 0, 1)
    HeaderStroke.Position = UDim2.new(0, 0, 1, 0)
    HeaderStroke.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    HeaderStroke.BorderSizePixel = 0
    HeaderStroke.ZIndex = 4
    HeaderStroke.Parent = HeaderBar

    local HubTitle = Instance.new("TextLabel")
    HubTitle.Size = UDim2.new(0, 200, 1, 0)
    HubTitle.Position = UDim2.new(0, 15, 0, 0)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = "VINEZ HUB"
    HubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    HubTitle.TextSize = 16
    HubTitle.Font = Enum.Font.GothamBold
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left
    HubTitle.ZIndex = 4
    HubTitle.Parent = HeaderBar

    -- Right Sidebar (Tab Container)
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 110, 1, -46)
    Sidebar.Position = UDim2.new(1, -110, 0, 46)
    Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 4
    Sidebar.Parent = HubFrame

    local SidebarLine = Instance.new("Frame")
    SidebarLine.Size = UDim2.new(0, 1, 1, 0)
    SidebarLine.Position = UDim2.new(0, 0, 0, 0)
    SidebarLine.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SidebarLine.BorderSizePixel = 0
    SidebarLine.ZIndex = 4
    SidebarLine.Parent = Sidebar

    -- Left Content Area (Where functions go)
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -125, 1, -60)
    ContentFrame.Position = UDim2.new(0, 10, 0, 55)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ZIndex = 4
    ContentFrame.Parent = HubFrame

    -- Tab System List (Uporządkowanie zakładek jedna pod drugą)
    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.Padding = UDim.new(0, 4)
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsLayout.Parent = Sidebar

    local tabNames = {"Main", "Troll", "Spectate", "Teleport"}
    
    for i, name in ipairs(tabNames) do
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 95, 0, 32)
        TabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        TabButton.Text = name
        TabButton.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 140)
        TabButton.Font = (i == 1) and Enum.Font.GothamBold or Enum.Font.Gotham
        TabButton.TextSize = 12
        TabButton.BorderSizePixel = 0
        TabButton.ZIndex = 5
        TabButton.Parent = Sidebar
        
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 4)
        local TabStroke = Instance.new("UIStroke", TabButton)
        TabStroke.Color = (i == 1) and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(25, 25, 25)

        -- Placeholder action for switching tabs
        TabButton.MouseButton1Click:Connect(function()
            for _, btn in pairs(Sidebar:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.TextColor3 = Color3.fromRGB(140, 140, 140)
                    btn.Font = Enum.Font.Gotham
                    if btn:FindFirstChild("UIStroke") then btn.UIStroke.Color = Color3.fromRGB(25, 25, 25) end
                end
            end
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.Font = Enum.Font.GothamBold
            TabStroke.Color = Color3.fromRGB(50, 50, 50)
            
            print("Switched to tab: " .. name)
        end)
    end

    -- DEFAULT FUNCTION IN "MAIN" TAB: Speed Button
    local SpeedButton = Instance.new("TextButton")
    SpeedButton.Size = UDim2.new(1, 0, 0, 38)
    SpeedButton.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    SpeedButton.Text = "Super Speed (100)"
    SpeedButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    SpeedButton.Font = Enum.Font.Gotham
    SpeedButton.TextSize = 12
    SpeedButton.ZIndex = 5
    SpeedButton.Parent = ContentFrame
    
    Instance.new("UICorner", SpeedButton).CornerRadius = UDim.new(0, 4)
    local SpeedStroke = Instance.new("UIStroke", SpeedButton)
    SpeedStroke.Color = Color3.fromRGB(35, 35, 35)

    local speedActive = false
    SpeedButton.MouseButton1Click:Connect(function()
        speedActive = not speedActive
        local char = Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            if speedActive then
                hum.WalkSpeed = 100
                SpeedButton.TextColor3 = Color3.fromRGB(46, 204, 113)
                SpeedButton.Text = "Super Speed [ON]"
                SpeedStroke.Color = Color3.fromRGB(46, 204, 113)
            else
                hum.WalkSpeed = 16
                SpeedButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                SpeedButton.Text = "Super Speed (100)"
                SpeedStroke.Color = Color3.fromRGB(35, 35, 35)
            end
        end
    end)
end

-- ==========================================
-- SYSTEM KLUCZA (Key System Frame)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 240)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 2
MainFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 4)
FrameCorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Thickness = 1
UIStroke.Parent = MainFrame

SetupStars(MainFrame, 0.4)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "SECURITY VERIFICATION"
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 2
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Please enter your access key below"
Subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.ZIndex = 2
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
KeyInput.ZIndex = 2
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
SubmitButton.ZIndex = 2
SubmitButton.Parent = MainFrame
Instance.new("UICorner", SubmitButton).CornerRadius = UDim.new(0, 4)

SubmitButton.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        SubmitButton.Text = "ACCESS GRANTED"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
        InputStroke.Color = Color3.fromRGB(39, 174, 96)
        
        local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2.new(0, 320, 0, 200), Position = UDim2.new(0.5, -160, 0.5, -100)})
        local strokeTween = TweenService:Create(UIStroke, TweenInfo.new(0.4), {Transparency = 1})
        
        Title.TextTransparency = 1
        Subtitle.TextTransparency = 1
        KeyInput.BackgroundTransparency = 1
        KeyInput.TextTransparency = 1
        InputStroke.Transparency = 1
        SubmitButton.BackgroundTransparency = 1
        SubmitButton.TextTransparency = 1
        
        fadeTween:Play()
        strokeTween:Play()
        
        fadeTween.Completed:Connect(function()
            MainFrame:Destroy()
            CreateMainHub() -- Bezpieczne wywołanie nowego VINEZ HUB
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
