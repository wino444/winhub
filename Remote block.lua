-- ezhooks V1.1 by wino444: Advanced Remote Blocking Library 🛡️
-- Supports RemoteEvent (FireServer) and RemoteFunction (InvokeServer)
-- Recursive search in ReplicatedStorage, workspace, Players
-- Created for robust client-side remote control with error handling

local ezhooks = {}
local activeHooks = {}

local function namecallHook(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    local hookKey = self.Name .. ":" .. method
    if not checkcaller() and activeHooks[hookKey] then
        return -- Suppress the call if the hook is active
    end
    return self[method](self, ...)
end

function ezhooks:toggleHook(eventName, fireType, value)
    local hookKey = eventName .. ":" .. fireType
    local toggleValue = (type(value) == "boolean") and value or (type(value) == "string" and (value:lower() == "true"))
    
    -- Scan for Remote in client-accessible services
    local remote
    local services = {game:GetService("ReplicatedStorage"), workspace, game:GetService("Players")}
    for _, service in pairs(services) do
        remote = service:FindFirstChild(eventName, true) -- Recursive search
        if remote then break end
    end
    
    if not remote then
        warn("⚠️ Remote '" .. eventName .. "' not found in client-accessible services!")
        return
    end
    
    local isRemoteEvent = remote:IsA("RemoteEvent")
    local isRemoteFunction = remote:IsA("RemoteFunction")
    if not (isRemoteEvent or isRemoteFunction) then
        warn("⚠️ '" .. eventName .. "' is not a RemoteEvent or RemoteFunction!")
        return
    end
    
    if fireType ~= (isRemoteEvent and "FireServer" or "InvokeServer") then
        warn("⚠️ FireType '" .. fireType .. "' does not match Remote type for '" .. eventName .. "'!")
        return
    end
    
    local success, err = pcall(function()
        if toggleValue then
            if activeHooks[hookKey] then
                return -- Already active
            end
            activeHooks[hookKey] = hookfunction(remote[fireType], namecallHook)
        else
            if not activeHooks[hookKey] then
                return -- Already inactive
            end
            -- Note: hookfunction doesn't have Disconnect, so just set to nil (hook is replaced)
            activeHooks[hookKey] = nil
        end
    end)
    
    if not success then
        warn("⚠️ Error toggling hook for '" .. eventName .. "': " .. tostring(err))
    end
end

return ezhooks
