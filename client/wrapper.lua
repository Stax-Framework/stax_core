StaxWrapper = {}

--- Calls an exports from a script
---@generic T
---@return T
function StaxWrapper.CallExport(resource)
  return exports[resource]
end

function StaxWrapper.TriggerEvent()

end

function StaxWrapper.TriggerServerEvent()

end