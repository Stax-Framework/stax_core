StaxPed = {}
StaxPed.__index = StaxPed

function StaxPed.New(handle)
  local newPed = {}
  setmetatable(newPed, StaxPed)

  newPed.IsServer = IsDuplicityVersion()
  newPed.Handle = handle

  return newPed
end

function StaxPed.Create()

end