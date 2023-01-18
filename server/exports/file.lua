function LoadFile(directory --[[ string ]], file --[[ string ]])
  local f = io.open(directory .. file, "r")
  local fData = f:read("*a")
  f:close()
  return fData or nil
end

exports("File_Load", LoadFile)