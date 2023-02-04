StaxEvent.CreateEvent("CEventName", function(entities, eventEntity, data)
  StaxEvent.Fire("STAX::Core::Client::CEventName", entities, eventEntity, data)
end)

StaxEvent.CreateEvent("entityDamaged", function(defender, attacker, weapon, baseDamage)
  StaxEvent.Fire("STAX::Core::Client::EntityDamaged", defender, attacker, weapon, baseDamage)
end)

StaxEvent.CreateEvent("gameEventTriggered", function(name, data)
  StaxEvent.Fire("STAX::Core::Client::GameEventTriggered", name, data)
end)

StaxEvent.CreateEvent("mumbleConnected", function(address, reconnecting)
  StaxEvent.Fire("STAX::Core::Client::MumbleConnected", address, reconnecting)
end)

StaxEvent.CreateEvent("mumbleDisconnected", function(address)
  StaxEvent.Fire("STAX::Core::Client::MumbleDisconnected", address)
end)

StaxEvent.CreateEvent("onClientResourceStart", function(resource)
  StaxEvent.Fire("STAX::Core::Client::OnClientResourceStart", resource)
end)

StaxEvent.CreateEvent("onClientResourceStop", function(resource)
  StaxEvent.Fire("STAX::Core::Client::OnClientResourceStop", resource)
end)

StaxEvent.CreateEvent("onResourceStart", function(resource)
  StaxEvent.Fire("STAX::Core::Client::OnResourceStart", resource)
end)

StaxEvent.CreateEvent("onResourceStarting", function(resource)
  StaxEvent.Fire("STAX::Core::Client::OnResourceStarting", resource)
end)

StaxEvent.CreateEvent("onResourceStop", function(resource)
  StaxEvent.Fire("STAX::Core::Client::OnResourceStop", resource)
end)

StaxEvent.CreateEvent("populationPedCreating", function(x, y, z, model, override)
  StaxEvent.Fire("STAX::Core::Client::PopulationPedCreating", x, y, z, model, override)
end)

StaxEvent.CreateEvent("playerSpawned", function(spawn)
  StaxEvent.Fire("STAX::Core::Client::PlayerSpawned", spawn)
end)