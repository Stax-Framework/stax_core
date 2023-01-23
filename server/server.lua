---@param player StaxPlayer
---@param deferrals table
AddEventHandler("STAX::Core::Server::PlayerConnecting", function(player, deferrals)
  player = StaxPlayer.Class(player)

  deferrals.defer()
  deferrals.update(CoreLocale["connecting_retrieving_user_data"])

  if not StaxServerManager:ServerReady() then
    deferrals.done(CoreLocale["connecting_server_not_ready"])
    return
  end

  -- Load Player User
  deferrals.update(CoreLocale["connecting_retrieving_user_data"])
  local playerUser = player:GetUser()

  if not playerUser then
    deferrals.update(CoreLocale["connecting_creating_user"])
    player:CreateUser()
    deferrals.update(CoreLocale["connecting_created_user"])

    if not CoreConfig.DisableAllowlist then
      deferrals.done(CoreLocale["connecting_not_whitelisted"])
      return
    end

    deferrals.done("Catching Here... Success Connection")
  else
    deferrals.update(CoreLocale["connecting_welcome_back"])

    if not CoreConfig.DisableAllowlist then
      if not player:IsAllowListed() then
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

AddEventHandler("STAX::Core::Server::PlayerJoining", function(source --[[ number ]], oldSource --[[ number ]], player --[[ StaxPlayer ]])
  StaxPlayerManager:AddPlayer(player)
end)

AddEventHandler("STAX::Core::Server::OnResourceStart", function(resource --[[ string ]])
  if GetCurrentResourceName() ~= resource then return end
  SetGameType("Stax Server Framework")
  SetMapName("STAX")
end)

AddEventHandler("STAX::Core::Server::PlayerDropped", function(player --[[ StaxPlayer ]], reason --[[ string ]])
  StaxPlayerManager:RemovePlayer(player.Handle)
  TriggerEvent("STAX::Core::Server::PlayerLeft", player)
end)