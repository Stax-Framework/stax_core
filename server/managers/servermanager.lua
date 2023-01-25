StaxServerManager = {}
StaxServerManager.ReadyStates = {
  PluginsLoaded = false
}

--- Sets a specific server ready state
---@param key string
---@param ready boolean
function StaxServerManager:SetReadyState(key, ready)
  if self.ReadyStates[key] ~= nil then
    self.ReadyStates[key] = ready
    exports.stax_core:Logger_LogSuccess("[StaxServerManager]: ReadyStateChanged", key .. " - " .. tostring(ready))
  end
end

--- Gets a specific server ready state
---@param key string
---@return boolean
function StaxServerManager:GetReadyState(key)
  return self.ReadyStates[key] or false
end

--- Checks if all the ready states are true
---@return boolean
function StaxServerManager:ServerReady()
  for _, v in pairs(self.ReadyStates) do
    if v == false then
      return false
    end
  end
  return true
end

-- EXPORT FUNCTIONS
local function SetReadyState(key, ready)
  StaxServerManager:SetReadyState(key, ready)
end

local function GetReadyState(key)
  return StaxServerManager:GetReadyState(key)
end

local function ServerReady()
  return StaxServerManager:ServerReady()
end

-- EXPORTS
exports("ServerManager_SetReadyState", SetReadyState)
exports("ServerManager_GetReadyState", GetReadyState)
exports("ServerManager_ServerReady", ServerReady)