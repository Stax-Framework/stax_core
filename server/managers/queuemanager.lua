StaxQueueManager = {}
StaxQueueManager.CurrentPlayerCount = 8
StaxQueueManager.Queued = {}

--- Inserts a player into the connection queue
---@param source number
---@param update function
---@param connect function
function StaxQueueManager:Insert(source, update, connect)
  table.insert(self.Queued, { source = source, update = update, connect = connect })
end

--- Removes a player from the connection queue
---@param source number
function StaxQueueManager:Remove(source)
  local slot, player = self:GetPlayerQueue(source)
  table.remove(self.Queued, slot, 1)
  self:UpdatePlayerMessages()
end

--- Gets the player that is in the queue
function StaxQueueManager:GetPlayerQueue(source)
  for k, v in pairs(self.Queued) do
    if v.source == source then
      return k, v
    end
  end
end

function StaxQueueManager:CanPlayerJoin()
  local maxPlayers = Config:Get("queue.max_server_players")

  if self.CurrentPlayerCount >= maxPlayers then
    return false
  end

  return true
end

--- Updates the players queue placement message
function StaxQueueManager:UpdatePlayerMessages()
  if #self.Queued > 0 then
    for placement, v in pairs(self.Queued) do
      local message = StaxString.Interpolate(Locale:Get("connecting_queue_placement"), {
        place = placement,
        amount = #self.Queued
      })
      v.update(message)
    end
  end
end

function StaxQueueManager:PlayerJoined()
  self.CurrentPlayerCount = self.CurrentPlayerCount + 1
  self:UpdatePlayerMessages()
end

function StaxQueueManager:PlayerLeft()
  self.CurrentPlayerCount = self.CurrentPlayerCount - 1
  self:UpdatePlayerMessages()
end

Citizen.CreateThread(function()
  while true do
    local playersToRemove = {}

    for _, v in pairs(StaxQueueManager.Queued) do
      local name = GetPlayerName(v.source)

      if not name then
        --- Player has disconnected from the queue
        playersToRemove[#playersToRemove + 1] = v.source
      end
    end

    if #playersToRemove > 0 then
      for a = 1, #playersToRemove do
        StaxQueueManager:Remove(playersToRemove[a])
      end
    end

    StaxQueueManager:UpdatePlayerMessages()

    Citizen.Wait(5000)
  end
end)