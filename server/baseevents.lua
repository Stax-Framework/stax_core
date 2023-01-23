AddEventHandler("playerDropped", function(reason --[[ string ]])
  local src = source
  local player = StaxPlayerManager:GetPlayer(src)
  TriggerEvent("STAX::Core::Server::PlayerDropped", player, reason)
end)

AddEventHandler("entityCreated", function(handle --[[ number ]])
  TriggerEvent("STAX::Core::Server::EntityCreated", handle)
end)

AddEventHandler("entityCreating", function(handle --[[ number ]])
  TriggerEvent("STAX::Core::Server::EntityCreating", handle)
end)

AddEventHandler("entityRemoved", function(handle --[[ number ]])
  TriggerEvent("STAX::Core::Server::EntityRemoved", handle)
end)

AddEventHandler("onResourceListRefresh", function()
  TriggerEvent("STAX::Core::Server::OnResourceListRefresh")
end)

AddEventHandler("onResourceStart", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Server::OnResourceStart", resource)
end)

AddEventHandler("onResourceStarting", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Server::OnResourceStarting", resource)
end)

AddEventHandler("onResourceStop", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Server::OnResourceStop", resource)
end)

AddEventHandler("onServerResourceStart", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Server::OnServerResourceStart", resource)
end)

AddEventHandler("onServerResourceStop", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Server::OnServerResourceStop", resource)
end)

AddEventHandler("playerConnecting", function(playerName --[[ string ]], setKickReason --[[ function ]], deferrals --[[ table ]])
  local src = source
  local player = StaxPlayer.New(src)
  TriggerEvent("STAX::Core::Server::PlayerConnecting", player, deferrals)
end)

AddEventHandler("playerJoining", function(source --[[ number ]], oldSource --[[ number ]])
  local src = source
  local player = StaxPlayer.New(src)
  TriggerEvent("STAX::Core::Server::PlayerJoining", src, oldSource, player)
end)

AddEventHandler("playerEnteredScope", function(scope --[[ table ]])
  local src = source
  local player = StaxPlayerManager:GetPlayer(src)
  TriggerEvent("STAX::Core::Server::PlayerEnteredScope", player, scope)
end)

AddEventHandler("playerLeftScope", function(scope --[[ table ]])
  local src = source
  local player = StaxPlayerManager:GetPlayer(src)
  TriggerEvent("STAX::Core::Server::PlayerLeftScope", player, scope)
end)

AddEventHandler("ptFxEvent", function(player --[[ number ]], data --[[ table ]])
  TriggerEvent("STAX::Core::Server::PTFXEvent", player, data)
end)

AddEventHandler("removeAllWeaponsEvent", function(player --[[ number ]], data --[[ table ]])
  TriggerEvent("STAX::Core::Server::RemoveAllWeaponsEvent", player, data)
end)

AddEventHandler("startProjectileEvent", function(player --[[ number ]], data --[[ table ]])
  TriggerEvent("STAX::Core::Server::StartProjectileEvent", player, data)
end)

AddEventHandler("weaponDamageEvent", function(player --[[ number ]], data --[[ table ]])
  TriggerEvent("STAX::Core::Server::WeaponDamageEvent", player, data)
end)

