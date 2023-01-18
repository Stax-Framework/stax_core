AddEventHandler("DZ::Server::Core::PlayerConnecting", function(player --[[ DZPlayer ]], deferrals --[[ table ]])
  player = DZPlayer.Class(player)

  deferrals.defer()
  deferrals.update(CoreLocale["connecting_retrieving_user_data"])

  if not DZServerManager:ServerReady() then
    deferrals.done(CoreLocale["connecting_server_not_ready"])
    return
  end

  local ServerWhitelisted = CoreConfig.Whitelisted

  -- Load Player User
  deferrals.update(CoreLocale["connecting_retrieving_user_data"])
  local playerUser = player:GetUser()

  if not playerUser then
    deferrals.update(CoreLocale["connecting_creating_user"])
    player:CreateUser()
    deferrals.update(CoreLocale["connecting_created_user"])

    if ServerWhitelisted then
      deferrals.done(CoreLocale["connecting_not_whitelisted"])
      return
    end

    deferrals.done("Catching Here... Success Connection")
  else
    deferrals.update(CoreLocale["connecting_welcome_back"])

    if ServerWhitelisted then
      if not player:IsWhitelisted() then
        deferrals.done(CoreLocale["connecting_not_whitelisted"])
        return
      end
    end

    -- BAN LOGIC HERE
    -- local bansCount = player:GetBansCount()

    -- if bansCount > 0 then
    --   local bans = player:GetBans()

    --   for _, v in pairs(bans) do
        
    --   end
    -- end

    deferrals.done("Catching Here... Success Connection")
  end
end)

AddEventHandler("DZ::Server::Core::PlayerJoining", function(source --[[ number ]], oldSource --[[ number ]], player --[[ DZPlayer ]])
  DZPlayerManager:AddPlayer(player)
end)

AddEventHandler("DZ::Server::Core::OnResourceStart", function(resource --[[ string ]])
  if GetCurrentResourceName() ~= resource then return end
  SetGameType("Custom Zombie Framework")
  SetMapName("DeadZone")
end)

AddEventHandler("DZ::Server::Core::PlayerDropped", function(player --[[ DZPlayer ]], reason --[[ string ]])
  local src = source
  DZPlayerManager:RemovePlayer(src)
  TriggerEvent("DZ::Server::Core::PlayerLeft", player)
end)