local Events = Stax.Events()

--- Triggered when an entity has been created.
---@param handle number
Events.CreateEvent("entityCreated", function(handle)
  Events.Fire("STAX::Core::Server::EntityCreated", handle)
end)

--- Triggered when an entity is being created
---@param handle number
Events.CreateEvent("entityCreating", function(handle)
  Events.Fire("STAX::Core::Server::EntityCreating", handle)
end)

--- Triggered when an entity is removed
---@param handle number
Events.CreateEvent("entityRemoved", function(handle)
  Events.Fire("STAX::Core::Server::EntityRemoved", handle)
end)

--- Triggered when the `refresh` command completes
Events.CreateEvent("onResourceListRefresh", function(handle)
  Events.Fire("STAX::Core::Server::OnResourceListRefresh")
end)

--- Triggered immediately when a resource has started
---@param resource string
Events.CreateEvent("onResourceStart", function(resource)
  Events.Fire("STAX::Core::Server::OnResourceStart", resource)
end)

--- Triggerd when a resource is trying to start
---@param resource string
Events.CreateEvent("onResourceStarting", function(resource)
  Events.Fire("STAX::Core::Server::OnResourceStarting", resource)
end)

--- Triggered immediately when a resource is stopping
---@param resource string
Events.CreateEvent("onResourceStop", function(resource)
  Events.Fire("STAX::Core::Server::OnResourceStop")
end)

--- Queued after resource has started
---@param resource string
Events.CreateEvent("onServerResourceStart", function(resource)
  Events.Fire("STAX::Core::Server::OnServerResourceStart", resource)
end)

--- Triggered after a resource has stopped
---@param resource string
Events.CreateEvent("onServerResourceStop", function(resource)
  Events.Fire("STAX::Core::Server::OnServerResourceStop", resource)
end)

--- Triggered when a player is trying to connect
---@param playerName string
---@param setKickReason fun(reason: string)
---@param deferrals { defer: function, done: fun(reason?: string), handover: fun(data: any), presentCard: fun(card: string | table, cb?: fun(data: any, rawData: string)), update: fun(message: string) }
Events.CreateEvent("playerConnecting", function(playerName, setKickReason, deferrals)
  Events.Fire("STAX::Core::Server::PlayerConnecting", playerName, setKickReason, deferrals)
end)

--- Triggered when a player enters another players scope
---@param data { for: string, player: string }
Events.CreateEvent("playerEnteredScope", function(data)
  Events.Fire("STAX::Core::Server::PlayerEnteredScope", data)
end)

--- Triggered when a player has finally assigned a NetID
---@param source string
---@param oldSource string
Events.CreateEvent("playerJoining", function(source, oldSource)
  Events.Fire("STAX::Core::Server::PlayerJoining", source, oldSource)
end)

--- Triggered when a player leaves another players scope
---@param data { for: string, player: string }
Events.CreateEvent("playerLeftScope", function(data)
  Events.Fire("STAX::Core::Server::PlayerLeftScope", data)
end)

--- Triggered when a particle fx is created
---@param sender string
---@param data { assetHash: number, axisBitset: number, effectHash: number, entityNetId: number, f100: number, f105: number, f106: number, f107: number, f109: boolean, f110: boolean, f111: boolean, f92: number, isOnEntity: boolean, offsetX: number, offsetY: number, offsetZ: number, posX: number, posY: number, posZ: number, rotX: number, rotY: number, rotZ: number, scale: number }
Events.CreateEvent("ptFxEvent", function(sender, data)
  Events.Fire("STAX::Core::Server::PTFXEvent", sender, data)
end)

--- Triggered when a player removes all weapons from a ped owned by another player
---@param sender number
---@param data { pedId: number }
Events.CreateEvent("removeAllWeaponsEvent", function(sender, data)
  Events.Fire("STAX::Core::Server::RemoveAllWeaponsEvent", sender, data)
end)

--- Triggered when a client wants to apply damage to a remotely owned entity
---@param sender number
---@param data {  }
Events.CreateEvent("startProjectileEvent", function(sender, data)
  Events.Fire("STAX::Core::Server::StartProjectileEvent")
end)