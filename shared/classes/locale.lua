---@class StaxLocale
---@field public Storage table Storage for all the locales
StaxLocale = {}
StaxLocale.__index = StaxLocale

--- Creates a new instance of StaxLocale
---@param locale table
---@return StaxLocale
function StaxLocale.New(locale)
  local newLocale = {}
  setmetatable(newLocale, StaxLocale)

  newLocale.Storage = locale

  return newLocale
end

--- Gets a config from a keys path
---@param keys table<string>
function StaxLocale:Get(keys)
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