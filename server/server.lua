local Events = Stax.Singletons.Events
local String = Stax.Singletons.String
local DateTime = Stax.Classes.DateTime
local Player = Stax.Classes.Player

--- Watches for players to start connecting to the server
---@param player Player
---@param deferrals table
Events.CreateEvent("STAX::Core::Server::PlayerConnecting", function(player, deferrals)
  local supportLink = Stax.Config:Get("community.support_link")

  player = Player.Class(player)

  --- Holding user here to check their user data
  deferrals.defer()

  local serverIdentifier = Stax.Config:Get("framework.identifier")
  local identifier = player:GetIdentifier(serverIdentifier)

  if not identifier then
    deferrals.done(String.Interpolate(Stax.Locale:Get("connecting_identifier_not_found"), { support = supportLink }))
    return
  end

  local user = player:LoadUser()

  if not user then
    deferrals.done(String.Interpolate(Stax.Locale:Get("connecting_unable_to_implement_user"), { support = supportLink }))
    return
  end

  local bans = player.User.Bans
  local kicks = player.User.Kicks
  local warns = player.User.Warns

  if #bans > 0 then
    deferrals.update(Stax.Locale:Get("connecting_checking_bans"))

    local now = DateTime.New(true)

    for _, v in pairs(bans) do
      if v.time ~= null then
        local banDateTime = DateTime.NewDefaultSet(v.time)
        local difference = banDateTime:Compare(now)

        if difference.year > 0
          or different.month > 0
          or difference.day > 0
          or difference.hour > 0
          or difference.minute > 0
          or difference.second > 0
        then
          local banMessage = String.Interpolate(Stax.Locale:Get("connecting_banned_message"), {
            time = json.encode(difference)
          })

          deferrals.done(banMessage)
          return
        end
      else
        local banMessage = String.Interpolate(Stax.Locale:Get("connecting_banned_message"), {
          time = "Permanent"
        })

        deferrals.done(banMessage)
        return
      end
    end
  end

  deferrals.update(Stax.Locale:Get("connecting_bans_checked"))

  Citizen.Wait(500)

  deferrals.update(String.Interpolate(Stax.Locale:Get("connecting_server_stats"), {
    bans = #bans,
    kicks = #kicks,
    warns = #warns
  }))
  -- local DisableQueue = Config:Get("queue.disable")

  -- if not DisableQueue then
  --   local CanPlayerJoin = StaxQueueManager:CanPlayerJoin()

  --   if not CanPlayerJoin then
  --     StaxQueueManager:Insert(source, deferrals.update, function()
  --       StaxQueueManager:PlayerJoined()
  --       deferrals.done("Player left the queue and is now connecting!")
  --     end)
  --   else
  --     StaxQueueManager:PlayerJoined()
  --   end
  -- end

  deferrals.done("Dev-Stopping-Connections-Here")
end)

--- Watches for when the player is joining
---@param source string
---@param oldSource string
---@param player Player
Events.CreateEvent("STAX::Core::Server::PlayerJoining", function(source, oldSource, player)
  StaxPlayerManager:AddPlayer(player)
end)

--- Watches for when this resource starts
---@param resource string
Events.CreateEvent("STAX::Core::Server::OnResourceStart", function(resource)
  if GetCurrentResourceName() ~= resource then return end
  SetGameType("Stax Server Framework")
  SetMapName("STAX")
end)

--- Watches for when a player is dropped from the server
---@param player Player
---@param reason string
Events.CreateEvent("STAX::Core::Server::PlayerDropped", function(player, reason)
  -- StaxPlayerManager:RemovePlayer(player)
  -- StaxQueueManager:PlayerLeft()
  Events.Fire("STAX::Core::Server::PlayerLeft", player)
end)