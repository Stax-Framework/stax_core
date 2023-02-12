local Events = Stax.Singletons.Events
local Logger = Stax.Singletons.Logger
local Plugin = Stax.Classes.Plugin

---@class PluginManager
local PluginManager = {
  Plugins = {}
}

--- Creates new plugin instance and stores it
---@param resource string
function PluginManager.AddPlugin(resource)
  local newPlugin = Plugin.New(resource);

  local validPlugin = newPlugin:PreInit(function(CallInit)
    PluginManager.Plugins[newPlugin.Key] = newPlugin
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
function PluginManager.RemovePlugin(resource)
  local key = PluginManager.GetPluginKey(resource)

  if not key then
    return
  end

  PluginManager.Plugins[key]:UnMount()
  PluginManager.Plugins[key] = nil
end

--- Gets the plugin instance from its name
---@param key string
---@return Plugin | nil
function PluginManager.GetPlugin(key)
  return PluginManager.Plugins[key]
end

exports("PluginManager_GetPlugin", PluginManager.GetPlugin)

--- Gets the plugins defined key
---@param resource string
---@return string | nil
function PluginManager.GetPluginKey(resource)
  local key = nil

  for k, v in pairs(PluginManager.Plugins) do
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

exports("PluginManager_GetPluginKey", PluginManager.GetPluginKey)

--- Gets if all defined plugins are mounted
---@param plugins table<string>
---@return boolean
function PluginManager.ArePluginsMounted(plugins)
  local allMounted = true

  for pluginKey, plugin in pairs(PluginManager.Plugins) do
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
  PluginManager.AddPlugin(resource)
end)

--- Hooks into the resource stop base event
---@param resource string
Events.CreateEvent("STAX::Core::Server::OnResourceStop", function(resource)
  PluginManager.RemovePlugin(resource)
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