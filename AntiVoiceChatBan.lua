local function AntiBan()
    
    print("✅ VoiceChat monitor démarré")
    
    local lastLog = tick()
    
    local function isVoiceActive()
    	local ok, active = pcall(function()
    		return game:GetService("VoiceChatService"):IsInVoice()
    	end)
    	return ok and active
    end
    
    task.spawn(function()
    	while true do
    		task.wait(1)
    
    		if tick() - lastLog >= 5 then
    			local active = isVoiceActive()
    			if active then
    				print("🎤 Voice Chat actif")
    			else
    				warn("⚠️ Voice Chat inactif / déconnecté")
    				game:GetService("VoiceChatService"):joinVoice()
    			end
    			lastLog = tick()
    		end
    	end
    end)
end

AntiBan()
