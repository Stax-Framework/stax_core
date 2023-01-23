--- Scans directory for files
---@param directory string
---@return table<string>
local function ScanDirectory(directory)
  local i, t, popen = 0, {}, io.popen
  for filename in popen('dir "' .. directory .. '" /b'):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end

exports("Directory_Scan", ScanDirectory)