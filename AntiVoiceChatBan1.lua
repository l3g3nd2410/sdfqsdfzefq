local function AntiBan()

    print("✅ Script VoiceChat Auto-Rejoin lancé !")
    
    local lastLog = tick()
    
    while true do
        task.wait(1)
    
        local success, inVoice = pcall(function()
            return game:GetService("VoiceChatService"):IsInVoice()
        end)
    
        if success and not inVoice then
            local ok, err = pcall(function()
                game:GetService("VoiceChatService"):JoinVoice()
            end)
    
            if ok then
                print("🔄 Tentative de connexion au VoiceChat...")
            else
                warn("⚠️ Erreur lors de JoinVoice :", err)
            end
        end
    
        if tick() - lastLog >= 5 then
            print("⏳ Script VoiceChat tourne toujours...")
            lastLog = tick()
        end
    end
end

AntiBan()
