-- VINEZ HUB: Modern Dark UI with Left Sidebar, Icons, and Functions (English)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local CORRECT_KEY = "MY_FIRST_KEY_2026"

-- Usunięcie starego GUI, jeśli istnieje (żeby się nie dublowało przy testach)
if CoreGui:FindFirstChild("VinezHub_Protected") then
    CoreGui.VinezHub_Protected:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VinezHub_Protected"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- ==========================================
-- BACKGROUND STARS ANIMATION
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
            star.BackgroundTransparency = math.random(4, 8) / 10
            star.BorderSizePixel = 0
            star.ZIndex = math.max(1, parentFrame.ZIndex)
            star.Parent = starsContainer
            Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)

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
-- CREATE BUTTON TEMPLATE
-- ==========================================
local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 12
    Btn.ZIndex = 5
    Btn.Parent = parent
    
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(35, 35, 35)

    Btn.MouseButton1Click:Connect(callback)
    return Btn, Stroke
end

local function CreateInput(parent, placeholder)
    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(1, 0, 0, 36)
    Box.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Box.Text = ""
    Box.PlaceholderText = placeholder
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 12
    Box.ZIndex = 5
    Box.Parent = parent
    
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    local Stroke = Instance.new("UIStroke", Box)
    Stroke.Color = Color3.fromRGB(35, 35, 35)
    return Box
end

-- ==========================================
-- CREATE VINEZ MAIN HUB
-- ==========================================
local function CreateMainHub()
    local HubFrame = Instance.new("Frame")
    HubFrame.Size = UDim2.new(0, 520, 0, 320)
    HubFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
    HubFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    HubFrame.BorderSizePixel = 0
    HubFrame.ClipsDescendants = true
    HubFrame.Active = true
    HubFrame.Draggable = true
    HubFrame.ZIndex = 3
    HubFrame.Parent = ScreenGui
    
    Instance.new("UICorner", HubFrame).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", HubFrame).Color = Color3.fromRGB(35, 35, 35)

    SetupStars(HubFrame, 0.5)

    -- Top Header
    local HeaderBar = Instance.new("Frame")
    HeaderBar.Size = UDim2.new(1, 0, 0, 40)
    HeaderBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    HeaderBar.BorderSizePixel = 0
    HeaderBar.ZIndex = 4
    HeaderBar.Parent = HubFrame

    local HubTitle = Instance.new("TextLabel")
    HubTitle.Size = UDim2.new(0, 200, 1, 0)
    HubTitle.Position = UDim2.new(0, 15, 0, 0)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = "VINEZ HUB"
    HubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    HubTitle.TextSize = 14
    HubTitle.Font = Enum.Font.GothamBold
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left
    HubTitle.ZIndex = 4
    HubTitle.Parent = HeaderBar

    -- LEFT Sidebar (Zakładki po lewej)
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 130, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 4
    Sidebar.Parent = HubFrame

    local SidebarLine = Instance.new("Frame")
    SidebarLine.Size = UDim2.new(0, 1, 1, 0)
    SidebarLine.Position = UDim2.new(1, 0, 0, 0)
    SidebarLine.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SidebarLine.BorderSizePixel = 0
    SidebarLine.ZIndex = 4
    SidebarLine.Parent = Sidebar

    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.Padding = UDim.new(0, 6)
    TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Parent = Sidebar

    -- Spacer for padding at the top of tabs
    local TabSpacer = Instance.new("Frame")
    TabSpacer.Size = UDim2.new(1, 0, 0, 4)
    TabSpacer.BackgroundTransparency = 1
    TabSpacer.Parent = Sidebar

    -- Content Area (Miejsce na opcje po prawej od zakładek)
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -145, 1, -55)
    ContentContainer.Position = UDim2.new(0, 140, 0, 50)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ZIndex = 4
    ContentContainer.Parent = HubFrame

    local Pages = {}

    -- Tab Data (Name, Icon ID)
    local tabData = {
        {Name = "Main", Icon = "rbxassetid://6034509993"},
        {Name = "Troll", Icon = "rbxassetid://6031280882"},
        {Name = "Spectate", Icon = "rbxassetid://6031280006"},
        {Name = "Teleport", Icon = "rbxassetid://6031262656"}
    }

    local activeTabBtn = nil

    for i, data in ipairs(tabData) do
        -- TAB BUTTON
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 115, 0, 34)
        TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        TabBtn.Text = "" -- Text handled by label
        TabBtn.AutoButtonColor = false
        TabBtn.ZIndex = 5
        TabBtn.Parent = Sidebar
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 4)
        local TabStroke = Instance.new("UIStroke", TabBtn)
        TabStroke.Color = (i == 1) and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(25, 25, 25)

        -- ICON
        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0, 16, 0, 16)
        Icon.Position = UDim2.new(0, 10, 0.5, -8)
        Icon.BackgroundTransparency = 1
        Icon.Image = data.Icon
        Icon.ImageColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 140)
        Icon.ZIndex = 6
        Icon.Parent = TabBtn

        -- TEXT
        local TabText = Instance.new("TextLabel")
        TabText.Size = UDim2.new(1, -35, 1, 0)
        TabText.Position = UDim2.new(0, 35, 0, 0)
        TabText.BackgroundTransparency = 1
        TabText.Text = data.Name
        TabText.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 140)
        TabText.Font = (i == 1) and Enum.Font.GothamBold or Enum.Font.Gotham
        TabText.TextSize = 12
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.ZIndex = 6
        TabText.Parent = TabBtn

        -- PAGE CONTAINER
        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 2
        Page.Visible = (i == 1)
        Page.ZIndex = 5
        Page.Parent = ContentContainer
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Parent = Page

        Pages[data.Name] = Page

        if i == 1 then activeTabBtn = TabBtn end

        -- TAB CLICK LOGIC
        TabBtn.MouseButton1Click:Connect(function()
            -- Reset all tabs
            for _, btn in pairs(Sidebar:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.UIStroke.Color = Color3.fromRGB(25, 25, 25)
                    btn:FindFirstChild("TextLabel").TextColor3 = Color3.fromRGB(140, 140, 140)
                    btn:FindFirstChild("TextLabel").Font = Enum.Font.Gotham
                    btn:FindFirstChild("ImageLabel").ImageColor3 = Color3.fromRGB(140, 140, 140)
                end
            end
            -- Hide all pages
            for _, p in pairs(Pages) do p.Visible = false end

            -- Highlight selected
            TabStroke.Color = Color3.fromRGB(60, 60, 60)
            TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabText.Font = Enum.Font.GothamBold
            Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            Page.Visible = true
        end)
    end

    -- ==========================================
    -- ADDING FUNCTIONS TO PAGES
    -- ==========================================

    -- 1. MAIN PAGE
    local speedActive = false
    local SpeedBtn, SpeedStroke = CreateButton(Pages["Main"], "Enable Super Speed (100)", function()
        speedActive = not speedActive
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = speedActive and 100 or 16 end
        -- Tu musimy się upewnić, że przycisk w Hubie jest poprawnie znaleziony 
        -- Ze względu na uproszczenie kolorujemy globalnie (wymaga odświeżenia okna żeby zobaczyć)
    end)

    local jumpActive = false
    CreateButton(Pages["Main"], "Enable Infinite Jump", function()
        jumpActive = not jumpActive
    end)
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if jumpActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end
    end)

    -- 2. TROLL PAGE
    CreateButton(Pages["Troll"], "Fling Local Player (Spin)", function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local spin = Instance.new("BodyAngularVelocity")
            spin.MaxTorque = Vector3.new(100000, 100000, 100000)
            spin.AngularVelocity = Vector3.new(0, 100, 0)
            spin.Parent = char.HumanoidRootPart
            task.wait(2)
            spin:Destroy()
        end
    end)

    -- 3. SPECTATE PAGE
    local SpecInput = CreateInput(Pages["Spectate"], "Enter exact Player Username...")
    CreateButton(Pages["Spectate"], "Spectate Player", function()
        local target = Players:FindFirstChild(SpecInput.Text)
        if target and target.Character then
            workspace.CurrentCamera.CameraSubject = target.Character:FindFirstChild("Humanoid")
        end
    end)
    CreateButton(Pages["Spectate"], "Stop Spectating", function()
        if LocalPlayer.Character then
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
        end
    end)

    -- 4. TELEPORT PAGE
    local TPInput = CreateInput(Pages["Teleport"], "Enter exact Player Username...")
    CreateButton(Pages["Teleport"], "Teleport to Player", function()
        local target = Players:FindFirstChild(TPInput.Text)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local myChar = LocalPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            end
        end
    end)
end

-- ==========================================
-- KEY SYSTEM LOGIC
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

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 4)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(35, 35, 35)

SetupStars(MainFrame, 0.4)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "SECURITY VERIFICATION"
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.ZIndex = 2
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Please enter your access key below"
Subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 11
Subtitle.ZIndex = 2
Subtitle.Parent = MainFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 290, 0, 42)
KeyInput.Position = UDim2.new(0.5, -145, 0.45, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
KeyInput.PlaceholderText = "Enter key code..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 13
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
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 13
SubmitButton.ZIndex = 2
SubmitButton.Parent = MainFrame
Instance.new("UICorner", SubmitButton).CornerRadius = UDim.new(0, 4)

SubmitButton.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        SubmitButton.Text = "ACCESS GRANTED"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
        
        local fade = TweenService:Create(MainFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1})
        Title.TextTransparency = 1
        Subtitle.TextTransparency = 1
        KeyInput.BackgroundTransparency = 1
        KeyInput.TextTransparency = 1
        InputStroke.Transparency = 1
        SubmitButton.BackgroundTransparency = 1
        SubmitButton.TextTransparency = 1
        UIStroke.Transparency = 1
        
        fade:Play()
        fade.Completed:Connect(function()
            MainFrame:Destroy()
            CreateMainHub()
        end)
    else
        SubmitButton.Text = "INVALID KEY"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
        task.wait(1)
        SubmitButton.Text = "SUBMIT KEY"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end
end)
