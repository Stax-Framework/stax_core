local secondsCalcs = {
  year = 31536000,
  month = 2592000,
  week = 604800,
  day = 86400,
  hour = 3600,
  minute = 60,
  second = 1
}

StaxDateTime = {}
StaxDateTime.__index = StaxDateTime

function StaxDateTime.New(number)
  local newDateTime = {}
  setmetatable(newDateTime, StaxDateTime)

  newDateTime.time = os.date("*t", number)

  return newDateTime
end

function StaxDateTime.Now()
  local newDateTime = {}
  setmetatable(newDateTime, StaxDateTime)

  newDateTime.time = os.date("*t")

  return newDateTime
end

function StaxDateTime:Add(timeObject, setTime)
  local seconds = 0

  if timeObject then
    for k1, v1 in pairs(timeObject) do
      for k2, v2 in pairs(secondsCalcs) do
        if k1 == k2 then
          local calcedSeconds = v1 * v2
          seconds = seconds + calcedSeconds
        end
      end
    end
  end

  local newTime = os.date("*t", os.time(self.time) + seconds)

  if setTime then
    self.time = newTime
  end

  return newTime
end

function StaxDateTime:Subtract(timeObject, setTime)
  local seconds = 0

  if timeObject then
    for k1, v1 in pairs(timeObject) do
      for k2, v2 in pairs(secondsCalcs) do
        if k1 == k2 then
          local calcedSeconds = v1 * v2
          seconds = seconds + calcedSeconds
        end
      end
    end
  end

  local newTime = os.date("*t", os.time(self.time) - seconds)

  if setTime then
    self.time = newTime
  end

  return newTime
end

function StaxDateTime:Compare(dateTime)
  local time1 = os.time(self.time)
  local time2 = os.time(dateTime.time)
  local difference = os.difftime(time1, time2)
  return difference
end

function StaxDateTime:GetOSTime()
  return os.time(self.time)
end