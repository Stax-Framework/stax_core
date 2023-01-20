-- FUNCTIONS
local function ConvertToMPH(speed --[[ number ]])
  return speed * 2.23694
end

local function ConvertToKMH(speed --[[ number ]])
  return speed * 3.6
end

-- EXPORTS
exports("ConvertToMPH", ConvertToMPH)
exports("ConvertToKMH", ConvertToKMH)