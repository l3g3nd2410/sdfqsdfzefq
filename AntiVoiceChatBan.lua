local function AntiBan()
    local Players = game:GetService("Players")
    local VoiceChatService = game:GetService("VoiceChatService")
    
    local localPlayer = Players.LocalPlayer
    
    -- Vérifie l'éligibilité
    local function isEligible()
    	local ok, enabled = pcall(function()
    		return VoiceChatService:IsVoiceEnabledForUserIdAsync(localPlayer.UserId)
    	end)
    	return ok and enabled
    end
    
    -- Vérifie et notifie si déco
    local function checkVoice()
    	if isEligible() then
    		print("🎤 Voice Chat actif (eligible & joinVoice OK)")
    	else
    		warn("❌ Voice Chat non disponible pour ce joueur (pas eligible)")
            VoiceChatService:joinVoice()
    	end
    end
    
    print("✅ VoiceChat monitor lancé")
    checkVoice()
    
    -- Boucle de check toutes les 10 secondes
    task.spawn(function()
    	while true do
    		task.wait(10)
    		checkVoice()
    	end
    end)
end

AntiBan()
