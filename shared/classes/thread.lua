StaxThread = {}
StaxThread.__index = StaxThread

function StaxThread.New(handler --[[ function ]], looped --[[ boolean ]], ms --[[ number ]])
  if type(handle) ~= "function" then return end
  if type(looped) ~= "boolean" then looped = false end
  if type(ms) ~= "number" then ms = 0 end

  local thread = { state = "running" }
  
  setmetatable(thread, StaxThread)

  Citizen.CreateThread(function()
    if looped then
      if thread.state == "running" then
        handler()
      elseif thread.state == "destroyed" then
        return
      end
    else
      handler()
      thread.state = "destroyed"
    end
  end)

  return thread
end

function StaxThread:Pause()
  if self.state == "destroyed" then return end
  self.state = "paused"
end

function StaxThread:Resume()
  if self.state == "destroyed" then return end
  self.state = "running"
end

function StaxThread:Destroy()
  if self.state == "destroyed" then return end
  self.state = "destroyed"
end

function StaxThread:Status()
  return self.state
end