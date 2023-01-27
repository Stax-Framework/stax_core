---@class Array<T>: { [integer]: T }

---@class StaxGamePool
---@field private Pool table Table that stores the game pool data
StaxGamePool = {}
StaxGamePool.__index = StaxGamePool

--- Creates a new instance of StaxGamePool
---@param poolType StaxPoolTypes
---@return StaxGamePool | nil
function StaxGamePool.New(poolType)
  local newPool = {}
  setmetatable(newPool, StaxGamePool)
  
  local entities = GetGamePool(poolType)
  if #entities <= 0 then
    return nil
  end

  newPool.Type = poolType
  newPool.Pool = {}

  if poolType == StaxPoolTypes.CVehicle then
    for a = 1, #entities do
      newPool.Pool[entities[a]] = StaxVehicle.New(entities[a])
    end
  elseif poolType == StaxPoolTypes.CPed then
    for a = 1, #entities do
      newPool.Pool[entities[a]] = StaxPed.New(entities[a])
    end
  elseif poolType == StaxPoolTypes.CPickup then
    exports.stax_core:LogError("StaxGamePool couldn't be created", "[PoolType]: " .. tostring(poolType) .. " not supported yet.")
    return nil
  elseif poolType == StaxPoolTypes.CVehicle then
    exports.stax_core:LogError("StaxGamePool couldn't be created", "[PoolType]: " .. tostring(poolType) .. " not supported yet.")
    return nil
  else
    exports.stax_core:LogError("StaxGamePool couldn't be created", "[PoolType]: " .. tostring(poolType))
    return nil
  end

  return newPool
end

--- Gets an entity from the pool
---@generic T
---@param handle number The handle of the entity you are trying to get
---@return T
function StaxGamePool:Get(handle)
  return self.Pool[handle]
end

--- Gets an entity from the pool
---@generic T
---@return T[]
function StaxGamePool:GetAll()
  return self.Pool
end