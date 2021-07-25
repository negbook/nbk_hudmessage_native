
CreateThread(function()
    TriggerEvent('hudmessage',"IV Tower",0.8,0.5,32,1000,2500,1000)
    TriggerEvent('hudmessage',"Credit:Negbook",0.35,0.7,16,2000,2600,1000)
    TriggerEvent('hudmessage',"Now Playing: Metal Gear",0.2,0.6,14,1000,2500,2000,function()
        print("Cool")
    end)
end)