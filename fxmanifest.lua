-- CREATED BY Xander1998

fx_version 'cerulean'

game 'gta5'

description 'DeadZone Core'

version '1.0.0'

author 'Xander1998'

shared_scripts {
  "shared/classes/*.lua",
  "shared/exports/*.lua",
  "shared/config.lua",
  "shared/locale.lua"
}

client_scripts {
  "client/baseevents.lua",
  "client/exports/player.lua",
  "client/exports/character/*.lua",
  "client/client.lua"
}

server_scripts {
  "server/baseevents.lua",
  "server/exports/*.lua",
  "server/classes/player.lua",
  "server/managers/playermanager.lua",
  "server/managers/servermanager.lua",
  "server/migrations.lua",
  "server/database.lua",
  "server/server.lua"
}

lua54 'yes'