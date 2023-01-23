---@class StaxPlayerManager
---@field public Players table<string, StaxPlayer> Table of all player instances
StaxPlayerManager = {}
StaxPlayerManager.Players = {}

--- Adds a StaxPlayer instance to the StaxPlayerManager
---@param player StaxPlayer
---@return StaxPlayer
function StaxPlayerManager:AddPlayer(player)
  self.Players[handle] = player
  return player
end

--- Adds a StaxPlayer instance to the StaxPlayerManager
---@param player StaxPlayer
function StaxPlayerManager:RemovePlayer(player)
  if not self.Players[player.Handle] then
    error("Attempted to remove a StaxPlayer instance from the StaxPlayerManager!")
    return
  end

  self.Players[player.Handle] = nil
end

--- Gets the StaxPlayer instance from the player manager
---@param handle string
function StaxPlayerManager:GetPlayer(handle)
  for k, v in pairs(self.Players) do
    if v.Handle == handle then
      return k, v
    end
  end
  return -1, nil
end

-- EXPORTS

---@param handle string
exports("PlayerManager_GetPlayer", function(handle)
  local _, playerData = StaxPlayerManager:GetPlayer(handle)
  if playerData then
    return playerData
  end
  return nil
end)

exports("PlayerManager_SetPlayerData", function(handle --[[ number ]], key --[[ string ]], data --[[ any ]])
  local _, playerData = StaxPlayerManager:GetPlayer(handle)
  if playerData then
    playerData:SetData(key, data)
  end
end)

exports("PlayerManager_GetPlayerData", function(handle --[[ number ]], key --[[ string ]])
  local _, playerData = StaxPlayerManager:GetPlayer(handle)
  if playerData then
    return playerData:GetData(key)
  end
  return nil
end)