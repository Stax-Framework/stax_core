---@class StaxLocalPlayer
---@field public Data table<string, any>
StaxLocalPlayer = {}
StaxLocalPlayer.Data = {
  PedHandle = PlayerPedId(),
  Model = GetEntityModel(PlayerPedId())
}

--- FUNCTIONS

--- Sets the local players ped model
---@param model string | number
function StaxLocalPlayer:SetModel(model)
  local timeout = GetGameTimer() + 10000

  if type(model) == "string" then model = GetHashKey(model) end

  if not IsModelInCdimage(model) then
    while not HasModelLoaded(model) do
      if GetGameTimer() > timeout  then
        return nil
      end
      Citizen.Wait(0)
    end
  end

  SetPlayerModel(PlayerId(), model)

  TriggerEvent("STAX::Core::Client::LocalPlayer::ModelUpdated", model)

  return nil
end

function StaxLocalPlayer:GetModel()
  return self.Data.Model
end

function StaxLocalPlayer:GetPed()
  return self.Data.PedHandle
end

--- EVENTS

--- Fires when the model for the local player is changed
---@param ped number
---@param model string | number
AddEventHandler("STAX::Core::Client::LocalPlayer::ModelUpdated", function(ped, model)
  StaxLocalPlayer.Data.PedHandle = ped
  StaxLocalPlayer.Data.Model = model
end)