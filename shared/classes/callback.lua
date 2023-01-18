DZCallback = {}
DZCallback.__index = DZCallback

function DZCallback.New()
  local newCallback = {}
  setmetatable(newCallback, DZCallback)

  newCallback.Resource = GetCurrentResourceName()
  newCallback.Callbacks = {}
  newCallback.IsServer = IsDuplicityVersion()

  if newCallback.IsServer then
    RegisterNetEvent("DZ::Server::Core::RecieveCallback")
    AddEventHandler("DZ::Server::Core::RecieveCallback", function(callback --[[ string ]], payload --[[ any ]])
      for key, cb in pairs(newCallback.Callbacks) do
        if key == callback then
          cb(payload)
          break
        end
      end
    end)
  else
    RegisterNetEvent("DZ::Client::Core::RecieveCallback")
    AddEventHandler("DZ::Client::Core::RecieveCallback", function(callback --[[ string ]], payload --[[ any ]])
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

function DZCallback:Fire(name --[[ string ]], resource --[[ string ]], data --[[ any ]], callback --[[ function ]], player --[[ number ]])
  local key = exports.dz_core:String_RandomString(10)
  self.Callbacks[key] = callback
  
  if self.IsServer then
    TriggerClientEvent(
      "DZ::Client::Core::Callback::" .. resource .. "::" .. name,
      player,
      key,
      data
    )
  else
    TriggerServerEvent(
      "DZ::Server::Core::Callback::" .. resource .. "::" .. name,
      key,
      data
    )
  end
end

function DZCallback:CreateCallback(name --[[ string ]], callback --[[ function ]])
  local event = nil

  if self.IsServer then
    event = tostring("DZ::Server::Core::Callback::" .. self.Resource .. "::" .. name)
  else
    event = tostring("DZ::Client::Core::Callback::" .. self.Resource .. "::" .. name)
  end

  RegisterNetEvent(event)
  AddEventHandler(event, function(key, data)
    local src = source

    callback(data, function(results)
      if self.IsServer then
        TriggerClientEvent("DZ::Client::Core::RecieveCallback", src, key, results)
      else
        TriggerServerEvent("DZ::Server::Core::RecieveCallback", key, results)
      end
    end)
  end)
end