---@class StaxPlayer
---@field public Handle number Players server id
---@field public Name string Players server name
---@field public Identifiers table<number, string> Table of players available identifiers
---@field public Data table<string, any>
StaxPlayer = {}
StaxPlayer.__index = StaxPlayer

--- Creates new instance of StaxPlayer
---@param handle string
---@return StaxPlayer
function StaxPlayer.New(handle)
  local newPlayer = {}
  local playerName = GetPlayerName(handle)
  local validatedName = exports.stax_core:String_StripInvalidCharacters(playerName)

  setmetatable(newPlayer, StaxPlayer)

  newPlayer.Handle = handle
  newPlayer.Name = validatedName
  newPlayer.Identifiers = newPlayer:GetIdentifiers()
  newPlayer.Data = {}

  return newPlayer
end

--- Reinitialized instance of StaxPlayer
---@param player StaxPlayer
---@return StaxPlayer
function StaxPlayer.Class(player)
  return setmetatable(player, StaxPlayer)
end

--- Stores some data inside of the StaxPlayer instance
---@param keys string
---@param newData any
---@return boolean
function StaxPlayer:SetData(keys, newData)
  if not keys then
    return false
  end

  print("NOT IMPLEMENTED YET!")

  return true
end

--- Gets some data stored inside of the StaxPlayer instance
---@param keys string
---@return any
function StaxPlayer:GetData(keys)
  if not keys then
    return self.Data
  end

  local path = exports.stax_core:String_Split(keys, ".")
  local data = exports.stax_core:Table_Copy(self.Data)

  for _, v in pairs(path) do
    data = data[v]
  end

  return data
end

---@return table<number, string>
function StaxPlayer:GetIdentifiers()
  local amount = GetNumPlayerIdentifiers(self.Handle)
  local identifiers = {}

  for a = 0, amount do
    identifiers[#identifiers + 1] = GetPlayerIdentifier(self.Handle, a)
  end

  return identifiers
end

--- Gets a specified type of player identifier if it exists
---@param identType string
---@return string | nil
function StaxPlayer:GetIdentifier(identType)
  for a = 1, #self.Identifiers do
    if string.find(self.Identifiers[a], identType, 1) then
      return self.Identifiers[a]
    end
  end
  return nil
end

--- Kicks the player from the server
---@param admin StaxPlayer
---@param reason string
function StaxPlayer:Kick(admin, reason)
  DropPlayer(self.Handle, reason)
end

--- Bans the player from the server
---@param admin StaxPlayer
---@param reason string
---@param time table
function StaxPlayer:Ban(admin, reason, time)
  DropPlayer(self.Handle, reason)
end

--- Issues the player a warning
---@param admin StaxPlayer
---@param reason string
function StaxPlayer:Warn(admin, reason)

end

--- Fires an event on this player
---@param event string
---@param ... any
function StaxPlayer:FireEvent(event, ...)
  TriggerClientEvent(event, self.Handle, ...)
end