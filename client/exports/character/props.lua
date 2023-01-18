local Props = {}

Props["hats"] = 0
Props["glasses"] = 1
Props["ears"] = 2
Props["watches"] = 6
Props["bracelets"] = 7

-- FUNCTIONS
function GetProps()
  return Props
end

function GetProp(prop --[[ string ]])
  return Props[prop]
end

-- EXPORTS
exports("GetProps", GetProps)
exports("GetProp", GetProp)