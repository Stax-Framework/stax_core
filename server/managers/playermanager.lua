local Logger = Stax.Singletons.Logger
local Player = Stax.Classes.Player

---@class PlayerManager
---@field public Players table<number, Player> Table of all player instances
local PlayerManager = {}
PlayerManager.Players = {}

--- Adds a Player instance to the PlayerManager
---@param player Player
---@return Player
function PlayerManager.AddPlayer(player)
  self.Players[player.Handle] = player
  return player
end

--- Adds a Player instance to the PlayerManager
---@param player Player
function PlayerManager.RemovePlayer(player)
  if not self.Players[player.Handle] then
    Logger.Error("PlayerManager RemovePlayer", "Couldn't remove player [" .. player.Name .. "]")
    return
  end

  self.Players[player.Handle] = nil
end

--- Gets the Player instance from the player manager
---@param handle number
---@return Player | nil
function PlayerManager.GetPlayer(handle)
  ---@type Player
  local player = PlayerManager.Players[handle]

  if player then
    return player
  end

  return nil
end

--- Sets player metadata (Don't call this manually)
--- Use the Player:SetData() metamethod
---@param player Player
---@param data any
function PlayerManager.SetPlayerData(player, data)
  PlayerManager.Players[player.Handle].Data = data
end

-- EXPORTS
exports("PlayerManager_AddPlayer", PlayerManager.AddPlayer)
exports("PlayerManager_RemovePlayer", PlayerManager.RemovePlayer)
exports("PlayerManager_GetPlayer", PlayerManager.GetPlayer)
exports("PlayerManager_SetPlayerData", PlayerManager.SetPlayerData)
exports("PlayerManager_SetPlayerData", PlayerManager.GetPlayerData)