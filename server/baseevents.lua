StaxEvent.CreateEvent("playerDropped", function(reason)
  local player = StaxPlayerManager:GetPlayer(source)
  StaxEvent.Fire("STAX::Core::Server::PlayerDropped", player, reason)
end)

StaxEvent.CreateEvent("entityCreated", function(handle)
  StaxEvent.Fire("STAX::Core::Server::EntityCreated", handle)
end)

StaxEvent.CreateEvent("entityCreating", function(handle)
  StaxEvent.Fire("STAX::Core::Server::EntityCreating", handle)
end)

StaxEvent.CreateEvent("entityRemoved", function(handle)
  StaxEvent.Fire("STAX::Core::Server::EntityRemoved", handle)
end)






StaxEvent.CreateEvent("onResourceListRefresh", function()
  StaxEvent.Fire("STAX::Core::Server::OnResourceListRefresh")
end)

StaxEvent.CreateEvent("onResourceStart", function(resource)
  StaxEvent.Fire("STAX::Core::Server::OnResourceStart", resource)
end)

StaxEvent.CreateEvent("onResourceStarting", function(resource)
  StaxEvent.Fire("STAX::Core::Server::OnResourceStarting", resource)
end)

StaxEvent.CreateEvent("onResourceStop", function(resource)
  StaxEvent.Fire("STAX::Core::Server::OnResourceStop", resource)
end)

StaxEvent.CreateEvent("onServerResourceStart", function(resource)
  StaxEvent.Fire("STAX::Core::Server::OnServerResourceStart", resource)
end)

StaxEvent.CreateEvent("onServerResourceStop", function(resource)
  StaxEvent.Fire("STAX::Core::Server::OnServerResourceStop", resource)
end)

StaxEvent.CreateEvent("playerConnecting", function(name, setKick, deferrals)
  local player = StaxPlayer.New(source)
  StaxEvent.Fire("STAX::Core::Server::PlayerConnecting", player, deferrals)
end)

StaxEvent.CreateEvent("playerJoining", function(source, oldSource)
  local player = StaxPlayer.New(source)
  StaxEvent.Fire("STAX::Core::Server::PlayerJoining", source, oldSource, player)
end)

StaxEvent.CreateEvent("playerEnteredScope", function(scope)
  local player = StaxPlayerManager:GetPlayer(source)
  StaxEvent.Fire("STAX::Core::Server::PlayerEnteredScope", player, scope)
end)

StaxEvent.CreateEvent("playerLeftScope", function(scope)
  local player = StaxPlayerManager:GetPlayer(source)
  StaxEvent.Fire("STAX::Core::Server::PlayerLeftScope", player, scope)
end)

StaxEvent.CreateEvent("ptFxEvent", function(playerHandle, data)
  local player = StaxPlayerManager:GetPlayer(playerHandle)
  StaxEvent.Fire("STAX::Core::Server::PTFXEvent", player, data)
end)

StaxEvent.CreateEvent("removeAllWeaponsEvent", function(playerHandle, data)
  local player = StaxPlayerManager:GetPlayer(playerHandle)
  StaxEvent.Fire("STAX::Core::Server::RemoveAllWeaponsEvent", player, data)
end)

StaxEvent.CreateEvent("startProjectileEvent", function(playerHandle, data)
  local player = StaxPlayerManager:GetPlayer(playerHandle)
  StaxEvent.Fire("STAX::Core::Server::StartProjectileEvent", player)
end)

StaxEvent.CreateEvent("weaponDamageEvent", function(playerHandle, data)
  local player = StaxPlayerManager:GetPlayer(playerHandle)
  StaxEvent.Fire("STAX::Core::Server::WeaponDamageEvent", player, data)
end)