--- Loads file from a directory
---@param directory string
---@param file string
---@return string | nil
local function LoadFile(directory, file)
  local f = io.open(directory .. file, "r")
  if not f then return nil end

  local fData = f:read("*a")
  f:close()
  return fData or nil
end

exports("File_Load", LoadFile)