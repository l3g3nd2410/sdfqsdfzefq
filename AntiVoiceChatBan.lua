local function AntiBan()
    
    print("✅ VoiceChat monitor (basé sur VoiceChatState) démarré")
    
    -- petite aide pour afficher une notif locale sans planter si SetCore n'est pas prêt
    local function notify(title, text, duration)
    	pcall(function()
    		game:GetService("StarterGui"):SetCore("SendNotification", {
    			Title = title,
    			Text = text,
    			Duration = duration or 3
    		})
    	end)
    end
    
    -- utilitaire d'affichage de l'état
    local function stateToStr(state)
    	return tostring(state) -- ex: "Enum.VoiceChatState.Connected"
    end
    
    -- paramètres
    local pollInterval = 0.5   -- fréquence de vérification
    local heartbeatEvery = 5   -- log toutes les X secondes
    
    -- état interne
    local lastState = game:GetService("VoiceChatService").VoiceChatState
    local lastHeartbeat = tick()
    
    -- message initial
    print("État initial :", stateToStr(lastState))
    if lastState ~= Enum.VoiceChatState.Connected then
    	warn("⚠️ Voice Chat déconnecté (state =", stateToStr(lastState), ")")
    	notify("Voice Chat", "Déconnecté (" .. stateToStr(lastState) .. ")", 3)
    else
    	print("🎤 Voice Chat connecté")
    end
    
    -- boucle de surveillance
    task.spawn(function()
    	while true do
    		task.wait(pollInterval)
    
    		local current = game:GetService("VoiceChatService").VoiceChatState
    
    		-- heartbeat périodique
    		if tick() - lastHeartbeat >= heartbeatEvery then
    			print("⏳ monitor actif… state =", stateToStr(current))
    			lastHeartbeat = tick()
    		end
    
    		-- si l'état a changé, on log & on notifie
    		if current ~= lastState then
    			print(("🔔 State: %s -> %s"):format(stateToStr(lastState), stateToStr(current)))
    			if current == Enum.VoiceChatState.Connected then
    				print("🎤 Voice Chat connecté")
    				notify("Voice Chat", "Connecté", 2)
    			else
    				warn("⚠️ Voice Chat déconnecté (state =", stateToStr(current), ")")
                    game:GetService("VoiceChatService"):joinVoice()
    				notify("Voice Chat", "Déconnecté (" .. stateToStr(current) .. ")", 3)
    			end
    			lastState = current
    		end
    	end
    end)
end

AntiBan()
