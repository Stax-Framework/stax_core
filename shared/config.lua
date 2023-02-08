---@type StaxConfig
CoreConfig = {}

local isServer = IsDuplicityVersion()

if isServer then
  StaxEvent.CreateEvent("STAX::Core::Shared::ConfigListener", function(config)
    CoreConfig = StaxConfig.Class(config)
  end)
else
  StaxEvent.CreateNetEvent("STAX::Core::Shared::ConfigListener", function(config)
    CoreConfig = StaxConfig.Class(config)
  end)
end