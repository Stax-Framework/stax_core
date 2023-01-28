--[[ Created By Xander1998 ]]--

fx_version 'cerulean'

game 'gta5'

description 'STAX Core'

version '1.0.0'

author 'Xander1998'

shared_scripts {
  "@stax_fivem/stax_core/shared/classes/singletons/logger.lua",
  "@stax_fivem/stax_core/shared/classes/singletons/string.lua",
  "@stax_fivem/stax_core/shared/classes/singletons/table.lua",
  "@stax_fivem/stax_core/shared/classes/config.lua",
  "@stax_fivem/stax_core/shared/classes/locale.lua",

  "shared/classes/*.lua",
  "shared/exports/*.lua"
}

client_scripts {
  "client/baseevents.lua",
  "client/exports/player.lua",
  "client/exports/character/*.lua",
  "client/client.lua"
}

server_scripts {
  -- Dependencies
  "@stax_fivem/stax_database/server/classes/query.lua",
  "@stax_fivem/stax_core/server/classes/plugin.lua",
  "@stax_fivem/stax_core/server/classes/singletons/directory.lua",
  
  -- Scripts
  "server/baseevents.lua",
  "server/exports/*.lua",
  "server/classes/player.lua",
  "server/classes/plugin.lua",
  "server/managers/playermanager.lua",
  "server/managers/servermanager.lua",
  "server/managers/pluginmanager.lua",
  "server/migrations.lua",
  "server/server.lua"
}

lua54 'yes'

--[[ STAX METADATA ]]--
stax_plugin "stax-core" {
  name = "Stax Core",
  description = "Stax Framework Core",
  dependencies = { "stax-fivem" }
}