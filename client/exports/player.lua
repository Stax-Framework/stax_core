-- FUNCTIONS
local function SetPlayerPedModel(model --[[ string || hash ]])
  local p = promise.new()
  local timeout = GetGameTimer() + 15000

  if type(model) == "string" then model = GetHashKey(model) end

  RequestModel(model)
  while not HasModelLoaded(model) do
    if timeout < GetGameTimer() then
      return p:reject()
    end
    Citizen.Wait(0)
  end

  SetPlayerModel(PlayerId(), model)

  return p:resolve({ ped = PlayerPedId() })
end

-- EXPORTS
exports("SetPlayerModel", SetPlayerPedModel)