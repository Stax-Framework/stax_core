---@class StaxVector2
StaxVector2 = {}
StaxVector2.__index = StaxVector2

--- Creates a new instance of StaxVector2
---@param vector table<{ x: number, y: number }> Requires a table with an `x` and a `y` value
function StaxVector2.New(vector)
  local newVector2 = {}
  setmetatable(newVector2, StaxVector2)

  
  return newVector2
end