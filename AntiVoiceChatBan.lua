local function AntiBan()
    
    print("✅ VoiceChat monitor démarré")
    
    local lastLog = tick()
    
    local function hasVoiceEnabled()
    	local ok, enabled = pcall(function()
    		return game:GetService("VoiceChatService"):IsVoiceEnabledForUserIdAsync(game:GetService("Players").LocalPlayer.UserId)
    	end)
    	return ok and enabled
    end
    
    -- Heartbeat + diagnostic
    task.spawn(function()
    	while true do
    		task.wait(1)
    
    		if tick() - lastLog >= 5 then
    			local enabled = hasVoiceEnabled()
    			print("⏳ VoiceChat monitor actif… éligible =", enabled)
    
    			if not enabled then
    				warn("⚠️ Le voice chat a été désactivé/déconnecté pour ce joueur.")
    				game:GetService("VoiceChatService"):joinVoice()
    			end
    
    			lastLog = tick()
    		end
    	end
    end)
end

AntiBan()
