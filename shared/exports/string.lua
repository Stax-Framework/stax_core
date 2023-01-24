local characterSets = {
  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
  "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
}

-- FUNCTIONS

--- Interpolates and concatenate's data into a string
---@param str string
---@param data table
---@return string
local function StringInterpolate(str, data)
  for k, v in pairs(data) do
    str = string.gsub(str, "{" .. k .. "}", v)
  end
  return str
end

--- Splits string into a table based on a seperator
---@param passed string
---@param sep string
---@return table
local function StringSplit(passed, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(passed, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

--- Formats a string into an index value
---@param str string
---@return string
local function FormatIndex(str)
  local index = string.lower(index):gsub(" ", "_")
  return index
end

--- Generates a random string at a specific length
---@param iterations number
---@return string
local function RandomString(iterations)
  math.randomseed(GetGameTimer())
  local str = {}

  for a = 1, iterations do
    table.insert(str, characterSets[math.random(1, #characterSets)])
  end

  return table.concat(str, "")
end

--- Strips string of invalid character
---@param str string
---@return string
local function StripInvalidCharacters(str)
  local strippedString = str:gsub("%W", "")
  return strippedString
end

-- EXPORTS
exports("String_Interpolate", StringInterpolate)
exports("String_Split", StringSplit)
exports("String_FormatIndex", FormatIndex)
exports("String_RandomString", RandomString)
exports("String_StripInvalidCharacters", StripInvalidCharacters)