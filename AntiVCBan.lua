local VoiceChatService = game:GetService("VoiceChatService")

print("✅ Script VoiceChat Auto-Rejoin lancé !")

local lastLog = tick()

while true do
    task.wait()
    pcall(function()
        VoiceChatService:JoinVoice()
    end)

    if tick() - lastLog >= 5 then
        print("⏳ Script VoiceChat tourne toujours...")
        lastLog = tick()
    end
end
