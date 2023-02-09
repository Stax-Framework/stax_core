--- Watches for players to start connecting to the server
---@param player StaxPlayer
---@param deferrals table
StaxEvent.CreateEvent("STAX::Core::Server::PlayerConnecting", function(player, deferrals)
  local supportLink = Config:Get("community.support_link")

  player = StaxPlayer.Class(player)

  --- Holding user here to check their user data
  deferrals.defer()

  --- Checking if the server is ready to be connected to
  if not StaxServerManager:ServerReady() then
    deferrals.done(Locale:Get("connecting_server_not_ready"))
    return
  end

  local serverIdentifier = Config:Get("framework.identifier")
  local identifier = player:GetIdentifier(serverIdentifier)

  if not identifier then
    deferrals.done(StaxString.Interpolate(Locale:Get("connecting_identifier_not_found"), { support = supportLink }))
    return
  end

  local user = player:LoadUser()

  if not user then
    deferrals.done(StaxString.Interpolate(Locale:Get("connecting_unable_to_implement_user"), { support = supportLink }))
    return
  end

  local bans = player.User.Bans
  local kicks = player.User.Kicks
  local warns = player.User.Warns

  if #bans > 0 then
    deferrals.update(Locale:Get("connecting_checking_bans"))

    local now = StaxDateTime.New(true)

    for k, v in pairs(bans) do
      if v.time ~= null then
        local banDateTime = StaxDateTime.NewDefaultSet(v.time)
        local difference = banDateTime:Compare(now)

        if difference.year > 0
          or different.month > 0
          or difference.day > 0
          or difference.hour > 0
          or difference.minute > 0
          or difference.second > 0
        then
          local banMessage = StaxString.Interpolate(Locale:Get("connecting_banned_message"), {
            time = json.encode(difference)
          })

          deferrals.done(banMessage)
          return
        end
      else
        local banMessage = StaxString.Interpolate(Locale:Get("connecting_banned_message"), {
          time = "Permanent"
        })

        deferrals.done(banMessage)
        return
      end
    end
  end

  deferrals.update(Locale:Get("connecting_bans_checked"))

  Citizen.Wait(500)

  deferrals.update(StaxString.Interpolate(Locale:Get("connecting_server_stats"), {
    bans = #bans,
    kicks = #kicks,
    warns = #warns
  }))

  local DisableQueue = Config:Get("queue.disable")

  if not DisableQueue then
    local CanPlayerJoin = StaxQueueManager:CanPlayerJoin()

    if not CanPlayerJoin then
      StaxQueueManager:Insert(source, deferrals.update, function()
        StaxQueueManager:PlayerJoined()
        deferrals.done("Player left the queue and is now connecting!")
      end)
    else
      StaxQueueManager:PlayerJoined()
    end
  end

  deferrals.done("Dev-Comment-Here")
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
  StaxQueueManager:PlayerLeft()
  StaxEvent.Fire("STAX::Core::Server::PlayerLeft", player)
end)