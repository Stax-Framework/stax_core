StaxPluginManager = {}
StaxPluginManager.Plugins = {}

--- Creates new plugin instance and stores it
---@param resource string
function StaxPluginManager:AddPlugin(resource)
  local newPlugin = StaxPlugin.New(resource);

  self.Plugins[newPlugin.Name] = newPlugin
end

--- Hooks into the resource start base event
---@param resource string
AddEventHandler("STAX::Core::Server::OnResourceStart", function(resource)
  StaxPluginManager:AddPlugin(resource)
end)