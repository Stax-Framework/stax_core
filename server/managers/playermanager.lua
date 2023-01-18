StaxPlayerManager = {}
StaxPlayerManager.Players = {}

-- FUNCTIONS
function StaxPlayerManager:AddPlayer(player --[[ StaxPlayer ]])
  self.Players[handle] = player
  return player
end

function StaxPlayerManager:RemovePlayer(handle --[[ number ]])
  local player = self.Players[handle]

  if player then
    self.Players[handle] = nil
  end
end

function StaxPlayerManager:GetPlayer(handle --[[ number ]])
  for k, v in pairs(self.Players) do
    if v.Handle == handle then
      return k, v
    end
  end
  return -1, nil
end

-- EXPORTS
exports("PlayerManager_GetPlayer", function(handle --[[ number ]])
  local playerIndex, playerData = StaxPlayerManager:GetPlayer(handle)
  if playerData then
    return playerData
  end
  return nil
end)

exports("PlayerManager_SetPlayerData", function(handle --[[ number ]], key --[[ string ]], data --[[ any ]])
  local playerIndex, playerData = StaxPlayerManager:GetPlayer(handle)
  if playerData then
    playerData:SetData(key, data)
  end
end)

exports("PlayerManager_GetPlayerData", function(handle --[[ number ]], key --[[ string ]])
  local playerIndex, playerData = StaxPlayerManager:GetPlayer(handle)
  if playerData then
    return playerData:GetData(key)
  end
  return nil
end)