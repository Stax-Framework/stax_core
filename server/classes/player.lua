StaxPlayer = {}
StaxPlayer.__index = StaxPlayer

function StaxPlayer.New(handle --[[ number ]])
  local newPlayer = {}
  local playerName = GetPlayerName(handle)
  local validatedName = exports.dz_core:String_StripInvalidCharacters(playerName)

  setmetatable(newPlayer, StaxPlayer)

  newPlayer.Handle = handle
  newPlayer.Name = validatedName
  newPlayer.Identifiers = newPlayer:GetIdentifiers()
  newPlayer.Data = {}

  return newPlayer
end

function StaxPlayer.Class(data --[[ player ]])
  return setmetatable(data, StaxPlayer)
end

function StaxPlayer:SetData(key --[[ string ]], data --[[ any ]])
  self.Data[key] = data
end

function StaxPlayer:GetData(key --[[ string ]])
  return self.Data[key]
end

function StaxPlayer:GetIdentifiers()
  local amount = GetNumPlayerIdentifiers(self.Handle)
  local identifiers = {}

  for a = 0, amount do
    identifiers[#identifiers + 1] = GetPlayerIdentifier(self.Handle, a)
  end

  return identifiers
end

function StaxPlayer:GetIdentifier(identType --[[ string ]])
  for a = 1, #self.Identifiers do
    if string.find(self.Identifiers[a], identType, 1) then
      return self.Identifiers[a]
    end
  end
  return nil
end

function StaxPlayer:IsWhitelisted()
  local UserData = self:GetData("User")

  if not UserData then return false end

  if UserData.whitelisted == 1 then
    return true
  end

  return false
end

function StaxPlayer:IsBanned()
  local UserData = self:GetData("User")
  
  if not UserData then return false end

  local BansCount = self:GetBansCount()

  if BansCount > 0 then
    local BansData = self:GetBans()

    if BansData then
      -- Check Through Bans To See If Any Are Active
    end
  end
end

function StaxPlayer:Kick(admin --[[ StaxPlayer ]], reason --[[ string ]])
  exports.ExternalSQL.AsyncQuery({
    query = [[ INSERT INTO `user_warns` (`reason`, `admin_id`, `user_id`) VALUES (:reason, :adminid, :userid) ]],
    data = {
      reason = reason,
      adminid = admin.Data.User.id,
      userid = self.data.User.id
    }
  })
  DropPlayer(self.Handle, reason)
end

function StaxPlayer:Ban(admin --[[ StaxPlayer ]], reason --[[ string ]], time --[[ table ]])
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

function StaxPlayer:CreateUser()
  exports.ExternalSQL:AsyncQuery({
    query = [[ INSERT INTO `users` (`name`, `identifier`) VALUES (:name, :identifier) ]],
    data = {
      name = self.Name,
      identifier = self:GetIdentifier(CoreConfig.Identifier)
    }
  })
end

function StaxPlayer:UpdateName()
  exports.ExternalSQL:AsyncQuery({
    query = [[ UPDATE `users` SET `name` = :name WHERE `identifier` = :identifier ]],
    data = {
      name = self.Name,
      identifier = self:GetIdentifier(CoreConfig.Identifier)
    }
  })
end

function StaxPlayer:UpdateLastPlayed()
  exports.ExternalSQL:AsyncQuery({
    query = [[ UPDATE `users` SET `name` = :name WHERE `identifier` = :identifier ]],
    data = {
      name = self.Name,
      identifier = self:GetIdentifier(CoreConfig.Identifier)
    }
  })
end

function StaxPlayer:FireEvent(event --[[ string ]], ...--[[ any ]])
  TriggerClientEvent(event, self.Handle, ...)
end