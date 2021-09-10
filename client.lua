RegisterNetEvent('statuspage:addIncident', function (status, name, body)
    ShowNotification('~b~~h~[' .. status:gsub("^%l", string.upper) .. '] ~y~' .. name .. '~n~~r~' .. body)
end)

function ShowNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(message)
    DrawNotification(true, true)
end