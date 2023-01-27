---@class StaxVector3
StaxVector3 = {}
StaxVector3.__index = StaxVector3

--- Creates a new instance of StaxVector2
---@param vector table<{ x: number, y: number, z: number }> Requires a table with an `x`, `y` and `z` value
function StaxVector3.New(vector)
  local newVector3 = {}
  setmetatable(newVector2, StaxVector3)

  
  return newVector3
end