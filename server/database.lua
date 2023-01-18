local resources = CoreConfig.DatabaseResources

Citizen.CreateThread(function()
  Citizen.Wait(5000)

  print("Starting Database Migrations")
  StartQueryProcess()
end)

function StartQueryProcess()
  print("Starting Database Migrations For [" .. resources[1] .. "]!")
  TriggerEvent("STAX::Core::Server::CreateDatabaseTables", resources[1], function(queries)
    for a = 1, #queries do
      if queries[a].table then
        print("Inserting Query Table")
        exports.ExternalSQL:AsyncQuery({
          query = queries[a].table.query,
          data = queries[a].table.data
        })
        print("Inserted Query Table")
      end

      if queries[a].items then
        print("Inserting Query Items")
        for b = 1, #queries[a].items do
          if queries[a].items.data then
            if #queries[a].items.data > 0 then
              for c = 1, #queries.items.data do
                exports.ExternalSQL:AsyncQuery({
                  query = queries[a].items[b].query,
                  data = queries[a].items[b].data[c]
                })
              end
            end
          end
        end
        print("Inserted Query Items")
      end
    end

    table.remove(resources, 1)

    if #resources > 0 then
      StartQueryProcess()
    else
      StaxServerManager:SetReadyState("DatabaseReady", true)
    end
  end)
end