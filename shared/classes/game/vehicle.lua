---@class StaxVehicle
---@field public IsServer boolean Whether or not the class instance is on the client or server
---@field public Handle number Entity Id
---@field public Blip number Blip Id
StaxVehicle = {}
StaxVehicle.__index = StaxVehicle

--- Create a new instance of StaxVehicle from already existing vehicle entity
function StaxVehicle.New(handle)
  local newVehicle = {}
  setmetatable(newVehicle, StaxVehicle)
    
  newVehicle.IsServer = IsDuplicityVersion()
  newVehicle.Handle = handle

  -- Blips
  newVehicle.Blip = nil

  return newVehicle
end

function StaxVehicle.Create(model, position, rotation, options)
  local newVehicle = {}
  setmetatable(newVehicle, StaxVehicle)

  newVehicle.Handle = nil
  newVehicle.Blip = nil

  return newVehicle
end

--- Adds a blip to the vehicle entity
---@return number
function StaxVehicle:AddBlip()
  self.Blip = AddBlipForEntity(self.Handle)
  return self.Blip
end

--- Gets the vehicles engine status
---@return boolean
function StaxVehicle:IsEngineRunning()
  return GetIsVehicleEngineRunning(self.Handle)
end

--- Gets if the primary color is custom
---@return boolean
function StaxVehicle:IsPrimaryColorCustom()
  return GetIsVehiclePrimaryColourCustom(self.Handle)
end

--- Gets if the secondary color is custom
---@return boolean
function StaxVehicle:IsSecondaryColorCustom()
  return GetIsVehicleSecondaryColourCustom(self.Handle)
end

--- Gets the ped inside the vehicle seat
---@param seat StaxVehicleSeats
function StaxVehicle:GetPedInSeat(seat)
  local handle = GetPedInVehicleSeat(self.Handle, seat)

  --- RETURN PED CLASS INSTANCE
end

--- Gets the last ped inside the vehicle seat
---@param seat StaxVehicleSeats
function StaxVehicle:GetLastPedInSeat(seat)
  local handle = GetLastPedInVehicleSeat(self.Handle, seat)

  --- RETURN PED CLASS INSTANCE
end

--- Gets the vehicles body health
---@return number
function StaxVehicle:GetBodyHealth()
  return GetVehicleBodyHealth(self.Handle)
end

--- Gets the vehicle current clutch state
---@return number
function StaxVehicle:GetClutch()
  return GetVehicleClutch(self.Handle)
end

--- Gets the vehicles colors
---@return number, number
function StaxVehicle:GetColors()
  return GetVehicleColours(self.Handle)
end

function StaxVehicle:GetCurrentGear()

end

function StaxVehicle:GetCurrentRPM()

end

function StaxVehicle:GetCustomPrimaryColor()

end

function StaxVehicle:GetCustomSecondaryColor()

end

function StaxVehicle:GetDashboardBoost()

end

function StaxVehicle:GetDashboardColor()

end

function StaxVehicle:GetDashboardFuel()

end

function StaxVehicle:GetDashboardLights()
  
end

function StaxVehicle:GetDashboardOilPressure()

end

function StaxVehicle:GetDashboardOilTemp()

end

function StaxVehicle:GetDashboardRPM()

end

function StaxVehicle:GetDashboardSpeed()

end

function StaxVehicle:GetDashboardTemp()

end

function StaxVehicle:GetDashboardVacuum()

end

function StaxVehicle:GetDashboardWaterTemp()

end

function StaxVehicle:GetDirtLevel()

end

function StaxVehicle:GetDoorLockState()

end

function StaxVehicle:GetDoorStatus()

end

function StaxVehicle:GetDoorsLockedForPlayers()

end

function StaxVehicle:GetDrawnWheelAngleMult()

end

function StaxVehicle:GetEngineHealth()

end

function StaxVehicle:GetEngineTemperature()

end

function StaxVehicle:GetExtraColors()

end

function StaxVehicle:GetFlightNozzlePosition()

end

function StaxVehicle:GetFuelLevel()

end

function StaxVehicle:GetGravityAmount()

end

function StaxVehicle:GetHandbrake()

end

function StaxVehicle:GetHandlingFloat()

end

function StaxVehicle:GetHandlingInt()

end

function StaxVehicle:GetHandlingVector()

end

function StaxVehicle:GetHeadlightsColor()

end

function StaxVehicle:GetHighGear()

end

function StaxVehicle:HomingLockonState()

end

function StaxVehicle:GetIndicatorLights()

end

function StaxVehicle:GetInteriorColor()

end

function StaxVehicle:GetLightMult()

end

function StaxVehicle:GetLightsState()

end

function StaxVehicle:GetLivery()

end

function StaxVehicle:GetLockonTarget()

end

function StaxVehicle:GetNextGear()

end

function StaxVehicle:GetNumberOfWheels()

end

function StaxVehicle:GetPlateText()

end

function StaxVehicle:GetPlateTextIndex()

end

function StaxVehicle:GetOilLevel()

end

function StaxVehicle:GetFuelTankHealth()

end

function StaxVehicle:GetRadioStationIndex()

end

function StaxVehicle:GetRoofLivery()

end

function StaxVehicle:GetSteeringAngle()

end

function StaxVehicle:GetSteeringScale()

end

function StaxVehicle:GetThrottleOffset()

end

function StaxVehicle:GetTopSpeedModifier()

end

function StaxVehicle:GetTurboPressure()

end

function StaxVehicle:GetType()

end

function StaxVehicle:GetTireSmokeColor()

end

function StaxVehicle:GetWheelBrakePressure()

end

function StaxVehicle:GetWheelFlags()

end

function StaxVehicle:GetWheelHealth()

end

function StaxVehicle:GetWheelIsPowered()

end

function StaxVehicle:GetWheelPower()

end

function StaxVehicle:GetWheelRimColliderSize()

end

function StaxVehicle:GetWheelRotationSpeed()

end

function StaxVehicle:GetWheelSize()

end

function StaxVehicle:GetWheelSpeed()

end

function StaxVehicle:GetWheelSurfaceMaterial()

end

function StaxVehicle:GetWheelSuspensionCompression()

end

function StaxVehicle:GetWheelTractionVectorLength()

end

function StaxVehicle:GetWheelType()

end

function StaxVehicle:GetWheelWidth()

end

function StaxVehicle:GetWheelXOffset()

end

function StaxVehicle:GetWheelYRotation()

end

function StaxVehicle:GetWheelieState()

end

function StaxVehicle:GetWindowTint()

end

function StaxVehicle:GetXenonLightCustomColor()

end

function StaxVehicle:HasBeenOwnedByPlayer()

end

function StaxVehicle:IsAlarmSet()

end

function StaxVehicle:IsEngineStarting()

end

function StaxVehicle:IsExtraTurnedOn()

end

function StaxVehicle:IsInteriorLightOn()

end

function StaxVehicle:DoesNeedHotwired()

end

function StaxVehicle:IsPreviouslyOwnedByPlayer()

end

function StaxVehicle:IsSirenOn()

end

function StaxVehicle:IsTireBursted()

end

function StaxVehicle:IsVehicleWanted()

end

function StaxVehicle:SetHandlingField()

end

function StaxVehicle:SetHandlingFloat()

end

function StaxVehicle:SetHandlingInt()

end

function StaxVehicle:SetHandlingVector()

end

function StaxVehicle:SetPedInSeat()

end

function StaxVehicle:SetVehicleAlarm()

end

function StaxVehicle:SetAlarmTimeLeft()

end

function StaxVehicle:SetAutoRepairDisabled()

end

function StaxVehicle:SetBodyHealth()

end

function StaxVehicle:SetClutch()

end

function StaxVehicle:SetColorCombination()

end

function StaxVehicle:SetVehicleColors()

end

function StaxVehicle:SetCurrentRPM()

end

function StaxVehicle:SetCustomPrimaryColor()

end

function StaxVehicle:SetCustomSecondaryColor()

end

function StaxVehicle:SetDirtLevel()

end

function StaxVehicle:SetDoorBroken()

end

function StaxVehicle:SetDoorsLocked()

end

function StaxVehicle:SetEngineTemperature()

end

function StaxVehicle:SetFuelLevel()

end

function StaxVehicle:SetGravityAmount()

end

function StaxVehicle:SetHighGear()

end

function StaxVehicle:SetPlateText()

end

function StaxVehicle:SetOilLevel()

end

function StaxVehicle:SetSteeringAngle()

end

function StaxVehicle:SetSteeringScale()

end

function StaxVehicle:SetSuspensionHeight()

end

function StaxVehicle:SetTurboPressure()

end

function StaxVehicle:SetWheelBrakePressure()

end

function StaxVehicle:SetWheelFlags()

end

function StaxVehicle:SetWheelHealth()

end

function StaxVehicle:SetWheelIsPowered()

end

function StaxVehicle:SetWheelPower()

end

function StaxVehicle:SetWheelRimColliderSize()

end

function StaxVehicle:SetWheelRotationSpeed()
  
end

function StaxVehicle:SetWheelSize()

end

function StaxVehicle:SetWheelTireColliderSize()

end

function StaxVehicle:SetWheelTireColliderWidth()

end

function StaxVehicle:SetWheelTractionVectorLength()

end

function StaxVehicle:SetWheelwidth()

end

function StaxVehicle:SetWheelXOffset()

end

function StaxVehicle:SetWheelYRotation()

end

function StaxVehicle:SetWheelieState()

end

function StaxVehicle:SetXenonLightsCustomColor()

end

function StaxVehicle:BlipSiren()

end

function StaxVehicle:EnableExhaustPops()

end

function StaxVehicle:ForceEngineAudio()

end

function StaxVehicle:GetDefaultHorn()

end

function StaxVehicle:GetDefaultHornIgnoreMods()

end

function StaxVehicle:GetDefaultHornVariation()

end

function StaxVehicle:IsHornActive()

end

function StaxVehicle:IsPlayerRadioEnabled()
  
end

function StaxVehicle:IsAudiblyDamaged()

end

function StaxVehicle:IsRadioEnabled()

end

function StaxVehicle:IsRadioLoud()

end

function StaxVehicle:OverrideHorn()

end

function StaxVehicle:PlayStream()

end

function StaxVehicle:PlayDoorCloseSound()

end

function StaxVehicle:PlayDoorOpenSound()

end

function StaxVehicle:PreloadAudio()

end

function StaxVehicle:SetAudioPriority()

end

function StaxVehicle:SetAudioBodyDamageFactor()

end

function StaxVehicle:SetAudioEngineDamageFactor()

end

function StaxVehicle:SetBoostActive()

end

function StaxVehicle:SetHornVariation()

end

function StaxVehicle:SetRadioEnabled()

end

function StaxVehicle:SetRadioLoud()

end

function StaxVehicle:SetStartupRevSound()

end

function StaxVehicle:SoundHornThisFrame()

end

function StaxVehicle:TriggerSiren()

end

