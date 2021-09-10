local lastIncidents = {}
if type(Config.StatuspageURL) == 'string' then
    Config.StatuspageURL = {Config.StatuspageURL}
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3e4)
        for _, page in ipairs(Config.StatuspageURL) do
            local incident = APIFetchLastIncident('https://' .. page .. '/index.json')
            local lastIncident = lastIncidents[page]
            if incident and not (not lastIncident and incident.status == 'resolved') and (not lastIncident or incident.status ~= lastIncident.status or incident.name ~= lastIncident.name or incident.incident_updates[1].body ~= lastIncident.incident_updates[1].body) then
                lastIncident = incident
                TriggerClientEvent('chat:addMessage', -1, {
                    args = { '^5^*^_[' .. incident.status:gsub("^%l", string.upper) .. ']:^r ^3^_' .. incident.name .. '^r' }
                })
                TriggerClientEvent('chat:addMessage', -1, {
                    args = { '^1^*' .. incident.incident_updates[1].body }
                })
                TriggerClientEvent('statuspage:addIncident', -1, incident.status, incident.name, incident.incident_updates[1].body)
            end
        end
    end
end)