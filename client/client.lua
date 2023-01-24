local firstSpawn = true

AddEventHandler("playerSpawned", function(spawnData)
  FirstSpawn()
end)

Citizen.CreateThread(function()
  local player = PlayerId()

  -- COMMENTING OUT UNTIL CLIENT SIDE PLUGINS ARE SET
  -- while true do

  --   SetPlayerHealthRechargeLimit(player, 0.0)

  --   if not CoreConfig.EnableAI then
  --     DisableAI()
  --   end

  --   if CoreConfig.DisabledWanted then
  --     DisableWantedLevel(player)
  --   end

  --   Citizen.Wait(0)
  -- end
end)

function FirstSpawn()
  if firstSpawn then
    SetNuiFocus(false, false)

      -- COMMENTING OUT UNTIL CLIENT SIDE PLUGINS ARE SET
    -- if CoreConfig.EnablePVP then
    --   EnablePVP()
    -- end

    exports.spawnmanager:spawnPlayer()
    exports.spawnmanager:setAutoSpawn(false)

    TriggerServerEvent("STAX::Core::Server::PlayerFirstSpawned")
    firstSpawn = false
  end
end

function EnablePVP()
  SetCanAttackFriendly(PlayerPedId(), true, false)
  NetworkSetFriendlyFireOption(true)
end

function DisableAI()
  SetPedDensityMultiplierThisFrame(0.0)
  SetVehicleDensityMultiplierThisFrame(0.0)
  SetParkedVehicleDensityMultiplierThisFrame(0.0)
end

function DisableWantedLevel(player --[[ number ]])
  if GetPlayerWantedLevel(player) ~= 0 then
    SetPoliceIgnorePlayer(player, true)
    SetDispatchCopsForPlayer(player, false)
    SetPlayerWantedLevel(player, 0, false)
    SetPlayerWantedLevelNow(player, false)
  end
end