StaxPluginManager = {}
StaxPluginManager.Plugins = {}

--- Creates new plugin instance and stores it
---@param resource string
function StaxPluginManager:AddPlugin(resource)
  local newPlugin = StaxPlugin.New(resource);

  local validPlugin = newPlugin:PreInit(function(CallInit)
    self.Plugins[newPlugin.Key] = newPlugin

    if self.Plugins.Dependencies then
      local timestamp = GetGameTimer() * 10000

      while not StaxPluginManager:ArePluginsMounted(self.Plugins.Dependencies) do
        if timestamp < GetGameTimer() then
          exports.stax_core:Logger_LogError("Could't wait any longer for dependencies", "[(" .. newPlugin.ResourceName .. ") " .. newPlugin.Name .. "]")
          return
        end
        Citizen.Wait(1000)
      end
    end

    CallInit()
  end)

  if not validPlugin then
    return
  end
end

--- Removes the plugin from the plugin manager
---@param resource string
function StaxPluginManager:RemovePlugin(resource)
  local key = self:GetPluginKey(resource)

  if not key then
    return
  end

  self.Plugins[key]:UnMount()

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

--- Gets if all defined plugins are mounted
---@param plugins table<string>
---@return boolean
function StaxPluginManager:ArePluginsMounted(plugins)
  local allMounted = true

  for pluginKey, plugin in pairs(self.Plugins) do
    for _, key in pairs(plugins) do
      if pluginKey == key then
        if not self.Plugins.Mounted then
          allMounted = false
          break
        end
      end
    end
  end

  return allMounted
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