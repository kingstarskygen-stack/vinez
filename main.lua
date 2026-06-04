-- Modern Dark Key System with Falling Stars Effect (English Version)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local CORRECT_KEY = "MY_FIRST_KEY_2026"

-- 1. Main Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- 2. Main Window (Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 240)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Deep black/dark charcoal
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true -- Keeps the falling stars inside the frame
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Sleek, slight rounding (4 pixels for a modern, sharp look)
local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 4)
FrameCorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Thickness = 1
UIStroke.Parent = MainFrame

-- 3. BACKGROUND ANIMATION: Falling Stars
local starsContainer = Instance.new("Frame")
starsContainer.Size = UDim2.new(1, 0, 1, 0)
starsContainer.BackgroundTransparency = 1
starsContainer.Parent = MainFrame

local function createStar()
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3)) -- Random small sizes
    star.Position = UDim2.new(math.random(), 0, -0.05, 0) -- Starts just above the frame
    star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    star.BackgroundTransparency = math.random(2, 6) / 10 -- Semi-transparent glow
    star.BorderSizePixel = 0
    star.Parent = starsContainer
    
    -- Smooth rounding for individual stars
    local starCorner = Instance.new("UICorner")
    starCorner.CornerRadius = UDim.new(1, 0)
    starCorner.Parent = star

    local speed = math.random(40, 90) / 100 -- Random falling speed
    
    local connection
    connection = RunService.RenderStepped:Connect(function(deltaTime)
        if not star or not star.Parent then 
            connection:Disconnect()
            return 
        end
        -- Move down
        star.Position = star.Position + UDim2.new(0, 0, 0, speed * deltaTime * 150)
        
        -- Delete star if it goes off-screen (bottom of the frame)
        if star.Position.Y.Scale > 1.05 then
            connection:Disconnect()
            star:Destroy()
        end
    end)
end

-- Spawn stars periodically
task.spawn(function()
    while MainFrame and MainFrame.Parent do
        createStar()
        task.wait(math.random(3, 8) / 10) -- Control density of stars
    end
end)

-- 4. Title Elements
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

-- 5. Input Field (TextBox)
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 290, 0, 42)
KeyInput.Position = UDim2.new(0.5, -145, 0.45, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
KeyInput.BorderSizePixel = 0
KeyInput.Text = ""
KeyInput.PlaceholderText = "Enter key code..."
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
KeyInput.TextSize = 13
KeyInput.Font = Enum.Font.Gotham
KeyInput.ZIndex = 2
KeyInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 4)
InputCorner.Parent = KeyInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(40, 40, 40)
InputStroke.Thickness = 1
InputStroke.Parent = KeyInput

-- 6. Submit Button
local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0, 290, 0, 42)
SubmitButton.Position = UDim2.new(0.5, -145, 0.7, 5)
SubmitButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SubmitButton.BorderSizePixel = 0
SubmitButton.Text = "SUBMIT KEY"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.TextSize = 13
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.ZIndex = 2
SubmitButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 4)
ButtonCorner.Parent = SubmitButton

-- 7. Logic and Transitions
SubmitButton.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        SubmitButton.Text = "ACCESS GRANTED"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(39, 174, 96) -- Emerald Green
        InputStroke.Color = Color3.fromRGB(39, 174, 96)
        
        -- Smooth Fade Out Animation
        local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2.new(0, 340, 0, 220), Position = UDim2.new(0.5, -170, 0.5, -110)})
        local strokeTween = TweenService:Create(UIStroke, TweenInfo.new(0.4), {Transparency = 1})
        
        -- Hide text components
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
            ScreenGui:Destroy()
            
            ---------------------------------------------------------------
            -- SCRIPT EXECUTED UPON SUCCESSFUL KEY VERIFICATION          --
            print("Successfully authenticated!")
            
            -- Your speed/jump script from step 1
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.WalkSpeed = 100
            humanoid.JumpPower = 150
            ---------------------------------------------------------------
        end)
    else
        -- Error handling animation (Slight red flash)
        SubmitButton.Text = "INVALID KEY! TRY AGAIN"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43) -- Muted Red
        InputStroke.Color = Color3.fromRGB(192, 57, 43)
        
        task.wait(1.6)
        
        SubmitButton.Text = "SUBMIT KEY"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        InputStroke.Color = Color3.fromRGB(40, 40, 40)
    end
end)
