local function AntiBan()
    print("✅ Script VoiceChat Auto-Rejoin lancé !")
    
    local lastLog = tick()
    
    while true do
        task.wait()
        pcall(function()
            game:GetService("VoiceChatService"):joinVoice()
        end)
    
        if tick() - lastLog >= 5 then
            print("⏳ Script VoiceChat tourne toujours...")
            lastLog = tick()
        end
    end
end

AntiBan()
