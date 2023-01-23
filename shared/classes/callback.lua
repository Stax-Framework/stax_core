---@class StaxCallback
---@field public Resource string Resource making the callback
---@field public Callbacks table Callbacks when registered get stored here
---@field public IsServer boolean If the callback instance is on the client or SetDriverRacingModifier(Ped* driver, float* modifier)
StaxCallback = {}
StaxCallback.__index = StaxCallback

--- Instantiates a new instance of a network callback
---@return StaxCallback
function StaxCallback.New()
  local newCallback = {}
  setmetatable(newCallback, StaxCallback)

  newCallback.Resource = GetCurrentResourceName()
  newCallback.Callbacks = {}
  newCallback.IsServer = IsDuplicityVersion()

  if newCallback.IsServer then
    RegisterNetEvent("STAX::Core::Server::RecieveCallback")

    ---@param callback string
    ---@param payload any
    AddEventHandler("STAX::Core::Server::RecieveCallback", function(callback, payload)
      for key, cb in pairs(newCallback.Callbacks) do
        if key == callback then
          cb(payload)
          break
        end
      end
    end)
  else
    RegisterNetEvent("STAX::Core::Client::RecieveCallback")

    ---@param callback string
    ---@param payload any
    AddEventHandler("STAX::Core::Client::RecieveCallback", function(callback, payload)
      for key, cb in pairs(newCallback.Callbacks) do
        if key == callback then
          cb(payload)
          break
        end
      end
    end)
  end

  return newCallback
end

--- Fires the callback and retrieves the data
---@param name string
---@param resource string
---@param data any
---@param callback function
---@param player string
function StaxCallback:Fire(name, resource, data, callback, player)
  local key = exports.stax_core:String_RandomString(10)
  self.Callbacks[key] = callback
  
  if self.IsServer then
    TriggerClientEvent(
      "STAX::Core::Client::Callback::" .. resource .. "::" .. name,
      player,
      key,
      data
    )
  else
    TriggerServerEvent(
      "STAX::Core::Server::Callback::" .. resource .. "::" .. name,
      key,
      data
    )
  end
end

function StaxCallback:CreateCallback(name --[[ string ]], callback --[[ function ]])
  local event = nil

  if self.IsServer then
    event = tostring("STAX::Core::Server::Callback::" .. self.Resource .. "::" .. name)
  else
    event = tostring("STAX::Core::Client::Callback::" .. self.Resource .. "::" .. name)
  end

  RegisterNetEvent(event)
  AddEventHandler(event, function(key, data)
    local src = source

    callback(data, function(results)
      if self.IsServer then
        TriggerClientEvent("STAX::Core::Client::RecieveCallback", src, key, results)
      else
        TriggerServerEvent("STAX::Core::Server::RecieveCallback", key, results)
      end
    end)
  end)
end