---@class StaxConfig
---@field public Storage table
---@field public Shared table
---@field public Server table
---@field public Client table
StaxConfig = {}
StaxConfig.__index = StaxConfig

--- Creates a new instance of StaxConfig
---@param client table
---@param server table
---@param shared table
function StaxConfig.New(client, server, shared)
  local config = {}
  setmetatable(config, StaxConfig)

  config.Storage = {}

  config.Shared = shared
  config.Server = server
  config.Client = client

  config:Compile()
  -- local cfgClient = config:CompileClient()

  return config
end

--- Create a new instance of StaxConfig but loads the config directly
---@param cfg table
function StaxConfig.Load(cfg)
  local config = {}
  setmetatable(config, StaxConfig)

  config.Storage = cfg

  return config
end

--- Creates a server config
function StaxConfig:Compile()
  if not IsDuplicityVersion() then
    return nil
  end

  local shared = exports.stax_core:Table_Copy(self.Shared)

  for key, data in pairs(shared) do
    if self.Storage[key] then
      for dataKey, dataValue in pairs(data) do
        self.Storage[key][dataKey] = dataValue
      end
      break
    end

    self.Storage[key] = data
  end

  local server = exports.stax_core:Table_Copy(self.Server)

  for key, data in pairs(server) do
    if self.Storage[key] then
      for dataKey, dataValue in pairs(data) do
        self.Storage[key][dataKey] = dataValue
      end
      break
    end

    self.Storage[key] = data
  end

  local client = exports.stax_core:Table_Copy(self.Client)

  for key, data in pairs(client) do
    if self.Storage[key] then
      for dataKey, dataValue in pairs(data) do
        self.Storage[key][dataKey] = dataValue
      end
      break
    end

    self.Storage[key] = data
  end
end

--- Creates a client safe config to send to the client
---@return table | nil
function StaxConfig:CompileClient()
  if not IsDuplicityVersion() then
    return nil
  end

  local t = {}

  local shared = exports.stax_core:Table_Copy(self.Shared)

  for key, data in pairs(shared) do
    if t[key] then
      for dataKey, dataValue in pairs(data) do
        t[key][dataKey] = dataValue
      end
      break
    end

    t[key] = data
  end

  local client = exports.stax_core:Table_Copy(self.Client)

  for key, data in pairs(client) do
    if t[key] then
      for dataKey, dataValue in pairs(data) do
        t[key][dataKey] = dataValue
      end
      break
    end

    t[key] = data
  end

  return t
end

--- Gets a config from a keys path
---@param keys table<string>
function StaxConfig:Get(keys)
  if not keys then
    return self.Storage
  end

  local path = exports.stax_core:String_Split(keys, ".")

  local storage = exports.stax_core:Table_Copy(self.Storage)

  for _, v in pairs(path) do
    storage = storage[v]
  end
  
  return storage
end