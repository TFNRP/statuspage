local lastIncidents = {}
if type(Config.StatuspageURL) == 'string' then
    Config.StatuspageURL = {Config.StatuspageURL}
end

if type(Config.StatuspageURL) == 'nil' then
    Config.StatuspageURL = {}
end

if type(Config.RefreshRate) == 'number' then
    Config.RefreshRate = Config.RefreshRate * 1e3
end

if type(Config.RefreshRate) == 'nil' then
    Config.RefreshRate = 6e4
end

if type(Config.StatuspageURL) ~= 'table' then
    error('Config.StatuspageURL must be type of string or table, got "' .. type(Config.StatuspageURL) .. '"')
end

if type(Config.RefreshRate) ~= 'number' then
    error('Config.RefreshRate must be type of number or nil, got "' .. type(Config.RefreshRate) .. '"')
end

RegisterCommand('statuspage_add', function(source, args, raw)
    for _, arg in pairs(args) do
        table.insert(Config.StatuspageURL, arg)
    end
end, true)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.RefreshRate)
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