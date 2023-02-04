--- Watches for players to start connecting to the server
---@param player StaxPlayer
---@param deferrals table
StaxEvent.CreateEvent("STAX::Core::Server::PlayerConnecting", function(player, deferrals)
  player = StaxPlayer.Class(player)

  deferrals.defer()

  if not StaxServerManager:ServerReady() then
    return
  end

  ---TODO: Convert "license" to config option later
  local identifier = player:GetIdentifier("license")

  if not identifier then
    deferrals.done("We unfortunately couldn't find the required identifier... Please contact support!")
    return
  end

  local userExists = StaxUser.Exists(identifier)

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