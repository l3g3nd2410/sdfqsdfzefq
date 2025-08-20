local VoiceChatService = game:GetService("VoiceChatService")

while true do
    task.wait()
    pcall(function()
        VoiceChatService:JoinVoice()
    end)
end
