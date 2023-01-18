local characterSets = {
  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
  "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
}

-- FUNCTIONS
function StringInterpolate(str --[[ string ]], data --[[ table ]])
  for k, v in pairs(data) do
    str = string.gsub(str, "{" .. k .. "}", v)
  end
  return str
end

function StringSplit(str --[[ string ]], sep --[[ string ]])
  local result = {}
  if sep == nil then sep = "%s" end
  for match in string.match(str, "([^" .. sep .. "]+)") do
    table.insert(result, match)
  end
  return result
end

function FormatIndex(index --[[ string ]])
  return string.lower(index):gsub(" ", "_")
end

function RandomString(iterations --[[ number ]])
  math.randomseed(GetGameTimer())
  local str = {}

  for a = 1, iterations do
    table.insert(str, characterSets[math.random(1, #characterSets)])
  end

  return table.concat(str, "")
end

function StripInvalidCharacters(str --[[ string ]])
  return str:gsub("%W", "")
end

-- EXPORTS
exports("String_Interpolate", StringInterpolate)
exports("String_Split", StringSplit)
exports("String_FormatIndex", FormatIndex)
exports("String_RandomString", RandomString)
exports("String_StripInvalidCharacters", StripInvalidCharacters)