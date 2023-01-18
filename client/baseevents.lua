AddEventHandler("CEventName", function(entities --[[ table ]], eventEntity --[[ number ]], data --[[ any ]])
  TriggerEvent("STAX::Core::Client::CEventName", entities, eventEntity, data)
end)

AddEventHandler("entityDamaged", function(defender --[[ number ]], attacker --[[ number ]], weapon --[[ number ]], baseDamage --[[ number ]])
  TriggerEvent("STAX::Core::Client::EntityDamaged", defender, attacker, weapon, baseDamage)
end)

AddEventHandler("gameEventTriggered", function(name --[[ string ]], data --[[ table ]])
  TriggerEvent("STAX::Core::Client::GameEventTriggered", name, data)
end)

AddEventHandler("mumbleConnected", function(address --[[ string ]], reconnecting --[[ boolean ]])
  TriggerEvent("STAX::Core::Client::MumbleConnected", address, reconnecting)
end)

AddEventHandler("mumbleDisconnected", function(address --[[ string ]])
  TriggerEvent("STAX::Core::Client::MumbleDisconnected", address)
end)

AddEventHandler("onClientResourceStart", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Client::OnClientResourceStart", resource)
end)

AddEventHandler("onClientResourceStop", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Client::OnClientResourceStop", resource)
end)

AddEventHandler("onResourceStart", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Client::OnResourceStart", resource)
end)

AddEventHandler("onResourceStarting", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Client::OnResourceStarting", resource)
end)

AddEventHandler("onResourceStop", function(resource --[[ string ]])
  TriggerEvent("STAX::Core::Client::OnResourceStop", resource)
end)

AddEventHandler("populationPedCreating", function(x --[[ number ]], y --[[ number ]], z --[[ number ]], model --[[ number ]], override --[[ table ]])
  TriggerEvent("STAX::Core::Client::PopulationPedCreating", x, y, z, model, override)
end)

AddEventHandler("playerSpawned", function(spawn --[[ table ]])
  TriggerEvent("STAX::Core::Client::PlayerSpawned", spawn)
end)