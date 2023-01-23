
-- FUNCTIONS

--- Copy's a table into a new table
---@param t table
---@return table
local function CopyTable(t)
  local newTable = {}

  for k, v in pairs(t) do
    newTable[k] = v
  end

  return newTable
end

-- EXPORTS
exports("Table_Copy", CopyTable)