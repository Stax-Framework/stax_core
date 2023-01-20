local FaceFeatures = {}

FaceFeatures["nose_width"] = 0
FaceFeatures["nose_peak_height"] = 1
FaceFeatures["nose_peak_length"] = 2
FaceFeatures["nose_bone_height"] = 3
FaceFeatures["nose_peak_lowering"] = 4
FaceFeatures["nose_bone_twist"] = 5
FaceFeatures["eyebrow_height"] = 6
FaceFeatures["eyebrow_forward"] = 7
FaceFeatures["cheek_bone_height"] = 8
FaceFeatures["cheek_bone_width"] = 9
FaceFeatures["cheek_width"] = 10
FaceFeatures["eye_openings"] = 11
FaceFeatures["lip_thickness"] = 12
FaceFeatures["jaw_bone_width"] = 13
FaceFeatures["jaw_bone_length"] = 14
FaceFeatures["chin_bone_lowering"] = 15
FaceFeatures["chin_bone_length"] = 16
FaceFeatures["chin_bone_width"] = 17
FaceFeatures["chin_hole"] = 18
FaceFeatures["neck_thickness"] = 19

-- FUNCTIONS
local function GetFaceFeatures()
  return FaceFeatures
end

local function GetFaceFeature(feature --[[ string ]])
  return FaceFeatures[feature]
end

-- EXPORTS
exports("GetFaceFeatures", GetFaceFeatures)
exports("GetFaceFeature", GetFaceFeature)