local function ScanDirectory(directory --[[ string ]])
  local i, t, popen = 0, {}, io.popen
  for filename in popen('dir "' .. directory .. '" /b'):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end

exports("Directory_Scan", ScanDirectory)