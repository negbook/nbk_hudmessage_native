DrawText2D = function(text,scale,x,y,alpha)
	SetTextScale(scale/24, scale/24)
	SetTextFont(0)
	SetTextColour(255, 255, 255, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
	ClearDrawOrigin()
end
local hudmessage_handle = 0
local hudmessage_handles = {}

function OnDrawFinish(object,handle)
    hudmessage_handles[handle] = nil
end 

RegisterNetEvent('hudmessage', function(text,xper,yper,scale,durationIn,durationHold,durationOut)
    local object = {}
    object._text = text
    object._x = xper
    object._y = yper
    object._alpha = 0
    object._scale = scale
    if durationIn == nil then durationIn = 1000 end 
    if durationHold == nil then durationHold = 2500 end 
    if durationOut == nil then durationOut = 1000 end 
    durationIn = durationIn / 1000
    durationHold = durationHold / 1000
    durationOut = durationOut / 1000
    if hudmessage_handle > 65530 then hudmessage_handle = 0 end 
    hudmessage_handle = hudmessage_handle + 1
    hudmessage_handles[hudmessage_handle] = true 
    TweenCFX.Tween.to(object,durationIn,{_alpha=255,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,hudmessage_handle)
        TweenCFX.Tween.delayCall(object,durationHold,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,hudmessage_handle)
            TweenCFX.Tween.to(object,durationOut,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=OnDrawFinish,onCompleteArgs={object,hudmessage_handle}})
        end ,onCompleteArgs={object,hudmessage_handle}})
        
    end ,onCompleteArgs={object,hudmessage_handle}})
    
    CreateThread(function()
        hudmessage_handles[hudmessage_handle] = true 
        while hudmessage_handles[hudmessage_handle] do Wait(0)
            DrawText2D(object._text,object._scale,object._x,object._y,math.floor(object._alpha))
        end 
    end)
end)


