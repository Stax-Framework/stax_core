local Exports = Stax.Singletons.Exports
local Events = Stax.Singletons.Events
local Logger = Stax.Singletons.Logger
local Plugin = Stax.Classes.Plugin

---@class PluginManager
local PluginManager = {
  Plugins = {}
}

--- Creates new plugin instance and stores it
---@param resource string
function PluginManager:AddPlugin(resource)
  print("ADDED PLUGIN: " .. resource)
  local newPlugin = Plugin.New(resource);

  local validPlugin = newPlugin:PreInit(function(CallInit)
    self.Plugins[newPlugin.Key] = newPlugin

    if newPlugin.Dependencies then
      local timestamp = GetGameTimer() * 10000

      while not PluginManager:ArePluginsMounted(newPlugin.Dependencies) do
        if timestamp < GetGameTimer() then
          Logger.Error("Could't wait any longer for dependencies", "[(" .. newPlugin.ResourceName .. ") " .. newPlugin.Name .. "]")
          return
        end
        Citizen.Wait(100)
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
function PluginManager:RemovePlugin(resource)
  local key = self:GetPluginKey(resource)

  if not key then
    return
  end

  self.Plugins[key]:UnMount()
  self.Plugins[key] = nil
end

--- Gets the plugin instance from its name
---@param key string
---@return Plugin | nil
function PluginManager:GetPlugin(key)
  return self.Plugins[key]
end

Exports.Create("PluginManager_GetPlugin", function(key)
  return PluginManager:GetPlugin(key)
end)

--- Gets the plugins defined key
---@param resource string
---@return string | nil
function PluginManager:GetPluginKey(resource)
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

Exports.Create("PluginManager_GetPluginKey", function(resource)
  return PluginManager:GetPluginKey(resource)
end)

--- Gets if all defined plugins are mounted
---@param plugins table<string>
---@return boolean
function PluginManager:ArePluginsMounted(plugins)
  local allMounted = true

  for pluginKey, plugin in pairs(self.Plugins) do
    for _, key in pairs(plugins) do
      if pluginKey == key then
        if not plugin.Mounted then
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
Events.CreateEvent("STAX::Core::Server::OnResourceStart", function(resource)
  PluginManager:AddPlugin(resource)
end)

--- Hooks into the resource stop base event
---@param resource string
Events.CreateEvent("STAX::Core::Server::OnResourceStop", function(resource)
  PluginManager:RemovePlugin(resource)
end)

--- Fires when a plugin is mounted
---@param plugin Plugin
Events.CreateEvent("STAX::Core::Server::PluginMounted", function(plugin)
  Logger.Success("Plugin Mounted", "[(" .. plugin.ResourceName .. ") " .. plugin.Name .. "]")
end)

--- Fires when a plugin is unmounted
---@param plugin Plugin
Events.CreateEvent("STAX::Core::Server::PluginUnMounted", function(plugin)
  Logger.Success("Plugin UnMounted", "[(" .. plugin.ResourceName .. ") " .. plugin.Name .. "]")
end)