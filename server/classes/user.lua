---@class StaxUser
---@field public Id number User's Id
---@field public Name string User's Name
---@field public Identifier string User's Identifier
---@field public Role string User's Role
---@field public Allowlisted boolean If user is allowed to join when server is private
---@field public Priority boolean If user has priority connection queue
---@field public CreatedAt string When the user was created
---@field public LastPlayedAt string When the user has last played the server
---@field public Bans table All of the bans the user has accumulated
---@field public Kicks table All of the kicks the user has accumulated
---@field public Warns table All of the warnings the user has accumulated
StaxUser = {}
StaxUser.__index = StaxUser

--- Creates a new instance of the user account
---@param player StaxPlayer
---@return StaxUser | nil
function StaxUser.Create(player)
  local newUser = {}
  setmetatable(newUser, StaxUser)

  newUser.Id = nil
  newUser.Name = nil
  newUser.Identifier = nil
  newUser.Role = nil
  newUser.Allowlisted = false
  newUser.Priority = false
  newUser.CreatedAt = nil
  newUser.LastPlayedAt = nil

  newUser.Bans = {}
  newUser.Kicks = {}
  newUser.Warns = {}

  local playerIdentifier = player:GetIdentifier("license")

  local insertedUser = exports.ExternalSQL:AsyncQuery({
    query = [[ INSERT INTO `users` (`name`, `identifier`) VALUES (:name, :identifier) ]],
    data = {
      name = player.Name,
      identifier = playerIdentifier
    }
  })

  if not insertedUser.ok then
    exports.stax_core:Logger_LogError("Couldn't create user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  local user = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT * FROM `users` WHERE `identifier` = :identifier LIMIT 1 ]],
    data = {
      identifier = playerIdentifier
    }
  })

  if not user.ok then
    exports.stax_core:Logger_LogError("Couldn't load newly created user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  newUser.Id = user.results[1].id
  newUser.Name = user.results[1].name
  newUser.Identifier = user.results[1].identifier
  newUser.Role = user.results[1].role
  newUser.Allowlisted = user.results[1].allowlisted
  newUser.Priority = user.results[1].priority
  newUser.CreatedAt = user.results[1].created_at
  newUser.LastPlayedAt = user.results[1].last_played_at

  newUser.Bans = {}
  newUser.Kicks = {}
  newUser.Warns = {}

  return newUser
end

--- Creates a new instance of the user but loads already stored data
---@param player StaxPlayer
---@return StaxUser | nil
function StaxUser.Load(player)
  local newUser = {}
  setmetatable(newUser, StaxUser)

  local user = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT * FROM `users` WHERE `identifier` = :identifier LIMIT 1 ]],
    data = {
      identifier = player:GetIdentifier("license")
    }
  })

  if not user.ok then
    exports.stax_core:Logger_LogError("Couldn't load user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  newUser.Id = user.results[1].id
  newUser.Name = user.results[1].name
  newUser.Identifier = user.results[1].identifier
  newUser.Role = user.results[1].role
  newUser.Allowlisted = user.results[1].allowlisted
  newUser.Priority = user.results[1].priority
  newUser.CreatedAt = user.results[1].created_at
  newUser.LastPlayedAt = user.results[1].last_played_at

  newUser.Bans = newUser:LoadBans()
  newUser.Kicks = newUser:LoadKicks()
  newUser.Warns = newUser:LoadWarns()

  if not newUser.Bans or not newUser.Kicks or not newUser.Warns then
    exports.stax_core:Logger_LogError("Couldn't load user", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  return newUser
end

--- Checks if the user is allowed to bypass private server checks
---@return boolean
function StaxUser:IsAllowlisted()
  if self.Allowlisted then
    return true
  end

  return false
end

--- Loads the users stored bans
function StaxUser:LoadBans()
  local bans = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT * FROM `user_bans` WHERE `user_id` = :id ]],
    data = {
      id = newUser.Id
    }
  })

  if not bans.ok then
    exports.stax_core:Logger_LogError("Couldn't load user bans", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  return bans.results
end

--- Creates a new ban record for this user
---@param reason string
---@param permanent boolean
---@param admin number
---@return boolean
function StaxUser:CreateBan(reason, permanent, admin)
  local insertedBan = exports.ExternalSQL:AsyncQuery({
    query = [[ INSERT INTO `user_bans` (`reason`, `permanent`, `admin_id`, `user_id`) VALUES (:reason, :permanent, :admin, :user) ]],
    data = {
      reason = reason,
      permanent = permanent,
      admin = admin,
      user = self.Id
    }
  })

  if not insertedBan.ok then
    return false
  end

  return true
end

--- Loads the users stored kicks
function StaxUser:LoadKicks()
  local kicks = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT * FROM `user_kicks` WHERE `user_id` = :id ]],
    data = {
      id = newUser.Id
    }
  })

  if not kicks.ok then
    exports.stax_core:Logger_LogError("Couldn't load user kicks", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  return kicks.results
end

--- Creates a new kick record for this user
---@param reason string
---@param admin number
---@return boolean
function StaxUser:CreateKick(reason, admin)
  local insertedKick = exports.ExternalSQL:AsyncQuery({
    query = [[ INSERT INTO `user_kicks` (`reason`, `admin_id`, `user_id`) VALUES (:reason, :admin, :user) ]],
    data = {
      reason = reason,
      permanent = permanent,
      admin = admin,
      user = self.Id
    }
  })

  if not insertedKick.ok then
    return false
  end

  return true
end

--- Loads the users stored warnings
function StaxUser:LoadWarns()
  local warns = exports.ExternalSQL:AsyncQuery({
    query = [[ SELECT * FROM `user_warns` WHERE `user_id` = :id ]],
    data = {
      id = newUser.Id
    }
  })

  if not warns.ok then
    exports.stax_core:Logger_LogError("Couldn't load user warns", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  return warns.results
end

--- Creates a new warn record for this user
---@param reason string
---@param admin number
---@return boolean
function StaxUser:CreateWarn(reason, admin)
  local insertedWarn = exports.ExternalSQL:AsyncQuery({
    query = [[ INSERT INTO `user_warns` (`reason`, `admin_id`, `user_id`) VALUES (:reason, :admin, :user) ]],
    data = {
      reason = reason,
      permanent = permanent,
      admin = admin,
      user = self.Id
    }
  })

  if not insertedWarn.ok then
    return false
  end

  return true
end