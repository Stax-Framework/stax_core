
-- FUNCTIONS
function CopyTable(t --[[ table ]])
  local newTable = {}

  for k, v in pairs(t) do
    newTable[k] = v
  end

  return newTable
end

-- EXPORTS
exports("Table_Copy", CopyTable)