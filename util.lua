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

    local success, object = pcall(function ()
        return json.decode(response.data)
    end)
    if not success or type(object) ~= 'table' then
        return false, response, object
    end

    return object
end

function APIFetchLastIncident(url)
    local data, response, object = APIFetchData(url)
    if not data then
        return data, response, object
    end

    local incidents = data.incidents
    local first = incidents[1]
    return first
end