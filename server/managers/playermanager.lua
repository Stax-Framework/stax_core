local Logger = Stax.Singletons.Logger

---@class PlayerManager
---@field public Players table<string, Player> Table of all player instances
PlayerManager = {}
PlayerManager.Players = {}

--- Adds a Player instance to the PlayerManager
---@param player Player
---@return Player
function PlayerManager:AddPlayer(player)
  self.Players[player.Handle] = player
  return player
end

--- Adds a Player instance to the PlayerManager
---@param player Player
function PlayerManager:RemovePlayer(player)
  if not self.Players[player.Handle] then
    Logger.Error("PlayerManager RemovePlayer", "Couldn't remove player [" .. player.Name .. "]")
    return
  end

  self.Players[player.Handle] = nil
end

--- Gets the Player instance from the player manager
---@param handle string
function PlayerManager:GetPlayer(handle)
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
  local _, playerData = PlayerManager:GetPlayer(handle)
  if playerData then
    return playerData
  end
  return nil
end)

exports("PlayerManager_SetPlayerData", function(handle --[[ number ]], key --[[ string ]], data --[[ any ]])
  local _, playerData = PlayerManager:GetPlayer(handle)
  if playerData then
    playerData:SetData(key, data)
  end
end)

exports("PlayerManager_GetPlayerData", function(handle --[[ number ]], key --[[ string ]])
  local _, playerData = PlayerManager:GetPlayer(handle)
  if playerData then
    return playerData:GetData(key)
  end
  return nil
end)