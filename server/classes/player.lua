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
---@param key string
---@param data any
function StaxPlayer:SetData(key, data)
  self.Data[key] = data
end

--- Gets some data stored inside of the StaxPlayer instance
---@param key string
---@return any
function StaxPlayer:GetData(key)
  return self.Data[key]
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

--- Gets if the player is allowed to join the server while its private
---@return boolean
function StaxPlayer:IsAllowListed()
  local UserData = self:GetData("User")

  if not UserData then return false end

  if UserData.allowlisted == 1 then
    return true
  end

  return false
end

--- Returns if the player is banned from the server
---@return boolean
function StaxPlayer:IsBanned()
  local UserData = self:GetData("User")
  
  if not UserData then return false end

  local BansCount = self:GetBansCount()

  if BansCount > 0 then
    local BansData = self:GetBans()

    if BansData then
      -- Check Through Bans To See If Any Are Active
      print("Checking Through Bans")
    end
  end

  return false
end

--- Kicks the player from the server
---@param admin StaxPlayer
---@param reason string
function StaxPlayer:Kick(admin, reason)
  exports.ExternalSQL.AsyncQuery({
    query = [[ INSERT INTO `user_warns` (`reason`, `admin_id`, `user_id`) VALUES (:reason, :adminid, :userid) ]],
    data = {
      reason = reason,
      adminid = admin.Data.User.id,
      userid = self.Data.User.id
    }
  })
  DropPlayer(self.Handle, reason)
end

--- Bans the player from the server
---@param admin StaxPlayer
---@param reason string
---@param time table
function StaxPlayer:Ban(admin, reason, time)
  local permaBanned = false

  if time == nil then
    permaBanned = true
  end

  exports.ExternalSQL:AsyncQuery({
    query = [[ INSERT INTO `user_bans` (`reason`, `permaban`, `admin_id`, `user_id`) VALUES (:reason, :permaban, :adminid, :userid) ]],
    data = {
      reason = reason,
      permaban = permaBanned,
      adminid = admin.Data.User.id,
      userid = self.Data.User.id
    }
  })

  DropPlayer(self.Handle, reason)
end

--- Gets the players user data
---@return table | nil
function StaxPlayer:GetUser()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT * FROM `users` WHERE `identifier` = :identifier LIMIT 1 ]],
    data = {
      identifier = self:GetIdentifier(CoreConfig.Identifier)
    }
  })

  if results.ok then
    return results.data[1]
  end

  return nil
end

--- Gets all of the warnings the player has received
---@return table
function StaxPlayer:GetWarnings()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT * FROM `user_warns` WHERE `user_id` = :id ]],
    data = {
      id = self.Data.User.id
    }
  })

  if results.ok then
    return results.data
  end

  return {}
end

--- Gets the amount of warnings the player has received
---@return number
function StaxPlayer:GetWarningsCount()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT COUNT(*) FROM `user_warns` WHERE `user_id` = :id ]],
    data = {
      id = self.Data.User.id
    }
  })

  if results.ok then
    return results.data[1]["COUNT(*)"]
  end

  return 0
end

--- Gets all of the bans the player has received
---@return table
function StaxPlayer:GetBans()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT * FROM `user_bans` WHERE `user_id` = :id ]],
    data = {
      id = self.Data.User.id
    }
  })

  if results.ok then
    return results.data
  end

  return {}
end

--- Gets the amount of bans the player has received
---@return number
function StaxPlayer:GetBansCount()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT COUNT(*) FROM `user_bans` WHERE `user_id` = :id ]],
    data = {
      id = self.Data.User.id
    }
  })

  if results.ok then
    return results.data[1]["COUNT(*)"]
  end

  return 0
end

--- Gets all of the kicks the player has received
---@return table
function StaxPlayer:GetKicks()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT * FROM `user_kicks` WHERE `user_id` = :id ]],
    data = {
      id = self.Data.User.id
    }
  })

  if results.ok then
    return results.data
  end

  return {}
end

--- Gets the amount of kicks the player has received
---@return number
function StaxPlayer:GetKicksCount()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT COUNT(*) FROM `user_kicks` WHERE `user_id` = :id ]],
    data = {
      id = self.Data.User.id
    }
  })

  if results.ok then
    return results.data[1]["COUNT(*)"]
  end

  return 0
end

--- Creates a new database user for this player
function StaxPlayer:CreateUser()
  exports.ExternalSQL:AsyncQuery({
    query = [[ INSERT INTO `users` (`name`, `identifier`) VALUES (:name, :identifier) ]],
    data = {
      name = self.Name,
      identifier = self:GetIdentifier(CoreConfig.Identifier)
    }
  })
end

--- Updates the players name
function StaxPlayer:UpdateName()
  exports.ExternalSQL:AsyncQuery({
    query = [[ UPDATE `users` SET `name` = :name WHERE `identifier` = :identifier ]],
    data = {
      name = self.Name,
      identifier = self:GetIdentifier(CoreConfig.Identifier)
    }
  })
end

--- Updates the players last time played on the server
function StaxPlayer:UpdateLastPlayed()
  exports.ExternalSQL:AsyncQuery({
    query = [[ UPDATE `users` SET `name` = :name WHERE `identifier` = :identifier ]],
    data = {
      name = self.Name,
      identifier = self:GetIdentifier(CoreConfig.Identifier)
    }
  })
end

--- Fires an event on this player
---@param event string
---@param ... any
function StaxPlayer:FireEvent(event, ...)
  TriggerClientEvent(event, self.Handle, ...)
end