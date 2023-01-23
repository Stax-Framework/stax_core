---@class StaxThread
---@field public state string
StaxThread = {}
StaxThread.__index = StaxThread

--- Creates new instance of StaxThread
---@param handler function
---@param looped boolean
---@param ms number
function StaxThread.New(handler, looped, ms)
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

--- Pauses the current instance's thread
function StaxThread:Pause()
  if self.state == "destroyed" then return end
  self.state = "paused"
end

--- Resumes the current instance's thread
function StaxThread:Resume()
  if self.state == "destroyed" then return end
  self.state = "running"
end

--- Destroys the current instance's thread
function StaxThread:Destroy()
  if self.state == "destroyed" then return end
  self.state = "destroyed"
end

--- Gets the current instance's thread status
---@return string
function StaxThread:Status()
  return self.state
end