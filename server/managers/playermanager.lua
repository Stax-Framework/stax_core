local Logger = Stax.Logger()
local Player = Stax.Player()

---@class PlayerManager
---@field public Players table<number, Player> Table of all player instances
local PlayerManager = {}
PlayerManager.Players = {}

--- Adds a Player instance to the PlayerManager
---@param player Player
---@return Player
function PlayerManager.Add(player)
  self.Players[player.Handle] = player
  return player
end

--- Adds a Player instance to the PlayerManager
---@param player Player
function PlayerManager.Remove(player)
  if not self.Players[player.Handle] then
    Logger.Error("PlayerManager RemovePlayer", "Couldn't remove player [" .. player.Name .. "]")
    return
  end

  self.Players[player.Handle] = nil
end

--- Gets the Player instance from the player manager
---@param handle number
---@return Player | nil
function PlayerManager.Get(handle)
  ---@type Player
  local player = PlayerManager.Players[handle]

  if player then
    return player
  end

  return nil
end

--- EXPORTS
exports("PlayerManager_AddPlayer", PlayerManager.Add)
exports("PlayerManager_RemovePlayer", PlayerManager.Remove)
exports("PlayerManager_GetPlayer", PlayerManager.Get)