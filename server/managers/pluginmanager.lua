StaxPluginManager = {}
StaxPluginManager.Plugins = {}

--- Creates new plugin instance and stores it
---@param resource string
function StaxPluginManager:AddPlugin(resource)
  local newPlugin, validPlugin = StaxPlugin.New(resource);

  if not validPlugin then
    return
  end

  self.Plugins[newPlugin.Key] = newPlugin

  newPlugin:Mounted()
end

--- Removes the plugin from the plugin manager
---@param resource string
function StaxPluginManager:RemovePlugin(resource)
  local key = self:GetPluginKey(resource)

  if not key then
    return
  end

  self.Plugins[key] = nil
end

--- Gets the plugin instance from its name
---@param key string
---@return StaxPlugin | nil
function StaxPluginManager:GetPlugin(key)
  return self.Plugins[key]
end

--- Gets the plugins defined key
---@param resource string
---@return string | nil
function StaxPluginManager:GetPluginKey(resource)
  local key = nil

  for k, v in pairs(self.Plugins) do
    if v.ResourceName == resource then
      key = k
      break
    end
  end

  if not key then
    return nil
  end

  return key
end

--- Hooks into the resource start base event
---@param resource string
AddEventHandler("STAX::Core::Server::OnResourceStart", function(resource)
  StaxPluginManager:AddPlugin(resource)
end)

--- Hooks into the resource stop base event
---@param resource string
AddEventHandler("STAX::Core::Server::OnResourceStop", function(resource)
  StaxPluginManager:RemovePlugin(resource)
end)