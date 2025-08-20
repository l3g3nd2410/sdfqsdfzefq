local function AntiBan()
    
    print("✅ VoiceChat monitor démarré")
    
    -- Réglages
    local pollInterval = 0.5       -- fréquence de vérif
    local declareDisconnectedAfter = 3 -- secondes consécutives "inactif" avant de dire "déco"
    local cooldownAfterAction = 8   -- secondes de cooldown après une action (évite la boucle)
    local warmupAtStart = 3         -- délai de chauffe au lancement
    
    -- États internes
    local lastLog = tick()
    local inactiveSince = nil
    local inCooldownUntil = 0
    local wasActive = false
    
    local function isVoiceActive()
        local ok, active = pcall(function()
            return game:GetService("VoiceChatService"):IsInVoice()
        end)
        return ok and active or false
    end
    
    -- chauffe au démarrage pour éviter les faux négatifs
    task.wait(warmupAtStart)
    
    task.spawn(function()
        while true do
            task.wait(pollInterval)
    
            -- log toutes les 5s
            if tick() - lastLog >= 5 then
                print("⏳ monitor actif… (cooldown=", math.max(0, inCooldownUntil - tick()), "s)")
                lastLog = tick()
            end
    
            local active = isVoiceActive()
    
            if active then
                -- si on est actif, on reset l'inactivité
                if not wasActive then
                    print("🎤 Voice Chat actif")
                end
                inactiveSince = nil
                wasActive = true
            else
                -- inactif : on démarre (ou continue) le chrono d'inactivité
                if not inactiveSince then
                    inactiveSince = tick()
                end
    
                local inactiveFor = tick() - inactiveSince
                if inactiveFor >= declareDisconnectedAfter then
                    -- on ne déclenche que si on n'est pas en cooldown
                    if tick() >= inCooldownUntil then
                        warn(("⚠️ Voice Chat inactif depuis %.1fs — action de reconnexion"):format(inactiveFor))
                        game:GetService("VoiceChatService"):joinVoice()
                        inCooldownUntil = tick() + cooldownAfterAction
                    end
                end
    
                wasActive = false
            end
        end
    end)
end

AntiBan()
