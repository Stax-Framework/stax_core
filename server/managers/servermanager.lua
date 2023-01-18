StaxServerManager = {}StaxServerManager
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

-- EXPORTS
exports("ServerManager_SetReadyState", function(key --[[ string ]], ready --[[ boolean ]])
  StaxServerManager:SetReadyState(key, ready)
end)
exports("ServerManager_GetReadyState", function(key --[[ string ]])
  return StaxServerManager:GetReadyState(key)
end)
exports("ServerManager_ServerReady", function()
  return StaxServerManager:ServerReady()
end)