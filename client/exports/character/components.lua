local Components = {}

Components["face"] = 0
Components["mask"] = 1
Components["hair"] = 2
Components["torso"] = 3
Components["legs"] = 4
Components["bags"] = 5
Components["shoes"] = 6
Components["accessories"] = 7
Components["undershirts"] = 8
Components["kevlar"] = 9
Components["badges"] = 10
Components["torso_2"] = 11

-- FUNCTIONS
local function GetComponents()
  return Components
end

local function GetComponent(component --[[ string ]])
  return Components[component]
end

-- EXPORTS
exports("GetComponents", GetComponents)
exports("GetComponent", GetComponent)