local function AntiBan()
    local VoiceChatService = game:GetService("VoiceChatService")

    print("✅ VoiceChat Auto-Reconnect démarré")
    
    -- backoff progressif pour éviter de spammer si ça échoue en boucle
    local baseDelay = 0.5
    local maxDelay  = 8
    local delay     = baseDelay
    local keepTrying = true
    
    -- pour limiter les tentatives dans la boucle de secours
    local nextAttemptAt = 0
    
    local function isInVoiceSafe()
        local ok, inVoice = pcall(function()
            return game:GetService("VoiceChatService"):IsInVoice()
        end)
        return ok and inVoice or false
    end
    
    local function tryJoinVoice()
        if not keepTrying then return end
        local ok, err = pcall(function()
            game:GetService("VoiceChatService"):JoinVoice()
        end)
        if ok then
            print("🔄 JoinVoice() tenté")
            -- on laisse l’event StateChanged nous dire si c'est connecté
        else
            warn("⚠️ JoinVoice() erreur :", err)
            -- petit backoff si échec
            delay = math.min(delay * 1.5, maxDelay)
            nextAttemptAt = tick() + delay
        end
    end
    
    -- Tentative initiale
    tryJoinVoice()
    
    -- Réagit immédiatement aux changements d'état
    game:GetService("VoiceChatService").StateChanged:Connect(function(oldState, newState)
        print(("🔔 StateChanged: %s -> %s"):format(tostring(oldState), tostring(newState)))
    
        if newState == Enum.VoiceChatState.Connected then
            -- connecté : on reset le backoff
            delay = baseDelay
            nextAttemptAt = 0
            return
        end
    
        -- États "déconnecté" ou transition ratée : on retente vite
        if newState == Enum.VoiceChatState.Idle
        or newState == Enum.VoiceChatState.Ended
        or newState == Enum.VoiceChatState.Failed then
            delay = baseDelay
            nextAttemptAt = 0
            -- petite latence pour laisser le service respirer
            task.delay(0.2, tryJoinVoice)
            return
        end
    
        -- Si l'accès est explicitement refusé (pas ton cas, mais on gère proprement)
        if newState == Enum.VoiceChatState.Unauthorized then
            keepTrying = false
            warn("🚫 Voice chat indisponible (Unauthorized). Arrêt des tentatives.")
        end
    end)
    
    -- Boucle de secours : vérifie ~chaque seconde et relance si besoin
    task.spawn(function()
        local lastHeartbeat = tick()
        while true do
            task.wait(1)
    
            -- Heartbeat toutes les 5 secondes
            if tick() - lastHeartbeat >= 5 then
                print(("⏳ Auto-Reconnect actif (delay=%.2fs, keepTrying=%s)"):format(delay, tostring(keepTrying)))
                lastHeartbeat = tick()
            end
    
            if not keepTrying then
                -- on continue juste le heartbeat
                continue
            end
    
            if not isInVoiceSafe() and tick() >= nextAttemptAt then
                tryJoinVoice()
            else
                -- si on est connecté, on garde le délai au minimum
                if isInVoiceSafe() then
                    delay = baseDelay
                    nextAttemptAt = 0
                end
            end
        end
    end)
end

AntiBan()
