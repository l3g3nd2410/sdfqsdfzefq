local function AntiBan()
    -- LocalScript dans StarterPlayerScripts
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    
    -- Création de l'interface
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VoiceChatButtonGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local button = Instance.new("TextButton")
    button.Name = "Deban VC"
    button.Size = UDim2.new(0, 120, 0, 40) -- largeur 120px, hauteur 40px
    button.Position = UDim2.new(0, 10, 0, 10) -- en haut à gauche avec une marge
    button.BackgroundColor3 = Color3.fromRGB(30, 150, 255)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.Text = "Test Bouton"
    button.Parent = screenGui
    
    -- Quand on clique
    button.MouseButton1Click:Connect(function()
    	print("🎤 Voice Chat ré activé !")
    	game:GetService("VoiceChatService"):IsInVoice()
    end)
end

AntiBan()
