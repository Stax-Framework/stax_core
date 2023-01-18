StaxCallback = {}
StaxCallback.__index = StaxCallback

function StaxCallback.New()
  local newCallback = {}
  setmetatable(newCallback, StaxCallback)

  newCallback.Resource = GetCurrentResourceName()
  newCallback.Callbacks = {}
  newCallback.IsServer = IsDuplicityVersion()

  if newCallback.IsServer then
    RegisterNetEvent("STAX::Core::Server::RecieveCallback")
    AddEventHandler("STAX::Core::Server::RecieveCallback", function(callback --[[ string ]], payload --[[ any ]])
      for key, cb in pairs(newCallback.Callbacks) do
        if key == callback then
          cb(payload)
          break
        end
      end
    end)
  else
    RegisterNetEvent("STAX::Core::Client::RecieveCallback")
    AddEventHandler("STAX::Core::Client::RecieveCallback", function(callback --[[ string ]], payload --[[ any ]])
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

function StaxCallback:Fire(name --[[ string ]], resource --[[ string ]], data --[[ any ]], callback --[[ function ]], player --[[ number ]])
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