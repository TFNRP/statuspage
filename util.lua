function APIFetchData(url)
    local response = {
        timeout = false
    }

    PerformHttpRequest(url, function (code, result, headers)
        response.code = code
        if code ~= 200 then
            response.timeout = true
        else
            response.data = result
        end
    end, 'GET')

    while response.data == nil and not response.timeout do
        Citizen.Wait(0)
    end

    if response.timeout then
        return false, response
    end

    local success, json = pcall(function ()
        return JSON.parse(response.data)
    end)
    if not success or type(json) ~= 'table' then
        return false, response, json
    end

    return json
end

function APIFetchLastIncident(url)
    local data, response, json = APIFetchData(url)
    if not data then
        return data, response, json
    end

    local incidents = data.incidents
    local first = incidents[1]
    return first
end