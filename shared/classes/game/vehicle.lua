---@class StaxVehicle
---@field public IsServer boolean Whether or not the class instance is on the client or server
---@field public Handle number Entity Id
---@field public NetworkHandle number Entity Network Id
StaxVehicle = {}
StaxVehicle.__index = StaxVehicle

--- Create a new instance of StaxVehicle from already existing vehicle entity
function StaxVehicle.New(handle)
  local newVehicle = {}
  setmetatable(newVehicle, StaxVehicle)
    
  newVehicle.IsServer = IsDuplicityVersion()

  newVehicle.Handle = handle
  newVehicle.NetworkHandle = nil

  if NetworkGetEntityIsNetworked(self.Handle) then
    self.NetworkHandle = NetworkGetNetworkIdFromEntity(self.Handle)
  end

  return newVehicle
end

--- Create a new instance of StaxVehicle and create vehicle entity
function StaxVehicle.Create(model, position, heading, options)
  local newVehicle = {}
  setmetatable(newVehicle, StaxVehicle)

  local hash = GetHashKey(model)

  newVehicle.IsServer = IsDuplicityVersion()

  newVehicle.Handle = nil
  newVehicle.NetworkHandle = nil


  --- CREATING VEHICLE
  local networked = false
  local mission = false

  if type(options) == "table" then
    if options.networked then networked = options.networked end
    if options.mission then mission = options.mission end
  end

  if not IsModelInCdimage(hash) then
    local loadTimeCutoff = GetGameTimer() + 10000

    RequestModel(hash)
    while not HasModelLoaded(hash) do
      if GetGameTimer() > loadTimeCutoff then
        return nil
      end
      Citizen.Wait(0)
    end
  end

  local spawnedVehicle = CreateVehicle(hash, position.x, position.y, position.z, heading, networked, mission)

  if networked then
    self.NetworkHandle = NetworkGetNetworkIdFromEntity(spawnedVehicle)
  end

  return newVehicle
end

function StaxVehicle:Delete()
  DeleteVehicle(self.Handle)
end

function StaxVehicle:SetPosition(position, options)
  local clearArea = false

  if type(options) == "table" then
    if options.clearArea then clearArea = options.clearArea end
  end

  SetEntityCoords(self.Handle, position.x, position.y, position.z, false, false, false, clearArea)
end

function StaxVehicle:GetPosition()
  return GetEntityCoords(self.Handle, false)
end