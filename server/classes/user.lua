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

  local insertedUser = StaxDatabase.AsyncQuery([[ INSERT INTO `users` (`name`, `identifier`) VALUES (:name, :identifier) ]], {
    name = player.Name, identifier = playerIdentifier
  })

  if not insertedUser then
    exports.stax_core:Logger_LogError("Couldn't create user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  if not insertedUser.Ok then
    exports.stax_core:Logger_LogError("Couldn't create user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  local user = StaxDatabase.AsyncQuery([[ SELECT * FROM `users` WHERE `identifier` = :identifier LIMIT 1 ]], {
    identifier = playerIdentifier
  })

  if not user then
    return nil
  end

  if not user.Ok then
    exports.stax_core:Logger_LogError("Couldn't load newly created user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  if #user.Results < 1 then
    exports.stax_core:Logger_LogError("Couldn't load newly created user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  newUser.Id = user.Results[1].id
  newUser.Name = user.Results[1].name
  newUser.Identifier = user.Results[1].identifier
  newUser.Role = user.Results[1].role
  newUser.Allowlisted = user.Results[1].allowlisted
  newUser.Priority = user.Results[1].priority
  newUser.CreatedAt = user.Results[1].created_at
  newUser.LastPlayedAt = user.Results[1].last_played_at

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

  local user = StaxDatabase.AsyncQuery([[ SELECT * FROM `users` WHERE `identifier` = :identifier LIMIT 1 ]], {
    identifier = playerIdentifier
  })

  if not user then
    return nil
  end

  if not user.Ok then
    exports.stax_core:Logger_LogError("Couldn't load newly created user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  if not user.Ok then
    exports.stax_core:Logger_LogError("Couldn't load user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  if #user.Results < 1 then
    exports.stax_core:Logger_LogError("Couldn't load newly created user account", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  newUser.Id = user.Results[1].id
  newUser.Name = user.Results[1].name
  newUser.Identifier = user.Results[1].identifier
  newUser.Role = user.Results[1].role
  newUser.Allowlisted = user.Results[1].allowlisted
  newUser.Priority = user.Results[1].priority
  newUser.CreatedAt = user.Results[1].created_at
  newUser.LastPlayedAt = user.Results[1].last_played_at

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
  local bans = StaxDatabase.AsyncQuery([[ SELECT * FROM `user_bans` WHERE `user_id` = :id ]], {
    id = self.Id
  })

  if not bans then
    exports.stax_core:Logger_LogError("Couldn't load user bans", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  if not bans.Ok then
    exports.stax_core:Logger_LogError("Couldn't load user bans", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  return bans.Results
end

--- Creates a new ban record for this user
---@param reason string
---@param permanent boolean
---@param admin number
---@return boolean
function StaxUser:CreateBan(reason, permanent, admin)
  local insertedBan = StaxDatabase.AsyncQuery([[ INSERT INTO `user_bans` (`reason`, `permanent`, `admin_id`, `user_id`) VALUES (:reason, :permanent, :admin, :user) ]], {
    reason = reason,
    permanent = permanent,
    admin = admin,
    user = self.Id
  })

  if not insertedBan then
    return false
  end

  if not insertedBan.Ok then
    return false
  end

  return true
end

--- Loads the users stored kicks
function StaxUser:LoadKicks()
  local kicks = StaxDatabase.AsyncQuery([[ SELECT * FROM `user_kicks` WHERE `user_id` = :id ]], {
    id = self.Id
  })

  if not kicks then
    exports.stax_core:Logger_LogError("Couldn't load user kicks", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  if not kicks.Ok then
    exports.stax_core:Logger_LogError("Couldn't load user kicks", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  return kicks.Results
end

--- Creates a new kick record for this user
---@param reason string
---@param admin number
---@return boolean
function StaxUser:CreateKick(reason, admin)
  local insertedKick = StaxDatabase.AsyncQuery([[ INSERT INTO `user_kicks` (`reason`, `admin_id`, `user_id`) VALUES (:reason, :admin, :user) ]], {
    reason = reason,
    permanent = permanent,
    admin = admin,
    user = self.Id
  })

  if not insertedKick then
    return false
  end

  if not insertedKick.Ok then
    return false
  end

  return true
end

--- Loads the users stored warnings
function StaxUser:LoadWarns()
  local warns = StaxDatabase.AsyncQuery([[ SELECT * FROM `user_warns` WHERE `user_id` = :id ]], {
    id = self.Id
  })

  if not warns then
    exports.stax_core:Logger_LogError("Couldn't load user warns", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  if not warns.Ok then
    exports.stax_core:Logger_LogError("Couldn't load user warns", "[PLAYER]: [" .. player.Name .. "]")
    return nil
  end

  return warns.Results
end

--- Creates a new warn record for this user
---@param reason string
---@param admin number
---@return boolean
function StaxUser:CreateWarn(reason, admin)

  local insertedWarn = StaxDatabase.AsyncQuery([[ INSERT INTO `user_warns` (`reason`, `admin_id`, `user_id`) VALUES (:reason, :admin, :user) ]], {
    reason = reason,
    permanent = permanent,
    admin = admin,
    user = self.Id
  })

  if not insertedWarn then
    return false
  end

  if not insertedWarn.Ok then
    return false
  end

  return true
end