--[[ Created By Xander1998 ]]--

fx_version 'cerulean'

game 'gta5'

description 'STAX Core'

version '1.0.0'

author 'Xander1998'

shared_scripts {
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
  "@stax_database/classes/query.lua",
  
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
  description = "Stax Framework Core"
}