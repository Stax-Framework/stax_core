---@type StaxConfig
Config = {}

local isServer = IsDuplicityVersion()

if isServer then
  StaxEvent.CreateEvent("STAX::Core::Shared::ConfigListener", function(config)
    Config = StaxConfig.Class(config)
  end)
else
  StaxEvent.CreateNetEvent("STAX::Core::Shared::ConfigListener", function(config)
    Config = StaxConfig.Class(config)
  end)
end