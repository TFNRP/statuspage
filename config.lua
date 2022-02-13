Config = {
    --- The URL to the statuspage you would like to keep track off.
    --- Can also be an array of statuspages.
    --- @type string|table<any, string>|nil
    --- @example StatuspageURL = { 'myapp.statuspage.io', 'status.cfx.re' }
    --- @example StatuspageURL = 'myapp.statuspage.io'
    StatuspageURL = nil,
}