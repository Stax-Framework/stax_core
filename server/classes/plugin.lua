---@class StaxPlugin
---@field public ResourceName string Plugin resource folder name
---@field public Key string Plugin defined key
---@field public Name string Plugin defined name
---@field public Description string Plugin defined description
---@field public Dependencies table<string> Plugin defined dependencies
---@field public Config table Plugin configurations
---@field public Locale table Plugin localization
---@field public Mounted boolean Plugin is mounted
StaxPlugin = {}
StaxPlugin.__index = StaxPlugin

--- Create new instance of StaxPlugin
---@param resource string
---@return StaxPlugin
function StaxPlugin.New(resource)
  local newPlugin = {}
  setmetatable(newPlugin, StaxPlugin)

  newPlugin.ResourceName = resource
  newPlugin.Key = nil
  newPlugin.Name = nil
  newPlugin.Description = nil
  newPlugin.Dependencies = nil
  newPlugin.Config = nil
  newPlugin.Locale = nil

  newPlugin.Mounted = false

  return newPlugin
end

--- Preinit Function
---@param callback function Calls the Initialize Function
function StaxPlugin:PreInit(callback)
  local hasPluginInfo = self:GetPluginInfo()

  if not hasPluginInfo then
    return false
  end

  local function CallInit()
    self:Init(function()
      self:Mount()
    end)
  end

  callback(CallInit)

  return true
end

--- Initializes the plugins
---@param mount function Calls for the plugin to mount
function StaxPlugin:Init(mount)
  self:LoadConfig()
  self:Migrate()
  mount()
end

--- Fires after the plugin has been mounted
function StaxPlugin:Mount()
  self:LoadLocale()
  self.Mounted = true

  TriggerEvent("STAX::Core::Server::PluginMounted", self)
end

function StaxPlugin:UnMount()
  self.Mounted = false
  TriggerEvent("STAX::Core::Server::PluginUnMounted", self)
end

--- Get plugin name
function StaxPlugin:GetPluginInfo()
  local data = self:GetAllByKey("stax_plugin")

  if not data then return end
  if not data[1] then return end

  self.Key = data[1].value
  
  local extra = json.decode(data[1].extra)

  self.Name = extra.name
  self.Description = extra.description

  if extra.dependency then
    self.Dependencies = extra.dependency
  end
 
  if self.Key and self.Name and self.Description then
    return true
  end

  return false
end

--- Gets the migratiosn from the path and executes the plugins
---@return boolean
function StaxPlugin:Migrate()
  exports.stax_core:Logger_LogSuccess("Starting Migrations", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")

  local pluginDirectory = GetResourcePath(self.ResourceName) .. "/sql/"

  local files = exports.stax_core:Directory_Scan(pluginDirectory)

  if #files < 1 then
    exports.stax_core:Logger_LogError("Didn't find any sql files", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
    return false
  end

  for a = 1, #files do
    local sql = LoadResourceFile(self.ResourceName, "/sql/" .. files[a])
    
    exports.stax_core:Logger_LogSuccess("Executing Query", "[(" .. self.ResourceName .. ") " .. self.Name .. "] :: " .. files[a])
    
    local results = exports.ExternalSQL:AsyncQuery({
      query = sql
    })
  
    if not results.ok then
      print("Query Results: " .. json.encode(results))
      return false
    end

    exports.stax_core:Logger_LogSuccess("Executed Query", "[(" .. self.ResourceName .. ") " .. self.Name .. "] :: " .. files[a])
  end

  exports.stax_core:Logger_LogSuccess("Migration Complete", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")

  return true
end

--- Loads the plugins config
function StaxPlugin:LoadConfig()
  local pluginDirectory = GetResourcePath(self.ResourceName) .. "/configs/"

  local files = exports.stax_core:Directory_Scan(pluginDirectory)

  if #files < 1 then
    exports.stax_core:Logger_LogError("Didn't find any config files", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
    return false
  end

  local config = { client = {}, server = {}, shared = {} }

  for a = 1, #files do
    if not string.find(files[a], ".json") then
      break
    end

    local boundary = nil
    local configKey = nil
    local data = LoadResourceFile(self.ResourceName, "/configs/" .. files[a])
    local cfg = json.decode(data)

    if string.find(files[a], ".client.") then
      boundary = "client"
      configKey = string.gsub(files[a], ".client.json", "")
      
    elseif string.find(files[a], ".server.") then
      boundary = "server"
      configKey = string.gsub(files[a], ".server.json", "")
    else
      boundary = "shared"
      configKey = string.gsub(files[a], ".json", "")
    end

    if not config[boundary][configKey] then
      config[boundary][configKey] = cfg
    else
      for l, p in pairs(cfg) do
        config[boundary][configKey][l] = p
      end
    end
  end

  self.Config = StaxConfig.New(config.client, config.server, config.shared)

  exports.stax_core:Logger_LogSuccess("Loaded Config", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
end

--- Loads the plugins locale language file
function StaxPlugin:LoadLocale()
  local corePlugin = StaxPluginManager:GetPlugin("stax-core")

  if not corePlugin then
    exports.stax_core:Logger_LogError("Couldn't get core plugin", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
    return
  end

  --- REMOVE THIS ONCE YOU ADD CONFIG GETTER METHODS
  local lang = corePlugin.Config:Get("framework.locale")

  if not lang then
    exports.stax_core:Logger_LogError("Couldn't get language from core config", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
    return
  end

  local locale = LoadResourceFile(self.ResourceName, "/locales/" .. lang .. ".json")

  if not locale then
    exports.stax_core:Logger_LogError("Couldn't get locale file", "[(" .. self.ResourceName .. ") " .. self.Name .. "] :: LANG = " .. lang)
    return
  end

  local decodedLocale = json.decode(locale)

  self.Locale = StaxLocale.New(decodedLocale)

  exports.stax_core:Logger_LogSuccess("Loaded Locale", "[(" .. self.ResourceName .. ") " .. self.Name .. "]")
end

--- Checks if the plugin has metadata key
---@param key string
---@return boolean
function StaxPlugin:HasKey(key)
  return GetNumResourceMetadata(self.ResourceName, key) > 0
end

--- Gets all metadata by key
---@param key string
---@return table | nil
function StaxPlugin:GetAllByKey(key)
  if not self:HasKey(key) then
    return nil
  end

  local count = GetNumResourceMetadata(self.ResourceName, key)

  local values = {}

  for a = 0, count do
    local data = GetResourceMetadata(self.ResourceName, key, a)

    values[#values + 1] = {
      value = GetResourceMetadata(self.ResourceName, key, a),
      extra = GetResourceMetadata(self.ResourceName, key .. "_extra", a)
    }
  end

  return values
end

--- Checks if the plugin has metadata key
---@param key string
---@return table | nil
function StaxPlugin:GetFirstByKey(key)
  return self:GetAllByKey(key)[1]
end