--- Watches for players to start connecting to the server
---@param player StaxPlayer
---@param deferrals table
StaxEvent.CreateEvent("STAX::Core::Server::PlayerConnecting", function(player, deferrals)
  player = StaxPlayer.Class(player)

  deferrals.defer()

  if not StaxServerManager:ServerReady() then
    return
  end

  local serverIdentifier = Config:Get("framework.identifier")
  local identifier = player:GetIdentifier(serverIdentifier)

  if not identifier then
    deferrals.done("We unfortunately couldn't find the required identifier... PLease reconnect or contact support!")
    return
  end

  local user = player:LoadUser()

  if not user then
    deferrals.done("Sorry.. We are unfortunately unable to retrieve a user account for you.. Please reconnect or contact support!")
    return
  end

  local bans = player.User.Bans

  if #bans > 0 then
    deferrals.done("kick here if there is still a ban active!")
    return
  end

  local kicks = player.User.Kicks

  if #kicks > 0 then
    return
  end

  local warns = player.User.Warns

  if #warns > 0 then
    return
  end


  deferrals.done("Sorry.. We are not allowing connections right now... Please come back another time!")
end)

--- Watches for when the player is joining
---@param source string
---@param oldSource string
---@param player StaxPlayer
StaxEvent.CreateEvent("STAX::Core::Server::PlayerJoining", function(source, oldSource, player)
  StaxPlayerManager:AddPlayer(player)
end)

--- Watches for when this resource starts
---@param resource string
StaxEvent.CreateEvent("STAX::Core::Server::OnResourceStart", function(resource)
  if GetCurrentResourceName() ~= resource then return end
  SetGameType("Stax Server Framework")
  SetMapName("STAX")
end)

--- Watches for when a player is dropped from the server
---@param player StaxPlayer
---@param reason string
StaxEvent.CreateEvent("STAX::Core::Server::PlayerDropped", function(player, reason)
  StaxPlayerManager:RemovePlayer(player)
  StaxEvent.Fire("STAX::Core::Server::PlayerLeft", player)
end)