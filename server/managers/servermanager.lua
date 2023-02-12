local Exports = Stax.Singletons.Exports

local ServerManager = {
  ReadyStates = {}
}

--- Sets a specific server ready state
---@param key string
---@param ready boolean
function ServerManager:SetReadyState(key, ready)
  if self.ReadyStates[key] ~= nil then
    self.ReadyStates[key] = ready
    exports.stax_core:Logger_LogSuccess("[StaxServerManager]: ReadyStateChanged", key .. " - " .. tostring(ready))
  end
end


--- Gets a specific server ready state
---@param key string
---@return boolean
function ServerManager:GetReadyState(key)
  return self.ReadyStates[key] or false
end

--- Checks if all the ready states are true
---@return boolean
function ServerManager:ServerReady()
  for _, v in pairs(self.ReadyStates) do
    if v == false then
      return false
    end
  end
  return true
end

-- EXPORTS
Exports.Create("ServerManager_SetReadyState", function(key, ready)
  ServerManager:SetReadyState(key, ready)
end)

Exports.Create("ServerManager_GetReadyState", function(key)
  return ServerManager:GetReadyState(key)
end)

Exports.Create("ServerManager_ServerReady", function()
  return ServerManager:ServerReady()
end)