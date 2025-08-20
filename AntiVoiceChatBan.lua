local function AntiBan()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local player = Players.LocalPlayer

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VoiceChatButtonGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local button = Instance.new("TextButton")
    button.Name = "VoiceButton"
    button.Size = UDim2.new(0, 130, 0, 42)
    button.Position = UDim2.new(0, 15, 0, 15)
    button.BackgroundTransparency = 1
    button.AutoButtonColor = false
    button.Text = ""
    button.Parent = screenGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    bg.Parent = button

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = bg

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "🎤 Deban VC"
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Font = Enum.Font.GothamBold
    text.TextScaled = false
    text.TextSize = 20
    text.ZIndex = 2
    text.Parent = button

    local function showCenterNotification(msg, showTime)
        showTime = showTime or 1.5

        local n = Instance.new("Frame")
        n.Name = "CenterNotice"
        n.AnchorPoint = Vector2.new(0.5, 0.5)
        n.Position = UDim2.new(0.5, 0, 0.5, 0)
        n.Size = UDim2.new(0, 260, 0, 60)
        n.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        n.BackgroundTransparency = 1
        n.Parent = screenGui
        n.ZIndex = 50

        local nc = Instance.new("UICorner")
        nc.CornerRadius = UDim.new(0, 12)
        nc.Parent = n

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Transparency = 1
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = n

        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size = UDim2.new(1, -20, 1, -12)
        lbl.Position = UDim2.new(0, 10, 0, 6)
        lbl.Text = msg or "✅ VoiceChat re connecté"
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.TextTransparency = 1
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextScaled = true
        lbl.ZIndex = 51
        lbl.Parent = n

        TweenService:Create(n, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(lbl, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        TweenService:Create(stroke, TweenInfo.new(1), {Transparency = 0.5}):Play()

        task.delay(0.25 + showTime, function()

            local t1 = TweenService:Create(n, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})
            local t2 = TweenService:Create(lbl, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1})
            local t3 = TweenService:Create(stroke, TweenInfo.new(0.25), {Transparency = 1})
            t1:Play(); t2:Play(); t3:Play()
            t1.Completed:Wait()
            n:Destroy()
        end)
    end

    button.MouseButton1Click:Connect(function()
        print("✅ VoiceChat re connecté")
        game:GetService("VoiceChatService"):joinVoice()
        showCenterNotification("✅ VoiceChat re connecté", 1.5)
    end)
end

AntiBan()
