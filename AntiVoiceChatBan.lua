local function AntiBan()
    -- LocalScript dans StarterPlayerScripts
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    
    -- Création de l'interface
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VoiceChatButtonGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Création du bouton
    local button = Instance.new("TextButton")
    button.Name = "VoiceButton"
    button.Size = UDim2.new(0, 150, 0, 50) -- un peu plus grand
    button.Position = UDim2.new(0, 15, 0, 15) -- marge haut/gauche
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- couleur de base
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 20
    button.Text = "🎤 Deban VC"
    button.Parent = screenGui
    
    -- Coins arrondis
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15) -- arrondi de 15px
    corner.Parent = button
    
    -- Dégradé gris
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)), -- haut : gris foncé
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180)) -- bas : gris clair
    })
    gradient.Rotation = 90 -- vertical
    gradient.Parent = button
    
    -- Ombre légère (UIStroke)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(20, 20, 20)
    stroke.Parent = button
    
    -- Action quand on clique
    button.MouseButton1Click:Connect(function()
    	print("🎤 Voice Chat ré activé !")
    	game:GetService("VoiceChatService"):joinVoice()
    end)
end

AntiBan()
