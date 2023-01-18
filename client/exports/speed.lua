-- FUNCTIONS
function ConvertToMPH(speed --[[ number ]])
  return speed * 2.23694
end

function ConvertToKMH(speed --[[ number ]])
  return speed * 3.6
end

-- EXPORTS
exports("ConvertToMPH", ConvertToMPH)
exports("ConvertToKMH", ConvertToKMH)