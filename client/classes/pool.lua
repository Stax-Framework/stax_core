---@class StaxGamePool
---@field private Pool table Table that stores the game pool data
StaxGamePool = {}
StaxGamePool.__index = StaxGamePool

--- Creates a new instance of StaxGamePool
---@param pool StaxPoolTypes The pool type you are trying to access
---@generic T
---@return StaxGamePool
function StaxGamePool.New(pool)
  local newPool = {}
  setmetatable(newPool)
  
  newPool.Pool = {}

  return newPool
end

function StaxGamePool:Get()

end