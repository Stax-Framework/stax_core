StaxServerManager = {}
StaxServerManager.ReadyStates = {
  DatabaseReady = false
}

-- FUNCTIONS
function StaxServerManager:SetReadyState(key --[[ string ]], ready --[[ boolean ]])
  if self.ReadyStates[key] ~= nil then
    self.ReadyStates[key] = ready
    if (ready) then
      print("[" .. key .. "] is ready!")
    else
      print("[" .. key .. "] is not ready!")
    end
  end
end

function StaxServerManager:GetReadyState(key --[[ string ]])
  return self.ReadyStates[key] or false
end

function StaxServerManager:ServerReady()
  for _, v in pairs(self.ReadyStates) do
    if v == false then
      return false
    end
  end
  return true
end

-- EXPORT FUNCTIONS
local function SetReadyState(key --[[ string ]], ready --[[ boolean ]])
  StaxServerManager:SetReadyState(key, ready)
end

local function GetReadyState(key --[[ string ]])
  return StaxServerManager:GetReadyState(key)
end

local function ServerReady()
  return StaxServerManager:ServerReady()
end

-- EXPORTS
exports("ServerManager_SetReadyState", SetReadyState)
exports("ServerManager_GetReadyState", GetReadyState)
exports("ServerManager_ServerReady", ServerReady)