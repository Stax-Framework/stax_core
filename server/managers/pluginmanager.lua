StaxPluginManager = {}
StaxPluginManager.Plugins = {}

--- Creates new plugin instance and stores it
---@param resource string
function StaxPluginManager:AddPlugin(resource)
  local newPlugin = StaxPlugin.New(resource);

  self.Plugins[newPlugin.Key] = newPlugin

  newPlugin:Mounted()
end

--- Gets the plugin instance from its name
---@param key string
---@return StaxPlugin | nil
function StaxPluginManager:GetPlugin(key)
  return self.Plugins[key]
end

--- Hooks into the resource start base event
---@param resource string
AddEventHandler("STAX::Core::Server::OnResourceStart", function(resource)
  StaxPluginManager:AddPlugin(resource)
end)