local Events = Stax.Singletons.Events

Events.CreateEvent("onResourceStart", function(resource)
  Events.Fire("STAX::Core::Server::OnResourceStart", resource)
end)

Events.CreateEvent("onResourceStop", function(resource)
  Events.Fire("STAX::Core::Server::OnResourceStop")
end)