local function LogSuccess(action, message)
  local msg = exports.stax_core:String_Interpolate("^4[STAX] :: ^9SUCCESS ^0:: ^9{action}^0 :: ^3{message}", {
    action = action,
    message = message
  })

  print(msg)
end

local function LogError(action, message)
  local msg = exports.stax_core:String_Interpolate("^4[STAX] :: ^8ERROR ^0:: ^8{action}^0 :: ^3{message}", {
    action = action,
    message = message
  })

  print(msg)
end

local function LogWarning(action, message)
  local msg = exports.stax_core:String_Interpolate("^4[STAX] :: ^1WARNING ^0:: ^1{action}^0 :: ^3{message}", {
    action = action,
    message = message
  })

  print(msg)
end

--exports.stax_core:String_Interpolate(string, table)

exports("Logger_LogSuccess", LogSuccess)
exports("Logger_LogError", LogError)
exports("Logger_LogWarning", LogWarning)