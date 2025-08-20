local function AntiBan()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VoiceChatButtonGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Conteneur bouton
    local button = Instance.new("TextButton")
    button.Name = "VoiceButton"
    button.Size = UDim2.new(0, 160, 0, 50)
    button.Position = UDim2.new(0, 15, 0, 15)
    button.BackgroundTransparency = 1 -- transparent, on mettra un frame comme fond
    button.AutoButtonColor = false
    button.Text = "" -- pas de texte ici
    button.Parent = screenGui
    
    -- Fond arrondi + gradient
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    bg.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = bg
    
    -- Texte par-dessus
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "🎤 Deban VC"
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Font = Enum.Font.GothamBold
    text.TextScaled = true
    text.ZIndex = 2
    text.Parent = button
    
    -- Action clic
    button.MouseButton1Click:Connect(function()
    	print("✅ VoiceChat re connecté")
    	game:GetService("VoiceChatService"):joinVoice()
    end)
end

AntiBan()
