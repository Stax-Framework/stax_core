--[[ Created By Xander1998 ]]--

fx_version 'cerulean'

game 'gta5'

description 'STAX Core'

version '1.0.0'

author 'Xander1998'

shared_scripts {
  --- IMPORTS
  "@stax_libs/[core]/stax_core/shared/stax.lua",
  "@stax_lobs/[core]/stax_core/shared/classes/singletons/string.lua",
  "@stax_lobs/[core]/stax_core/shared/classes/singletons/class.lua",
  "@stax_lobs/[core]/stax_core/shared/classes/singletons/events.lua",
  "@stax_lobs/[core]/stax_core/shared/classes/singletons/logger.lua",
  "@stax_lobs/[core]/stax_core/shared/classes/singletons/table.lua",
  "@stax_lobs/[core]/stax_core/shared/classes/config.lua",
  "@stax_lobs/[core]/stax_core/shared/classes/locale.lua"
}

client_scripts {
  "client/client.lua"
}

server_scripts {
  --- IMPORTS
  "@stax_libs/[core]/stax_database/database.lua",
  "@stax_libs/[core]/stax_core/server/classes/singletons/file.lua",
  "@stax_libs/[core]/stax_core/server/classes/singletons/file.lua",
  "@stax_libs/[core]/stax_core/server/classes/singletons/managers/playermanager.lua",
  "@stax_libs/[core]/stax_core/server/classes/singletons/managers/pluginmanager.lua",
  "@stax_libs/[core]/stax_core/server/classes/plugin.lua",
  "@stax_libs/[core]/stax_core/server/classes/player.lua",
  "@stax_libs/[core]/stax_core/server/classes/user.lua",

  --- SCRIPTS
  "server/managers/playermanager.lua",
  "server/managers/pluginmanager.lua",
  "server/managers/queuemanager.lua",
  "server/managers/servermanager.lua",
  "server/baseevents.lua",
  "server/server.lua"
}

lua54 'yes'

--[[ STAX METADATA ]]--
stax_plugin "stax-core" {
  name = "Stax Core",
  description = "Stax Framework Core"
}