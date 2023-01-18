local Overlays = {}

Overlays["blemishes"] = 0
Overlays["facial_hair"] = 1
Overlays["eyebrows"] = 2
Overlays["ageing"] = 3
Overlays["makeup"] = 4
Overlays["blush"] = 5
Overlays["complexion"] = 6
Overlays["sun_damage"] = 7
Overlays["lipstick"] = 8
Overlays["moles_freckles"] = 9
Overlays["chest_hair"] = 10
Overlays["body_blemishes"] = 11
Overlays["add_body_blemishes"] = 12

-- FUNCTIONS
function GetOverlays()
  return Overlays
end

function GetOverlay(overlay --[[ string ]])
  return Overlays[overlay]
end

-- EXPORTS
exports("GetOverlays", GetOverlays)
exports("GetOverlay", GetOverlay)